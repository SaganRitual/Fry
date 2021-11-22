// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit

protocol SpinnyRingTool {
    var sprite: SKSpriteNode { get }
}

extension SpinnyRingTool {
    var radius: Double {
        get { sprite.size.width / 2.0 }
        set { sprite.size.width = newValue * 2.0}
    }
}

class PenTool: SpinnyRingTool {
    var penRadius: Double
    let sprite: SKSpriteNode

    init(_ penRadius: Double, _ ringColor: SKColor) {
        self.penRadius = penRadius

        self.sprite = SpinnyRing.makeRingSprite(color: ringColor)
    }
}

class SpindleTool: SpinnyRingTool {
    let sprite: SKSpriteNode

    init(_ ringColor: SKColor) {
        self.sprite = SpinnyRing.makeRingSprite(color: ringColor)
    }
}

enum SpinnyRingType { case spindle, pen }

class SpinnyRing {
    let sprite: SKSpriteNode
    let tool: SpinnyRingTool
    let type: SpinnyRingType

    var isVisible: Bool {
        get { !sprite.isHidden } set { sprite.isHidden = !newValue }
    }

    init(
        type: SpinnyRingType, parentSKNode: SKNode,
        color: SKColor, penRadius: Double? = nil
    ) {
        self.type = type
        self.sprite = SpinnyRing.makeRingSprite(color: color)

        switch type {
        case .pen:     tool = PenTool(penRadius!, color)
        case .spindle: tool = SpindleTool(color)
        }

        parentSKNode.addChild(sprite)
    }

    static func makeRingSprite(color: SKColor) -> SKSpriteNode {
        let sprite = SpritePool.ringBumpsPool.makeSprite()

        sprite.size = .init(square: 1.0)
        sprite.color = color
        sprite.colorBlendFactor = 1

        return sprite
    }
}
