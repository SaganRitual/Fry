// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit
import SwiftUI

struct AppSettingsView: View {
    @EnvironmentObject var arena: ArenaScene

    @State var mainRingSpeedHz = UserDefaults.standard.double(forKey: "mainRingSpinRate")
    @State var penRingRadius = 1.0
    @State var showRings = true

    static let speedRange = 0.0...1.0

    var body: some View {
        VStack {
            SliderView(
                label: "Speed", labellet: "X",
                range: AppSettingsView.speedRange, step: 0.05,
                decimals: 2, value: $mainRingSpeedHz
            )
            .modifier(SliderViewDefaults())
            .help("Outermost ring cycles per second rate")
            .onAppear(perform: { self.setMainRingSpeed(mainRingSpeedHz) })
            .onChange(of: mainRingSpeedHz) { self.setMainRingSpeed($0) }

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
    func setMainRingSpeed(_ cyclesPerSecond: Double) {
        UserDefaults.standard.set(cyclesPerSecond, forKey: "mainRingSpinRate")
        arena.setMainRingSpeed(cyclesPerSecond)
    }

    func showRings(_ show: Bool) {
        UserDefaults.standard.set(show, forKey: "showRings")
        arena.showRings(show)
    }

    func setPenRingRadius(_ radius: Double) {
        UserDefaults.standard.set(penRingRadius, forKey: "penRingRadius")
        arena.setPenRingRadius(penRingRadius)
    }
}
