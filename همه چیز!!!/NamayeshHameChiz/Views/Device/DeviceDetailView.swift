import SwiftUI

struct DeviceDetailView: View {
    @ObservedObject var viewModel: SystemInfoViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Image(systemName: "iphone" )
                    .font(.system(size: 70))
                    .foregroundStyle(
                        LinearGradient(colors: [.purple, .pink], startPoint: .top, endPoint: .bottom)
                    )
                    .padding(.top, 20)
                
                Text(viewModel.deviceName)
                    .font(.custom("Avenir Next", size: 24).weight(.bold))
                    .foregroundColor(.white)
                
                DetailCard(title: "اطلاعات اصلی") {
                    InfoRow(title: "نام دستگاه", value: viewModel.deviceName, icon: "iphone", color: .purple)
                    Divider().background(Color.white.opacity(0.1))
                    InfoRow(title: "مدل", value: viewModel.deviceModel, icon: "cpu", color: .blue)
                    Divider().background(Color.white.opacity(0.1))
                    InfoRow(title: "نسخه سیستم", value: viewModel.systemVersion, icon: "gear", color: .gray)
                    Divider().background(Color.white.opacity(0.1))
                    InfoRow(title: "نام سیستم", value: viewModel.systemName, icon: "apple.logo", color: .white)
                }
                
                DetailCard(title: "شناسه‌ها") {
                    InfoRow(title: "شناسه سیستم", value: viewModel.identifierForVendor, icon: "barcode", color: .cyan)
                }
                
                DetailCard(title: "سایر") {
                    InfoRow(title: "منطقه زمانی", value: viewModel.timeZone, icon: "clock", color: .orange)
                    Divider().background(Color.white.opacity(0.1))
                    InfoRow(title: "زبان", value: viewModel.language, icon: "globe", color: .green)
                }
            }
            .padding()
        }
        .background(Color(red: 0.06, green: 0.09, blue: 0.14))
        .navigationTitle("اطلاعات دستگاه")
        .navigationBarTitleDisplayMode(.inline)
    }
}
