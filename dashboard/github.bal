import ballerina/http;
import ballerina/log;
import ballerina/os;

const string GITHUB_API_URL = "https://api.github.com";

// Initialize GitHub client with authentication
public function initGitHubClient() returns GitHubClient|error {
    string token = os:getEnv("BALLERINA_BOT_TOKEN");
    if token == "" {
        return error("BALLERINA_BOT_TOKEN environment variable not set");
    }

    return check new (GITHUB_API_URL, {
        auth: {
            token: token
        }
    });
}

// Fetch repository information
public function getRepoInfo(GitHubClient github, string org, string repo) returns GitHubRepo|error {
    string path = string `/repos/${org}/${repo}`;
    GitHubRepo response = check github->get(path);
    return response;
}

// Fetch latest release
public function getLatestRelease(GitHubClient github, string org, string repo) returns string|error {
    string path = string `/repos/${org}/${repo}/releases/latest`;
    GitHubRelease|http:ClientError response = github->get(path);

    if response is http:ClientError {
        log:printWarn(string `No release found for ${org}/${repo}`);
        return "N/A";
    }

    return response.tag_name;
}

// Fetch open pull requests count
public function getOpenPRsCount(GitHubClient github, string org, string repo) returns int|error {
    string path = string `/repos/${org}/${repo}/pulls?state=open&per_page=1`;
    http:Response response = check github->get(path);

    string|error? linkHeader = response.getHeader("Link");
    if linkHeader is error || linkHeader is () {
        return 0;
    }

    // Parse Link header to get the last page number
    // Link: <url>; rel="last"
    int count = 0;
    if linkHeader.includes("rel=\"last\"") {
        // Extract page number from link header
        string[] parts = re `page=`.split(linkHeader);
        if parts.length() > 1 {
            string pageStr = re `>`.split(parts[1])[0];
            int|error pageNum = int:fromString(pageStr);
            if pageNum is int {
                count = pageNum;
            }
        }
    }

    return count;
}

// Check if repository has GitHub Actions workflow
public function hasGitHubActions(GitHubClient github, string org, string repo) returns boolean {
    string path = string `/repos/${org}/${repo}/actions/workflows`;
    json|error response = github->get(path);

    if response is error {
        return false;
    }

    if response is map<json> {
        int|error workflowCount = response.total_count.ensureType();
        if workflowCount is int {
            return workflowCount > 0;
        }
    }

    return false;
}

// Fetch product information from GitHub
public function fetchProductInfo(GitHubClient github, Product product) returns ProductInfo|error {
    string githubOrg = product.'github\-org ?: product.org;
    string productRepo = product.'product\-repository ?: string `product-${product.name}`;
    string docsRepo = product.'documentation\-repository ?: string `docs-${product.name}`;
    string helmRepo = product.'helm\-repository ?: string `helm-${product.name}`;

    GitHubRepo repoInfo = check getRepoInfo(github, githubOrg, productRepo);
    string latestRelease = check getLatestRelease(github, githubOrg, productRepo);
    int openPRs = check getOpenPRsCount(github, githubOrg, productRepo);
    boolean hasBuild = hasGitHubActions(github, githubOrg, productRepo);

    return {
        name: product.name,
        org: product.org,
        githubOrg: githubOrg,
        productRepo: productRepo,
        docsRepo: docsRepo,
        helmRepo: helmRepo,
        defaultBranch: repoInfo.default_branch,
        openIssues: repoInfo.open_issues_count,
        openPRs: openPRs,
        latestRelease: latestRelease,
        hasBuild: hasBuild
    };
}

// Fetch module information from GitHub
public function fetchModuleInfo(GitHubClient github, Module module) returns ModuleInfo|error {
    string githubOrg = module.'github\-org ?: "ballerina-platform";
    string moduleRepo = module.'module\-repository ?: string `module-${module.org}-${module.name}`;
    string libraryLabel = module.'library\-label ?: string `module/${module.name}`;
    string biLabel = module.'bi\-label ?: string `eventintegration/${module.name}`;

    GitHubRepo repoInfo = check getRepoInfo(github, githubOrg, moduleRepo);
    string latestRelease = check getLatestRelease(github, githubOrg, moduleRepo);
    int openPRs = check getOpenPRsCount(github, githubOrg, moduleRepo);
    boolean hasBuild = hasGitHubActions(github, githubOrg, moduleRepo);

    return {
        name: module.name,
        org: module.org,
        githubOrg: githubOrg,
        moduleRepo: moduleRepo,
        libraryLabel: libraryLabel,
        biLabel: biLabel,
        defaultBranch: repoInfo.default_branch,
        openIssues: repoInfo.open_issues_count,
        openPRs: openPRs,
        latestRelease: latestRelease,
        hasBuild: hasBuild,
        codeCoverage: () // TODO: Fetch from CodeCov API if needed
    };
}

// Fetch tool information from GitHub
public function fetchToolInfo(GitHubClient github, Tool tool) returns ToolInfo|error {
    string githubOrg = tool.'github\-org ?: "ballerina-platform";
    string toolRepo = tool.'tool\-repository ?: string `${tool.name}-tools`;

    GitHubRepo repoInfo = check getRepoInfo(github, githubOrg, toolRepo);
    string latestRelease = check getLatestRelease(github, githubOrg, toolRepo);
    int openPRs = check getOpenPRsCount(github, githubOrg, toolRepo);
    boolean hasBuild = hasGitHubActions(github, githubOrg, toolRepo);

    return {
        name: tool.name,
        org: tool.org,
        githubOrg: githubOrg,
        toolRepo: toolRepo,
        libraryLabel: tool.'library\-label,
        biLabel: tool.'bi\-label,
        defaultBranch: repoInfo.default_branch,
        openIssues: repoInfo.open_issues_count,
        openPRs: openPRs,
        latestRelease: latestRelease,
        hasBuild: hasBuild
    };
}
