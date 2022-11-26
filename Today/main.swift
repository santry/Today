import AppKit
let app: NSApplication = NSApplication.shared
let appDelegate = AppDelegate()
app.delegate = appDelegate
_ = NSApplicationMain(CommandLine.argc, CommandLine.unsafeArgv)
