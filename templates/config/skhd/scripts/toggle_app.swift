import AppKit

let id = CommandLine.arguments.dropFirst().first ?? ""
let ws = NSWorkspace.shared

if let front = ws.frontmostApplication, front.bundleIdentifier == id {
    front.hide()
    exit(0)
}

if let url = ws.urlForApplication(withBundleIdentifier: id) {
    let cfg = NSWorkspace.OpenConfiguration()
    cfg.activates = true
    let sem = DispatchSemaphore(value: 0)
    ws.openApplication(at: url, configuration: cfg) { _, _ in sem.signal() }
    sem.wait()
}
