// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit
import SwiftUI

struct ContentView: View {
    let arena = ArenaScene(size: CGSize(square: 200))

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
