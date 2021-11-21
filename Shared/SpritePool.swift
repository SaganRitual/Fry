import SpriteKit

class SpritePool {
    static let dotsPool = SpritePool("Markers", "circle-solid", cPreallocate: 10000)
    static let linesPool = SpritePool("Markers", "line")
    static let ringsPool = SpritePool("Markers", "circle")
    static let bumpRingsPool = SpritePool("Markers", "circle-bump")

    let atlas: SKTextureAtlas
    var parkedDrones: [SKSpriteNode]
    let texture: SKTexture

    init(_ atlasName: String, _ textureName: String, cPreallocate: Int = 0) {
        self.atlas = SKTextureAtlas(named: atlasName)
        self.texture = atlas.textureNamed(textureName)
        self.parkedDrones = []

        for _ in 0..<cPreallocate {
            parkedDrones.append(SKSpriteNode(texture: self.texture))
        }
    }

    func makeSprite() -> SKSpriteNode {
        let drone = getDrone()
        return makeSprite(with: drone)
    }

    func releaseSprite(_ sprite: SKSpriteNode) {
        sprite.removeAllActions()
        sprite.removeFromParent()
        parkedDrones.append(sprite)
    }
}

private extension SpritePool {

    func getDrone() -> SKSpriteNode {
        if parkedDrones.isEmpty {
            parkedDrones.append(SKSpriteNode(texture: self.texture))
        }

        return parkedDrones.popLast()!
    }

    func makeSprite(with drone: SKSpriteNode) -> SKSpriteNode {
        drone.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        drone.color = .white
        drone.colorBlendFactor = 1
        drone.zPosition = 1
        drone.zRotation = 0
        drone.alpha = 1
        return drone
    }
}
