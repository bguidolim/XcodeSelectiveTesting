//
//  Created by Mike Gerasymenko <mike@gera.cx>
//

import SelectiveTestingCore
import ArgumentParser

@main
struct SelectiveTesting: AsyncParsableCommand {
    
    @Argument(help: "Name of the base branch")
    var baseBranch: String = ""
    
    @Argument(help: "Project or workspace path", completion: .file(extensions: ["xcworkspace", "xcodeproj"]))
    var projectWorkspacePath: String = ""
    
    @Argument(help: "Test plan", completion: .none)
    var testPlan: String = ""
    
    @Flag(help: "Use dot-to-ascii.ggerganov.com to render dependency graph in the terminal")
    var renderDependencyGraph: Bool = false
    
    mutating func run() async throws {
        let tool = SelectiveTestingTool(baseBranch: baseBranch,
                                        projectWorkspacePath: projectWorkspacePath,
                                        testPlan: testPlan,
                                        renderDependencyGraph: renderDependencyGraph)

        do {
            let _ = try await tool.run()
        } catch {
            print("Error: \(error)")
        }
    }
}
