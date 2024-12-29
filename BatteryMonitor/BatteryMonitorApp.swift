//
//  BatteryMonitorApp.swift
//  BatteryMonitor
//
//  Created by Ivan Pazhitnykh on 29.12.24.
//

import Cocoa

@main
struct BatteryMonitorApp {
    static func main() {
        let delegate = AppDelegate()
        NSApplication.shared.delegate = delegate
        NSApplication.shared.run()
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusItem: NSStatusItem?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        createStatusItem()
    }
    
    func createStatusItem() {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
        
        if let button = statusItem?.button {
            button.image = NSImage(systemSymbolName: "star.fill", accessibilityDescription: "Star")
            button.action = #selector(showMenu)
        }
    }
    
    @objc func showMenu() {
        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "Hello World", action: #selector(sayHello), keyEquivalent: ""))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
        
        statusItem?.menu = menu
    }
    
    @objc func sayHello() {
        let alert = NSAlert()
        alert.messageText = "Hello World!"
        alert.runModal()
    }
}
