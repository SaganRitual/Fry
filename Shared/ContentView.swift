// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit
import SwiftUI

struct ContentView: View {
    static let arenaSize = CGSize(square: 200)
    let arena = ArenaScene(size: Self.arenaSize)

    var body: some View {
        HStack {
            AppSettingsView()
                .frame(width: 300)

            SpriteView(scene: arena).scaledToFit()
        }.environmentObject(arena)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
