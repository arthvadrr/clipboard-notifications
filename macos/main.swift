import Cocoa

class ClipboardObserver: NSObject {
    override init() {
        super.init()
        
        // Register as the observer for clipboard events
        NSPasteboard.general.addObserver(self, forTypes: [.string], owner: nil)
    }
    
    deinit {
        // Unregister the observer before deallocating
        NSPasteboard.general.removeObserver(self)
    }
    
    @objc func clipboardDidChange(_ notification: NSNotification) {
        guard let pasteboard = notification.object as? NSPasteboard else { return }
        
        if let copiedString = pasteboard.string(forType: .string) {
            print("Copied: \(copiedString)")
            fireEvent(event: "ClipboardCopied", data: copiedString)
        }
        
        if let pastedString = NSPasteboard.general.string(forType: .string) {
            print("Pasted: \(pastedString)")
            fireEvent(event: "ClipboardPasted", data: pastedString)
        }
    }
    
    func fireEvent(event: String, data: String) {
        // TODO: Implement your custom logic to handle the fired event
        // For example, you can send the event and data to a server, perform an action, etc.
        print("Fired event '\(event)' with data: \(data)")
    }
}

let observer = ClipboardObserver()
NSApplication.shared.run()
