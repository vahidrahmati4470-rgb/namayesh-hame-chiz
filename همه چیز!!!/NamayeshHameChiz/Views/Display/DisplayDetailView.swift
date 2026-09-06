import SwiftUI

struct DisplayDetailView: View {
    @ObservedObject var viewModel: SystemInfoViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 28) {
                // Brightness Icon
                Image(systemName: brightnessIcon)
                    .font(.system(size: 70))
                    .foregroundStyle(
                        LinearGradient(colors: [.orange, .yellow], startPoint: .top, endPoint: .bottom)
                    )
                    .padding(.top, 30)
                    .symbolEffect(.pulse, options: .repeating, value: viewModel.brightness)
                
                Text("\(Int(viewModel.brightness * 100))%")
                    .font(.custom("Avenir Next", size: 42).weight(.bold))
                    .foregroundColor(.white)
                
                // Slider
                VStack(spacing: 12) {
                    HStack {
                        Image(systemName: "sun.min")
                            .foregroundColor(.secondary)
                        Slider(value: $viewModel.brightness, in: 0.01...1.0)
                            .tint(.orange)
                            .onChange(of: viewModel.brightness) { _, newValue in
                                viewModel.setBrightness(newValue)
                            }
                        Image(systemName: "sun.max.fill")
                            .foregroundColor(.orange)
                    }
                    .padding(.horizontal)
                    
                    Text("با حرکت دادن اسلایدر، روشنایی صفحه تغییر می‌کند")
                        .font(.custom("Avenir Next", size: 13))
                        .foregroundColor(.secondary)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(red: 0.1, green: 0.14, blue: 0.2))
                )
                
                // Quick Buttons
                HStack(spacing: 16) {
                    QuickBrightnessButton(title: "کم", value: 0.2, viewModel: viewModel)
                    QuickBrightnessButton(title: "متوسط", value: 0.5, viewModel: viewModel)
                    QuickBrightnessButton(title: "زیاد", value: 0.9, viewModel: viewModel)
                }
                
                DetailCard(title: "توضیحات") {
                    Text("کنترل روشنایی فقط زمانی که اپلیکیشن باز است اعمال می‌شود. بعد از بستن اپ، سیستم ممکن است روشنایی را تغییر دهد.")
                        .font(.custom("Avenir Next", size: 14))
                        .foregroundColor(.secondary)
                }
            }
            .padding()
        }
        .background(Color(red: 0.06, green: 0.09, blue: 0.14))
        .navigationTitle("نمایشگر")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var brightnessIcon: String {
        let b = viewModel.brightness
        if b < 0.3 { return "sun.min" }
        if b < 0.7 { return "sun.max" }
        return "sun.max.fill"
    }
}

struct QuickBrightnessButton: View {
    let title: String
    let value: Double
    @ObservedObject var viewModel: SystemInfoViewModel
    
    var body: some View {
        Button {
            withAnimation {
                viewModel.brightness = value
                viewModel.setBrightness(value)
            }
        } label: {
            Text(title)
                .font(.custom("Avenir Next", size: 15).weight(.semibold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.orange.opacity(0.25))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.orange.opacity(0.5), lineWidth: 1)
                        )
                )
        }
    }
}
