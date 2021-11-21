// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit
import SwiftUI

func makeRingSprite(size: CGSize, color: SKColor) -> SKSpriteNode {
    let sprite = SpritePool.bumpRingsPool.makeSprite()

    sprite.size = size
    sprite.color = color
    sprite.colorBlendFactor = 1

    return sprite
}

class ArenaScene: SKScene, SKSceneDelegate, ObservableObject {
    var tickCount = 0

    override init(size: CGSize) {
        super.init(size: size)

        backgroundColor = NSColor(calibratedWhite: 0.1, alpha: 0.1)
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
    }

    // The radius is our scale factor. The 95% is to shrink it enough to
    // keep the circles visible
    lazy var arenaScaleFactor = 0.95 * self.size.width / 2

    var trundle: Trundle!
    override func didMove(to view: SKView) {
        trundle = .init(parentTrundle: self, size: .init(square: 100), color: .yellow)
    }

    func showRings(_ show: Bool) {
        trundle?.showRings(show)
    }

    func setPenRingRadius(_ radius: Double) {
        trundle?.setPenRingRadius(radius)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
