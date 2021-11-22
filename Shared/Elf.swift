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

    private let parentElf: Elf!

    var penRingRadius = 1.0

    var scale: Double { penRingRadius }

    func setPenRingRadius(_ penRingRadius: Double, arenaScale: Double) {
        self.penRingRadius = penRingRadius
        placeSprite(arenaScale)
    }

    func placeSpritezilla(_ arenaScale: Double) {
        sprite.position = CGPoint(
            radius: arenaScale * (1 - penRingRadius), theta: 0
        )

        sprite.radius = penRingRadius * arenaScale
    }

    func placeSprite(_ arenaScale: Double) {
        print("ps \(arenaScale.asString(decimals: 4))")

        sprite.position = CGPoint(
            radius: arenaScale * (1 - penRingRadius) * parentElf.penRingRadius, theta: 0
        )

        sprite.radius = arenaScale * penRingRadius * parentElf.penRingRadius
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
        self.parentElf = nil
        self.penRingRadius = 1.0

        let parentRadius = 1.0
        bumpRing = Self.setupSprite(.bump, parentRadius: parentRadius, penRingRadius: penRingRadius, color: color)
        bigSmoothRing = Self.setupSprite(.bigSmooth, parentRadius: parentRadius, penRingRadius: penRingRadius, color: color)
        smallSmoothRing = Self.setupSprite(.smallSmooth, parentRadius: parentRadius, penRingRadius: penRingRadius, color: color)

        self.spriteCharacter = spriteCharacter
        parent.addChild(sprite)

        placeSpritezilla(ContentView.arenaSize.radius)

        print(
            "Elfzilla"
            + " penRing r\(self.penRingRadius.asString(decimals: 4))"
            + " parent r\(parentRadius.asString(decimals: 4))"
            + " bumpRing @\(bumpRing.position.x.asString(decimals: 4))"
            + " r\(bumpRing.radius.asString(decimals: 4))"
        )
    }

    init(
        parentElf: Elf, penRingRadius: Double, color: SKColor,
        spriteCharacter: SpriteCharacter = .bigSmooth
    ) {
        self.parentElf = parentElf
        self.penRingRadius = penRingRadius

        let parentRadius = parentElf.penRingRadius
        bumpRing = Self.setupSprite(.bump, parentRadius: parentRadius, penRingRadius: penRingRadius, color: color)
        bigSmoothRing = Self.setupSprite(.bigSmooth, parentRadius: parentRadius, penRingRadius: penRingRadius, color: color)
        smallSmoothRing = Self.setupSprite(.smallSmooth, parentRadius: parentRadius, penRingRadius: penRingRadius, color: color)

        self.spriteCharacter = spriteCharacter
        parentElf.sprite.addChild(sprite)

        placeSprite(ContentView.arenaSize.radius)

        print(
            "Elf"
            + " penRing r\(self.penRingRadius.asString(decimals: 4))"
            + " parent r\(parentRadius.asString(decimals: 4))"
            + " bumpRing @\(bumpRing.position.x.asString(decimals: 4))"
            + " r\(bumpRing.radius.asString(decimals: 4))"
        )
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
