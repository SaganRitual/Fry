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

    init(_ penRadius: Double, _ ringRadius: Double, _ ringColor: SKColor) {
        self.penRadius = penRadius

        let size = CGSize(square: ringRadius * 2)
        self.sprite = makeRingSprite(size: size, color: ringColor)
    }
}

class SpindleTool: SpinnyRingTool {
    let sprite: SKSpriteNode

    init(_ ringRadius: Double, _ ringColor: SKColor) {
        let size = CGSize(square: ringRadius * 2)
        self.sprite = makeRingSprite(size: size, color: ringColor)
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
        size: CGSize, color: SKColor, penRadius: Double? = nil
    ) {
        self.type = type
        self.sprite = makeRingSprite(size: size, color: color)

        switch type {
        case .pen:     tool = PenTool(penRadius!, size.radius, color)
        case .spindle: tool = SpindleTool(size.radius, color)
        }

        parentSKNode.addChild(sprite)
    }
}
