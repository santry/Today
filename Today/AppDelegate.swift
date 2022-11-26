import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {

    private let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    private let statusMenu = NSMenu()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        statusMenu.addItem(
            withTitle: "Quit",
            action: #selector(AppDelegate.quit),
            keyEquivalent: "q"
        )
        
        statusItem.menu = statusMenu
        
        self.updateDateDisplay()

        NotificationCenter.default.addObserver(forName: .NSCalendarDayChanged, object: nil, queue: OperationQueue.main) { _ in
            self.updateDateDisplay()
        }
        
        NotificationCenter.default.addObserver(forName: .NSSystemClockDidChange, object: nil, queue: OperationQueue.main) { _ in
            self.updateDateDisplay()
        }
        
        NotificationCenter.default.addObserver(forName: .NSSystemTimeZoneDidChange, object: nil, queue: OperationQueue.main) { _ in
            self.updateDateDisplay()
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
    
    func updateDateDisplay() {
        self.statusItem.button?.image = self.iconImageForText(text: self.getCurrentDayOfMonth())
        self.statusItem.button?.image?.isTemplate = true
    }

    func iconImageForText(text: String) -> NSImage {
        let iconImage = NSImage(size: NSSize(width: 17, height: 17), flipped: false) { rect in
            let pstyle = NSMutableParagraphStyle()
            pstyle.alignment = NSTextAlignment.center
            
            text.draw(
                in: NSOffsetRect(rect, 0, -3),
                withAttributes: [
                    NSAttributedString.Key.font: NSFont.systemFont(ofSize: 11),
                    NSAttributedString.Key.paragraphStyle: pstyle
                ]
            )
            
            NSColor.black.set()
            NSBezierPath(rect: rect).stroke()
            NSBezierPath(rect: NSRect(x: 0, y: 13, width: 17, height: 4)).fill()
            
            return true
        }

        return iconImage
    }
    
    func getCurrentDayOfMonth() -> String {
        return Date.now.formatted(Date.FormatStyle().day(.defaultDigits))
    }
    
    @objc func quit() {
        NSApplication.shared.terminate(nil)
    }
}
