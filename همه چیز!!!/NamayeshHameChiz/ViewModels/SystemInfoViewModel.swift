import SwiftUI
import UIKit

@MainActor
class SystemInfoViewModel: ObservableObject {
    // Battery
    @Published var batteryLevel: Int = 0
    @Published var batteryStateText: String = "نامشخص"
    @Published var isLowPowerMode: Bool = false
    
    // Display
    @Published var brightness: Double = 0.5
    
    // Network
    @Published var connectionType: String = "نامشخص"
    @Published var isConnected: Bool = false
    @Published var cellularType: String = "نامشخص"
    @Published var networkSubtitle: String = ""
    
    // Device
    @Published var deviceName: String = ""
    @Published var deviceModel: String = ""
    @Published var systemVersion: String = ""
    @Published var systemName: String = ""
    @Published var identifierForVendor: String = ""
    @Published var timeZone: String = ""
    @Published var language: String = ""
    
    // Storage
    @Published var totalStorageText: String = "—"
    @Published var usedStorageText: String = "—"
    @Published var freeStorageText: String = "—"
    @Published var storageUsedRatio: CGFloat = 0
    
    // Memory
    @Published var totalMemoryText: String = "—"
    
    private var timer: Timer?
    
    func startUpdating() {
        UIDevice.current.isBatteryMonitoringEnabled = true
        updateAll()
        
        timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { [weak self] _ in
            Task { @MainActor in
                self?.updateAll()
            }
        }
    }
    
    func setBrightness(_ value: Double) {
        UIScreen.main.brightness = CGFloat(value)
    }
    
    private func updateAll() {
        updateBattery()
        updateBrightness()
        updateDeviceInfo()
        updateStorage()
        updateMemory()
        updateNetwork()
    }
    
    private func updateBattery() {
        let level = UIDevice.current.batteryLevel
        batteryLevel = level < 0 ? 0 : Int(level * 100)
        
        switch UIDevice.current.batteryState {
        case .charging: batteryStateText = "در حال شارژ"
        case .full: batteryStateText = "پر"
        case .unplugged: batteryStateText = "در حال استفاده"
        default: batteryStateText = "نامشخص"
        }
        
        isLowPowerMode = ProcessInfo.processInfo.isLowPowerModeEnabled
    }
    
    private func updateBrightness() {
        brightness = Double(UIScreen.main.brightness)
    }
    
    private func updateDeviceInfo() {
        deviceName = UIDevice.current.name
        deviceModel = mapDeviceModel()
        systemVersion = "iOS " + UIDevice.current.systemVersion
        systemName = UIDevice.current.systemName
        identifierForVendor = UIDevice.current.identifierForVendor?.uuidString ?? "نامشخص"
        timeZone = TimeZone.current.identifier
        language = Locale.current.language.languageCode?.identifier ?? "نامشخص"
    }
    
    private func updateStorage() {
        if let attrs = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory()),
           let total = attrs[.systemSize] as? Int64,
           let free = attrs[.systemFreeSize] as? Int64 {
            
            let used = total - free
            totalStorageText = formatBytes(total)
            freeStorageText = formatBytes(free)
            usedStorageText = formatBytes(used)
            storageUsedRatio = total > 0 ? CGFloat(used) / CGFloat(total) : 0
        }
    }
    
    private func updateMemory() {
        let total = ProcessInfo.processInfo.physicalMemory
        totalMemoryText = formatBytes(Int64(total))
    }
    
    private func updateNetwork() {
        // Simple reachability-style check using NWPath would be better,
        // but for simplicity we show basic info.
        // In a real app you'd use Network framework.
        
        connectionType = "Wi-Fi / Cellular"
        isConnected = true
        cellularType = "LTE / 5G (تقریبی)"
        networkSubtitle = "برای جزئیات بیشتر به بخش شبکه بروید"
        
        // Note: Exact signal strength and carrier name require private APIs
    }
    
    private func formatBytes(_ bytes: Int64) -> String {
        let formatter = ByteCountFormatter()
        formatter.allowedUnits = [.useGB, .useMB]
        formatter.countStyle = .file
        return formatter.string(fromByteCount: bytes)
    }
    
    private func mapDeviceModel() -> String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        // Simplified mapping
        let map: [String: String] = [
            "iPhone15,2": "iPhone 14 Pro",
            "iPhone15,3": "iPhone 14 Pro Max",
            "iPhone15,4": "iPhone 15",
            "iPhone16,1": "iPhone 15 Pro",
            "iPhone16,2": "iPhone 15 Pro Max",
            "iPhone17,1": "iPhone 16 Pro",
            "iPhone17,2": "iPhone 16 Pro Max",
            "i386": "Simulator",
            "x86_64": "Simulator",
            "arm64": "Simulator"
        ]
        
        return map[identifier] ?? identifier
    }
}
