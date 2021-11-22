// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit

typealias EnglishBobColor = NSColor

enum osBuild {
    static func calibratedWhite(luma: Double, alpha: Double) -> NSColor {
        NSColor.init(calibratedWhite: luma, alpha: alpha)
    }
}

class Dotter {
    let arenaScene: ArenaScene
    let dotLifespan: TimeInterval
    let dotSize: CGSize
    let fade: SKAction

    init(_ arenaScene: ArenaScene, dotSize: CGSize, dotLifespan: TimeInterval) {
        self.arenaScene = arenaScene
        self.dotLifespan = dotLifespan
        self.dotSize = dotSize
        self.fade = SKAction.fadeOut(withDuration: dotLifespan)
    }

    func dropDot(at position: CGPoint, color: SKColor) {
        let dot = SpritePool.dotsPool.makeSprite()
        dot.position = position
        dot.size = dotSize
        dot.color = color
        arenaScene.addChild(dot)

        dot.run(fade) { dot.removeFromParent() }
    }

    func color(_ color: EnglishBobColor, _ alpha: Double = 1.0) -> SKColor {
        color.withAlphaComponent(alpha)
    }
}
