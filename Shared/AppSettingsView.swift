// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit
import SwiftUI

struct AppSettingsView: View {
    @EnvironmentObject var arena: ArenaScene

    @State var penRingRadius = 1.0
    @State var showRings = true

    static let radiusRange = 0.0...1.0

    var body: some View {
        VStack {
            SliderView(
                label: "Pen ring radius", labellet: "X",
                range: AppSettingsView.radiusRange, step: 0.05,
                decimals: 2, value: $penRingRadius
            )
            .modifier(SliderViewDefaults())
            .help("Ratio of run rate to the speed of time in a vacuum")
            .onAppear(perform: { self.setPenRingRadius(penRingRadius) })
            .onChange(of: penRingRadius) { self.setPenRingRadius($0) }
        }

        VStack(alignment: .leading) {
            Text("Show/hide").font(.title).padding([.top, .bottom], 15)

            HStack {
                ToggleView(isChecked: $showRings, label: "Rings")
                    .frame(width: 100)
                    .onAppear(perform: { self.showRings(showRings) })
                    .onChange(of: showRings) { self.showRings($0) }
            }
        }
    }
}

extension AppSettingsView {
    func showRings(_ show: Bool) {
        UserDefaults.standard.set(show, forKey: "showRings")
        arena.showRings(show)
    }

    func setPenRingRadius(_ radius: Double) {
        UserDefaults.standard.set(penRingRadius, forKey: "penRingRadius")
        arena.setPenRingRadius(penRingRadius)
    }
}
