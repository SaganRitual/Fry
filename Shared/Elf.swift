// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit

class Elf {
    let sprite: SKSpriteNode

    private var parent: SKSpriteNode { (sprite.parent! as? SKSpriteNode)! }

    var scale: Double = 1.0 {
        willSet {
            sprite.position = position * newValue
            sprite.radius = radius * newValue
        }
    }

    var radius: Double = 1.0 {
        willSet { sprite.radius = scale * newValue }
    }

    var position: CGPoint = .zero {
        willSet { sprite.position = scale * newValue }
    }

    init(parent: ArenaScene, color: SKColor) {
        let penRingRadius = 1.0

        radius = penRingRadius
        scale = penRingRadius

        sprite = SpritePool.bumpRingsPool.makeSprite()
        sprite.anchorPoint = .anchorAtCenter
        sprite.radius = parent.size.radius * penRingRadius
        sprite.position = CGPoint(radius: parent.size.radius * (1 - penRingRadius), theta: 0)
        sprite.color = color

        parent.addChild(sprite)
    }

    init(parent: Elf, penRingRadius: Double, color: SKColor) {
        radius = penRingRadius
        scale = penRingRadius

        sprite = SpritePool.bumpRingsPool.makeSprite()
        sprite.anchorPoint = .anchorAtCenter
        sprite.radius = parent.sprite.radius * penRingRadius
        sprite.position = CGPoint(radius: parent.sprite.radius * (1 - penRingRadius), theta: 0)
        sprite.color = color

        parent.sprite.addChild(sprite)
    }

    func rotate(against parentRotation: Double, applyToSprite: Bool = true) -> Double {
        let myRotation = parentRotation / scale

        if applyToSprite { sprite.zRotation += myRotation }

//        print(
//            "scale \(scale.asString(decimals: 4))"
//            + " / parent rotation \(parentRotation.asString(decimals: 4))"
//            + " -> myRotation \(myRotation.asString(decimals: 4))"
//            + " my sprite rotation \(Double(sprite.zRotation).asString(decimals: 4))"
//        )

        return -myRotation
    }
}
