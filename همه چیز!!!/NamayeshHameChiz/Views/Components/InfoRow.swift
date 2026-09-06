import SwiftUI

struct InfoRow: View {
    let title: String
    let value: String
    var icon: String? = nil
    var color: Color = .cyan
    
    var body: some View {
        HStack {
            if let icon = icon {
                Image(systemName: icon)
                    .foregroundColor(color)
                    .frame(width: 24)
            }
            
            Text(title)
                .font(.custom("Avenir Next", size: 15))
                .foregroundColor(.secondary)
            
            Spacer()
            
            Text(value)
                .font(.custom("Avenir Next", size: 15).weight(.semibold))
                .foregroundColor(.white)
                .multilineTextAlignment(.trailing)
        }
        .padding(.vertical, 10)
    }
}

struct DetailCard<Content: View>: View {
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.custom("Avenir Next", size: 14).weight(.bold))
                .foregroundColor(.secondary)
                .textCase(.uppercase)
                .tracking(1)
            
            VStack(spacing: 0) {
                content
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(red: 0.1, green: 0.14, blue: 0.2))
            )
        }
    }
}
