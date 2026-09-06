import SwiftUI

struct MemoryDetailView: View {
    @ObservedObject var viewModel: SystemInfoViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Image(systemName: "memorychip")
                    .font(.system(size: 60))
                    .foregroundStyle(
                        LinearGradient(colors: [.pink, .purple], startPoint: .top, endPoint: .bottom)
                    )
                    .padding(.top, 20)
                
                Text(viewModel.totalMemoryText)
                    .font(.custom("Avenir Next", size: 32).weight(.bold))
                    .foregroundColor(.white)
                
                Text("حافظه کل دستگاه")
                    .font(.custom("Avenir Next", size: 15))
                    .foregroundColor(.secondary)
                
                DetailCard(title: "اطلاعات حافظه") {
                    InfoRow(title: "حافظه کل", value: viewModel.totalMemoryText, icon: "memorychip", color: .pink)
                    Divider().background(Color.white.opacity(0.1))
                    InfoRow(title: "نکته", value: "جزئیات دقیق استفاده از RAM در iOS محدود است", icon: "info.circle", color: .gray)
                }
                
                DetailCard(title: "توضیح") {
                    Text("اپل اجازه دسترسی دقیق به میزان استفاده لحظه‌ای از RAM را به اپلیکیشن‌های معمولی نمی‌دهد. فقط حافظه کل دستگاه قابل نمایش است.")
                        .font(.custom("Avenir Next", size: 14))
                        .foregroundColor(.secondary)
                }
            }
            .padding()
        }
        .background(Color(red: 0.06, green: 0.09, blue: 0.14))
        .navigationTitle("حافظه")
        .navigationBarTitleDisplayMode(.inline)
    }
}
