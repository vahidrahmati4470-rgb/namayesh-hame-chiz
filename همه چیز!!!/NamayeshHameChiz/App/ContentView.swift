import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = SystemInfoViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Header
                    HeaderView()
                    
                    // Battery Section
                    NavigationLink {
                        BatteryDetailView(viewModel: viewModel)
                    } label: {
                        SectionCard(
                            title: "باتری",
                            icon: "battery.100.bolt",
                            color: batteryColor,
                            value: "\(viewModel.batteryLevel)%",
                            subtitle: viewModel.batteryStateText
                        )
                    }
                    
                    // Display Section
                    NavigationLink {
                        DisplayDetailView(viewModel: viewModel)
                    } label: {
                        SectionCard(
                            title: "نمایشگر",
                            icon: "sun.max.fill",
                            color: .orange,
                            value: "\(Int(viewModel.brightness * 100))%",
                            subtitle: "روشنایی صفحه"
                        )
                    }
                    
                    // Network Section
                    NavigationLink {
                        NetworkDetailView(viewModel: viewModel)
                    } label: {
                        SectionCard(
                            title: "ارتباط و شبکه",
                            icon: "antenna.radiowaves.left.and.right",
                            color: .cyan,
                            value: viewModel.connectionType,
                            subtitle: viewModel.networkSubtitle
                        )
                    }
                    
                    // Device Section
                    NavigationLink {
                        DeviceDetailView(viewModel: viewModel)
                    } label: {
                        SectionCard(
                            title: "اطلاعات دستگاه",
                            icon: "iphone",
                            color: .purple,
                            value: viewModel.deviceModel,
                            subtitle: viewModel.systemVersion
                        )
                    }
                    
                    // Storage Section
                    NavigationLink {
                        StorageDetailView(viewModel: viewModel)
                    } label: {
                        SectionCard(
                            title: "ذخیره‌سازی",
                            icon: "internaldrive.fill",
                            color: .green,
                            value: viewModel.freeStorageText,
                            subtitle: "فضای آزاد"
                        )
                    }
                    
                    // Memory Section
                    NavigationLink {
                        MemoryDetailView(viewModel: viewModel)
                    } label: {
                        SectionCard(
                            title: "حافظه",
                            icon: "memorychip",
                            color: .pink,
                            value: viewModel.totalMemoryText,
                            subtitle: "حافظه کل"
                        )
                    }
                }
                .padding()
            }
            .background(Color(red: 0.06, green: 0.09, blue: 0.14))
            .navigationTitle("نمایش همه چیز!!")
            .navigationBarTitleDisplayMode(.large)
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
        .onAppear {
            viewModel.startUpdating()
        }
    }
    
    private var batteryColor: Color {
        let level = viewModel.batteryLevel
        if level > 50 { return .green }
        if level > 20 { return .yellow }
        return .red
    }
}

// MARK: - Header
struct HeaderView: View {
    var body: some View {
        VStack(spacing: 8) {
            Text("نمایش همه چیز!!")
                .font(.custom("Avenir Next", size: 28).weight(.bold))
                .foregroundStyle(
                    LinearGradient(
                        colors: [.cyan, .blue, .purple],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
            
            Text("همه اطلاعات دستگاهت در یک نگاه")
                .font(.custom("Avenir Next", size: 14))
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 10)
    }
}

#Preview {
    ContentView()
}
