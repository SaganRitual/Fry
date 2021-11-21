// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit

class WormClub {
    var worms = [WormProtocol]()

    init(arena: ArenaScene) {
        let w = Wormzilla(scale: arena.size.radius)
        w.beAdopted(by: arena)
        worms.append(w)
    }
}

protocol WormProtocol {
    var penRing: SKSpriteNode { get }
}

class Wormzilla: WormProtocol {
    let penRing: SKSpriteNode

    var scale: Double

    var penRingPosition: CGPoint {
        get { penRing.position / scale }
        set { penRing.position = newValue * scale }
    }

    var penRingRadius: Double {
        set { penRing.size.width = newValue * scale; penRing.size.height = 1 }
        get { penRing.size.width / scale }
    }

    init(scale: Double) {
        self.scale = scale

        penRing = SpritePool.linesPool.makeSprite()
        penRing.color = .cyan
        penRingRadius = 1
    }

    func beAdopted(by parent: ArenaScene) {
        parent.addChild(penRing)
    }
}

class Worm: WormProtocol {
    let spindleRing: SKSpriteNode
    let penRing: SKSpriteNode

    var spindleRingRadius: Double
    var penRingRadius: Double
    var scale: Double

    var spindleRingPosition: CGPoint {
        get { spindleRing.position / scale }
        set { spindleRing.position = newValue * scale }
    }

    var penRingPosition: CGPoint {
        get { penRing.position / scale }
        set { penRing.position = newValue * scale }
    }

    init(
        penRingRadius: Double, spindleRingRadius: Double, scale: Double,
        color: SKColor
    ) {
        self.scale = scale
        self.penRingRadius = penRingRadius
        self.spindleRingRadius = spindleRingRadius

        spindleRing = SpritePool.linesPool.makeSprite()
        penRing = SpritePool.linesPool.makeSprite()

        spindleRing.color = color
        penRing.color = color
    }

    func beAdopted(by parent: WormProtocol) {
        parent.penRing.addChild(spindleRing)
        parent.penRing.addChild(penRing)
    }
}
