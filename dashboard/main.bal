import ballerina/io;
import ballerina/log;

public function main() returns error? {
    log:printInfo("Starting Event Integration Dashboard generation...");

    // Read packages.json configuration
    log:printInfo("Reading packages.json...");
    json packagesJson = check io:fileReadJson("../packages.json");
    PackageConfig config = check packagesJson.cloneWithType(PackageConfig);

    log:printInfo(string `Found ${config.products.length()} products, ${config.modules.length()} modules, ${config.tools.length()} tools`);

    // Initialize GitHub client
    log:printInfo("Initializing GitHub client...");
    GitHubClient github = check initGitHubClient();

    // Fetch product information
    log:printInfo("Fetching product information from GitHub...");
    ProductInfo[] productsInfo = [];
    foreach Product product in config.products {
        log:printInfo(string `  Processing product: ${product.name}`);
        ProductInfo|error info = fetchProductInfo(github, product);
        if info is error {
            log:printError(string `Failed to fetch info for product ${product.name}`, 'error = info);
            continue;
        }
        productsInfo.push(info);
    }

    // Fetch module information
    log:printInfo("Fetching module information from GitHub...");
    ModuleInfo[] modulesInfo = [];
    foreach Module module in config.modules {
        log:printInfo(string `  Processing module: ${module.name}`);
        ModuleInfo|error info = fetchModuleInfo(github, module);
        if info is error {
            log:printError(string `Failed to fetch info for module ${module.name}`, 'error = info);
            continue;
        }
        modulesInfo.push(info);
    }

    // Fetch tool information
    log:printInfo("Fetching tool information from GitHub...");
    ToolInfo[] toolsInfo = [];
    foreach Tool tool in config.tools {
        log:printInfo(string `  Processing tool: ${tool.name}`);
        ToolInfo|error info = fetchToolInfo(github, tool);
        if info is error {
            log:printError(string `Failed to fetch info for tool ${tool.name}`, 'error = info);
            continue;
        }
        toolsInfo.push(info);
    }

    // Generate combined dashboard
    log:printInfo("Generating dashboard markdown...");

    string dashboard = generateDashboard(productsInfo, modulesInfo, toolsInfo);
    check updateDashboardInReadme(dashboard, "../README.md");

    log:printInfo("Dashboard section updated in README.md");
    log:printInfo("Dashboard generation completed successfully!");
}
