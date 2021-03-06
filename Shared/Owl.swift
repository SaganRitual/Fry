// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit

class Owl {
    let ringSprite: SKSpriteNode

    private(set) var penRingRadius = 1.0

    init(penRingRadius: Double, scale: Double, color: EnglishBobColor) {
        self.ringSprite = SpritePool.ringBumpsPool.makeSprite()
        ringSprite.anchorPoint = .anchorAtCenter
        ringSprite.color = color

        setPenRingRadius(penRingRadius, deepScale: scale)

//        print(
//            "Owl pr\(penRingRadius.asString(decimals: 4))"
//            + " ds\(scale.asString(decimals: 4))"
//            + " sprite @\(ringSprite.position.x.asString(decimals: 4))"
//            + " r\(ringSprite.radius.asString(decimals: 4))"
//        )
    }

    func rotate(
        against parentRotation: Double, applyToSprite: Bool = true
    ) -> Double {
        let myRotation = parentRotation / penRingRadius

        if applyToSprite { ringSprite.zRotation += myRotation }

//        print(
//            "scale \(scale.asString(decimals: 4))"
//            + " / parent rotation \(parentRotation.asString(decimals: 4))"
//            + " -> myRotation \(myRotation.asString(decimals: 4))"
//            + " my sprite rotation \(Double(sprite.zRotation).asString(decimals: 4))"
//        )

        return -myRotation
    }

    func rescale(to deepScale: Double) {
        ringSprite.radius = penRingRadius * deepScale
        ringSprite.position = CGPoint(radius: (1 - penRingRadius) * deepScale, theta: 0)
    }

    func setPenRingRadius(
        _ radius: Double, deepScale: Double
    ) {
        self.penRingRadius = radius

        ringSprite.radius = radius * deepScale
        ringSprite.position = CGPoint(radius: (1 - radius) * deepScale, theta: 0)
    }
}
