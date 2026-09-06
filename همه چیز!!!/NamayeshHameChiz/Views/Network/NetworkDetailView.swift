import SwiftUI

struct NetworkDetailView: View {
    @ObservedObject var viewModel: SystemInfoViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Status Icon
                Image(systemName: networkIcon)
                    .font(.system(size: 60))
                    .foregroundStyle(
                        LinearGradient(colors: [.cyan, .blue], startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                    .padding(.top, 20)
                
                Text(viewModel.connectionType)
                    .font(.custom("Avenir Next", size: 28).weight(.bold))
                    .foregroundColor(.white)
                
                DetailCard(title: "وضعیت اتصال") {
                    InfoRow(title: "نوع اتصال", value: viewModel.connectionType, icon: "network", color: .cyan)
                    Divider().background(Color.white.opacity(0.1))
                    InfoRow(title: "وضعیت", value: viewModel.isConnected ? "متصل" : "قطع", icon: "checkmark.circle", color: viewModel.isConnected ? .green : .red)
                }
                
                DetailCard(title: "شبکه سلولی") {
                    InfoRow(title: "نوع شبکه", value: viewModel.cellularType, icon: "antenna.radiowaves.left.and.right", color: .blue)
                    Divider().background(Color.white.opacity(0.1))
                    InfoRow(title: "قدرت سیگنال", value: "در دسترس نیست", icon: "waveform.path.ecg", color: .gray)
                    Divider().background(Color.white.opacity(0.1))
                    InfoRow(title: "نام اپراتور", value: "محدودیت سیستمی", icon: "simcard", color: .gray)
                }
                
                DetailCard(title: "توضیح مهم") {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("اپل به دلایل امنیتی و حریم خصوصی، اجازه دسترسی اپلیکیشن‌های معمولی به موارد زیر را نمی‌دهد:")
                            .font(.custom("Avenir Next", size: 14))
                            .foregroundColor(.secondary)
                        
                        Text("• قدرت دقیق سیگنال (dBm یا درصد)\n• نام دقیق سیم‌کارت / اپراتور\n• IMEI و اطلاعات حساس سیم‌کارت")
                            .font(.custom("Avenir Next", size: 13))
                            .foregroundColor(.secondary)
                        
                        Text("این محدودیت‌ها برای همه اپ‌های App Store وجود دارد.")
                            .font(.custom("Avenir Next", size: 13).weight(.semibold))
                            .foregroundColor(.orange)
                            .padding(.top, 4)
                    }
                }
            }
            .padding()
        }
        .background(Color(red: 0.06, green: 0.09, blue: 0.14))
        .navigationTitle("ارتباط و شبکه")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var networkIcon: String {
        switch viewModel.connectionType {
        case "Wi-Fi": return "wifi"
        case "Cellular": return "antenna.radiowaves.left.and.right"
        default: return "wifi.slash"
        }
    }
}
