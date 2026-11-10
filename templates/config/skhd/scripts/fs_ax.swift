import Cocoa
import ApplicationServices

guard AXIsProcessTrusted() else {
    _ = AXIsProcessTrustedWithOptions([kAXTrustedCheckOptionPrompt.takeUnretainedValue() as String: true] as CFDictionary)
    exit(1)
}

func axGet<T: BitwiseCopyable>(_ el: AXUIElement, _ attr: String, _ type: AXValueType, _ zero: T) -> T? {
    var r: CFTypeRef?
    guard AXUIElementCopyAttributeValue(el, attr as CFString, &r) == .success else { return nil }
    var v = zero
    AXValueGetValue(r as! AXValue, type, &v)
    return v
}
func axSet<T: BitwiseCopyable>(_ el: AXUIElement, _ attr: String, _ type: AXValueType, _ value: T) {
    var v = value
    AXUIElementSetAttributeValue(el, attr as CFString, AXValueCreate(type, &v)!)
}

guard let app = NSWorkspace.shared.frontmostApplication else { exit(0) }
var w: CFTypeRef?
guard AXUIElementCopyAttributeValue(AXUIElementCreateApplication(app.processIdentifier),
                                    kAXFocusedWindowAttribute as CFString, &w) == .success else { exit(0) }
let win = w as! AXUIElement
guard let pos  = axGet(win, kAXPositionAttribute, .cgPoint, CGPoint.zero),
      let size = axGet(win, kAXSizeAttribute, .cgSize, CGSize.zero) else { exit(0) }

let h = NSScreen.screens[0].frame.height
func ax(_ f: CGRect) -> CGRect { CGRect(x: f.minX, y: h - f.maxY, width: f.width, height: f.height) }

let center = CGPoint(x: pos.x + size.width / 2, y: pos.y + size.height / 2)
let screen = NSScreen.screens.first { ax($0.frame).contains(center) } ?? NSScreen.screens[0]
let fill = ax(screen.frame)   

if abs(size.width - fill.width) < 2 && abs(size.height - fill.height) < 2 { exit(0) }

axSet(win, kAXPositionAttribute, .cgPoint, fill.origin)
axSet(win, kAXSizeAttribute, .cgSize, fill.size)
axSet(win, kAXPositionAttribute, .cgPoint, fill.origin)   
