// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct ToggleView: View {
    @Binding var isChecked: Bool

    let label: String

    var body: some View {
        HStack {
            Image(systemName: isChecked ? "capsule.fill" : "capsule")
                .foregroundColor(isChecked ? Color.blue : Color.secondary)
                .onTapGesture { self.isChecked.toggle() }
                .frame(width: 30, alignment: .leading)
                .padding(.trailing, -10)

            Text(label).font(.body)
        }
    }
}

struct SettingsToggleView_Previews: PreviewProvider {
    @State static var isChecked = false

    static var previews: some View {
        ToggleView(isChecked: $isChecked, label: "Ring")
            .frame(minWidth: nil, idealWidth: nil, maxWidth: .infinity)
    }
}
