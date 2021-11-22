// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit

class Elf {
    let bigSmoothRing: SKSpriteNode
    let smallSmoothRing: SKSpriteNode
    let bumpRing: SKSpriteNode

    enum SpriteCharacter: CaseIterable {
        case bigSmooth, smallSmooth, bump
    }

    var spriteCharacter = SpriteCharacter.bump

    var sprite: SKSpriteNode {
        switch spriteCharacter {
        case .bigSmooth:   return bigSmoothRing
        case .smallSmooth: return smallSmoothRing
        case .bump:        return bumpRing
        }
    }

    private var parent: SKSpriteNode { (sprite.parent! as? SKSpriteNode)! }

    var scale: Double = 1.0 {
        willSet {
            print(
                "scale"
                + " sprite @\(sprite.position)"
                + " r\(sprite.radius)"
                + " <- \(newValue) ->"
                , terminator: ""
            )

            let scaleForSpriteImage: Double
            switch spriteCharacter {
            case .bigSmooth:   scaleForSpriteImage = 1.0
            case .smallSmooth: scaleForSpriteImage = 0.25
            case .bump:        scaleForSpriteImage = 1.0
            }

            let newValueScaled = newValue * scaleForSpriteImage

            sprite.position = CGPoint(
                radius: parent.size.radius * (1 - newValueScaled), theta: 0
            )

            sprite.radius = radius * newValueScaled

            print(
                " sprite @\(sprite.position)"
                + " r\(sprite.radius)"
                + " elf @\(self.position)"
                + " r\(self.radius)"
            )
        }
    }

    var radius: Double = 1.0 {
        willSet { sprite.radius = scale * newValue }
    }

    var position: CGPoint = .zero {
        willSet { sprite.position = scale * newValue }
    }

    static func setupSprite(
        _ character: SpriteCharacter, parentRadius: Double,
        penRingRadius: Double, color: SKColor
    ) -> SKSpriteNode {
        let sprite: SKSpriteNode

        switch character {
        case .bigSmooth:   sprite = SpritePool.rings1024_4.makeSprite()
        case .smallSmooth: sprite = SpritePool.rings256_10.makeSprite()
        case .bump:        sprite = SpritePool.bumpRingsPool.makeSprite()
        }

        sprite.anchorPoint = .anchorAtCenter
        sprite.radius = parentRadius * penRingRadius
        sprite.position = CGPoint(radius: parentRadius * (1 - penRingRadius), theta: 0)
        sprite.color = color

        return sprite
    }

    init(parent: ArenaScene, color: SKColor) {
        let penRingRadius = 1.0

        radius = penRingRadius
        scale = penRingRadius

        let parentRadius = parent.size.radius
        bumpRing = Self.setupSprite(.bump, parentRadius: parentRadius, penRingRadius: penRingRadius, color: color)
        bigSmoothRing = Self.setupSprite(.bigSmooth, parentRadius: parentRadius, penRingRadius: penRingRadius, color: color)
        smallSmoothRing = Self.setupSprite(.smallSmooth, parentRadius: parentRadius, penRingRadius: penRingRadius, color: color)

        spriteCharacter = .bigSmooth
        parent.addChild(sprite)
    }

    init(parent: Elf, penRingRadius: Double, color: SKColor, spriteCharacter: SpriteCharacter = .bigSmooth) {
        radius = penRingRadius
        scale = penRingRadius

        let parentRadius = parent.sprite.radius
        bumpRing = Self.setupSprite(.bump, parentRadius: parentRadius, penRingRadius: penRingRadius, color: color)
        bigSmoothRing = Self.setupSprite(.bigSmooth, parentRadius: parentRadius, penRingRadius: penRingRadius, color: color)
        smallSmoothRing = Self.setupSprite(.smallSmooth, parentRadius: parentRadius, penRingRadius: penRingRadius, color: color)

        self.spriteCharacter = spriteCharacter
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
