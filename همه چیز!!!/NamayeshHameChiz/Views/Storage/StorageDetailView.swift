import SwiftUI

struct StorageDetailView: View {
    @ObservedObject var viewModel: SystemInfoViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Storage Ring
                ZStack {
                    Circle()
                        .stroke(Color.white.opacity(0.1), lineWidth: 18)
                        .frame(width: 170, height: 170)
                    
                    Circle()
                        .trim(from: 0, to: viewModel.storageUsedRatio)
                        .stroke(
                            LinearGradient(colors: [.green, .cyan], startPoint: .topLeading, endPoint: .bottomTrailing),
                            style: StrokeStyle(lineWidth: 18, lineCap: .round)
                        )
                        .frame(width: 170, height: 170)
                        .rotationEffect(.degrees(-90))
                    
                    VStack {
                        Text(viewModel.usedStorageText)
                            .font(.custom("Avenir Next", size: 20).weight(.bold))
                            .foregroundColor(.white)
                        Text("استفاده شده")
                            .font(.custom("Avenir Next", size: 13))
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.top, 20)
                
                DetailCard(title: "فضای ذخیره‌سازی") {
                    InfoRow(title: "کل فضا", value: viewModel.totalStorageText, icon: "internaldrive", color: .green)
                    Divider().background(Color.white.opacity(0.1))
                    InfoRow(title: "استفاده شده", value: viewModel.usedStorageText, icon: "externaldrive.fill", color: .orange)
                    Divider().background(Color.white.opacity(0.1))
                    InfoRow(title: "آزاد", value: viewModel.freeStorageText, icon: "externaldrive.badge.checkmark", color: .cyan)
                }
            }
            .padding()
        }
        .background(Color(red: 0.06, green: 0.09, blue: 0.14))
        .navigationTitle("ذخیره‌سازی")
        .navigationBarTitleDisplayMode(.inline)
    }
}
