import SwiftUI

struct BatteryDetailView: View {
    @ObservedObject var viewModel: SystemInfoViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Big Battery Circle
                ZStack {
                    Circle()
                        .stroke(Color.white.opacity(0.1), lineWidth: 16)
                        .frame(width: 180, height: 180)
                    
                    Circle()
                        .trim(from: 0, to: CGFloat(viewModel.batteryLevel) / 100)
                        .stroke(
                            AngularGradient(
                                colors: batteryGradient,
                                center: .center
                            ),
                            style: StrokeStyle(lineWidth: 16, lineCap: .round)
                        )
                        .frame(width: 180, height: 180)
                        .rotationEffect(.degrees(-90))
                        .animation(.easeInOut(duration: 0.8), value: viewModel.batteryLevel)
                    
                    VStack(spacing: 4) {
                        Text("\(viewModel.batteryLevel)")
                            .font(.custom("Avenir Next", size: 48).weight(.bold))
                            .foregroundColor(.white)
                        Text("%")
                            .font(.custom("Avenir Next", size: 18))
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.top, 20)
                
                DetailCard(title: "وضعیت باتری") {
                    InfoRow(title: "درصد شارژ", value: "\(viewModel.batteryLevel)%", icon: "battery.100", color: .green)
                    Divider().background(Color.white.opacity(0.1))
                    InfoRow(title: "وضعیت", value: viewModel.batteryStateText, icon: "bolt.fill", color: .yellow)
                    Divider().background(Color.white.opacity(0.1))
                    InfoRow(title: "حالت کم‌مصرف", value: viewModel.isLowPowerMode ? "فعال" : "غیرفعال", icon: "leaf.fill", color: .green)
                }
                
                // Tips
                DetailCard(title: "نکته") {
                    Text("اطلاعات باتری به صورت لحظه‌ای به‌روزرسانی می‌شود.")
                        .font(.custom("Avenir Next", size: 14))
                        .foregroundColor(.secondary)
                }
            }
            .padding()
        }
        .background(Color(red: 0.06, green: 0.09, blue: 0.14))
        .navigationTitle("باتری")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var batteryGradient: [Color] {
        let level = viewModel.batteryLevel
        if level > 50 { return [.green, .cyan] }
        if level > 20 { return [.yellow, .orange] }
        return [.red, .orange]
    }
}
