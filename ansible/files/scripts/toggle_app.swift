import AppKit

let query = CommandLine.arguments.dropFirst().first ?? ""
let ws = NSWorkspace.shared

if query == "--list" {
    for app in ws.runningApplications where app.activationPolicy == .regular {
        print("\(app.localizedName ?? "?") | \(app.bundleIdentifier ?? "?") | \(app.executableURL?.lastPathComponent ?? "?")")
    }
    exit(0)
}

let q = query.lowercased()

func matches(_ app: NSRunningApplication) -> Bool {
    return app.localizedName?.lowercased() == q
        || app.bundleIdentifier?.lowercased() == q
        || app.executableURL?.lastPathComponent.lowercased() == q
        || app.bundleURL?.deletingPathExtension().lastPathComponent.lowercased() == q
}

if let front = ws.frontmostApplication, matches(front) {
    front.hide()
} else if let app = ws.runningApplications.first(where: { $0.activationPolicy == .regular && matches($0) }) {
    app.unhide()
    app.activate(options: [.activateAllWindows])
} else {
    let isBundleID = query.contains(".") && !query.contains(" ")
    let p = Process()
    p.executableURL = URL(fileURLWithPath: "/usr/bin/open")
    p.arguments = [isBundleID ? "-b" : "-a", query]
    try? p.run()
    p.waitUntilExit()
}