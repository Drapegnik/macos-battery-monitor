//
//  BatteryMonitorApp.swift
//  BatteryMonitor
//
//  Created by Ivan Pazhitnykh on 29.12.24.
//

import Cocoa
import IOKit.ps

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
    var timer: Timer?
    let lowBatteryThreshold = 5.0 // Set the low battery threshold (5%)
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        createStatusItem()
        startMonitoringBattery()
    }
    
    func createStatusItem() {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        if let button = statusItem?.button {
            button.title = "🔋"
            button.action = #selector(showMenu)
        }
    }
    
    func startMonitoringBattery() {
        timer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { _ in
            self.checkBatteryLevel()
        }
    }
    
    func checkBatteryLevel() {
        let batteryLevel = getBatteryLevel()
        if batteryLevel <= lowBatteryThreshold {
            showLowBatteryWarning(batteryLevel: batteryLevel)
        }
    }
    
    func getBatteryLevel() -> Double {
        let powerSource = IOPSCopyPowerSourcesInfo().takeRetainedValue()
        let powerSources = IOPSCopyPowerSourcesList(powerSource).takeRetainedValue() as [CFTypeRef]
        
        for powerSource in powerSources {
            let description = IOPSGetPowerSourceDescription(powerSource, powerSource).takeUnretainedValue() as! [String: Any]
            if let currentCapacity = description["Current Capacity"] as? Double,
               let maxCapacity = description["Max Capacity"] as? Double {
                return (currentCapacity / maxCapacity) * 100.0
            }
        }
        return 100.0 // Default to 100% if unable to get battery level
    }
    
    func showLowBatteryWarning(batteryLevel: Double) {
        let alert = NSAlert()
        alert.messageText = "Low Battery Level"
        alert.informativeText = "⚠️ Your battery level is \(Int(batteryLevel))%\nPlease plug in your computer ASAP!"
        alert.alertStyle = .warning
        alert.addButton(withTitle: "I understand")
        
        // Set emoji as icon
        let emojiIcon = NSImage(size: NSSize(width: 64, height: 64))
        emojiIcon.lockFocus()
        let attributes: [NSAttributedString.Key: Any] = [
            .font: NSFont.systemFont(ofSize: 55)
        ]
        "😱".draw(at: NSPoint(x: 0, y: 0), withAttributes: attributes)
        emojiIcon.unlockFocus()
        alert.icon = emojiIcon
        
        // Play alert sound
        NSSound(named: "Sosumi")?.play()
        
        alert.runModal()
    }
    
    @objc func showMenu() {
        let menu = NSMenu()
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Stop", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
        
        statusItem?.menu = menu
    }
}
