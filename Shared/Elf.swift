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

    var penRingRadius = 1.0

    var scale: Double { penRingRadius }

    func setPenRingRadius(_ penRingRadius: Double, arenaScale: Double) {
        self.penRingRadius = penRingRadius
        placeSprite(arenaScale)
    }

    func placeSprite(_ arenaScale: Double) {
        sprite.position = CGPoint(
            radius: arenaScale * parent.size.radius * (1 - penRingRadius), theta: 0
        )

        sprite.radius = penRingRadius * arenaScale
    }

    static func setupSprite(
        _ character: SpriteCharacter, parentRadius: Double,
        penRingRadius: Double, color: SKColor
    ) -> SKSpriteNode {
        let sprite: SKSpriteNode

        switch character {
        case .bigSmooth:   sprite = SpritePool.rings1024_4.makeSprite()
        case .smallSmooth: sprite = SpritePool.rings256_10.makeSprite()
        case .bump:        sprite = SpritePool.ringBumpsPool.makeSprite()
        }

        sprite.anchorPoint = .anchorAtCenter
        sprite.radius = parentRadius * penRingRadius
        sprite.position = CGPoint(radius: parentRadius * (1 - penRingRadius), theta: 0)
        sprite.color = color

        return sprite
    }

    init(parent: ArenaScene, color: SKColor, spriteCharacter: SpriteCharacter = .bigSmooth) {
        self.penRingRadius = 1.0

        let parentRadius = parent.size.radius
        bumpRing = Self.setupSprite(.bump, parentRadius: parentRadius, penRingRadius: penRingRadius, color: color)
        bigSmoothRing = Self.setupSprite(.bigSmooth, parentRadius: parentRadius, penRingRadius: penRingRadius, color: color)
        smallSmoothRing = Self.setupSprite(.smallSmooth, parentRadius: parentRadius, penRingRadius: penRingRadius, color: color)

        self.spriteCharacter = spriteCharacter
        parent.addChild(sprite)
    }

    init(parent: Elf, penRingRadius: Double, color: SKColor, spriteCharacter: SpriteCharacter = .bigSmooth) {
        self.penRingRadius = penRingRadius

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
