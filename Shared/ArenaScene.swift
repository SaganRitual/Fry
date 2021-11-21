// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit
import SwiftUI

class ArenaScene: SKScene, SKSceneDelegate, ObservableObject {
    var tickCount = 0

    override init(size: CGSize) {
        super.init(size: size)

        backgroundColor = NSColor(calibratedWhite: 0.1, alpha: 0.1)
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
    }

    // The radius is our scale factor. The 95% is to shrink it enough to
    // keep the circles visible
    lazy var arenaScaleFactor = 0.95 * self.size.radius

    var wormClub: WormClub!

    override func didMove(to view: SKView) {
        let zilla = SpritePool.ringsPool.makeSprite()
        zilla.size = self.size
        zilla.color = .yellow
        zilla.anchorPoint = .anchorAtCenter
        self.addChild(zilla)

        zilla.setScale(0.5)

        print("zilla \(zilla.size), \(zilla.position)")

        let p0 = makePenRing(parent: zilla)
        let p1 = makePenRing(parent: p0)
        let p2 = makePenRing(parent: p1)
        let p3 = makePenRing(parent: p2)

        for p in [p0, p1, p2, p3] {
            let halfPulse0 = SKAction.move(by: CGVector(dx: p.radius * 2, dy: 0), duration: 2)
            halfPulse0.timingMode = .easeInEaseOut
            let pulse0Forever = SKAction.repeatForever(SKAction.sequence([halfPulse0, halfPulse0.reversed()]))
            let waitASecond = SKAction.wait(forDuration: 1)
            p.run(SKAction.sequence([waitASecond, pulse0Forever]))
        }

        zilla.setScale(1)
    }

    @discardableResult
    func makePenRing(parent: SKNode) -> SKSpriteNode {
        let penRing = SpritePool.ringsPool.makeSprite()

        penRing.color = .green
        penRing.anchorPoint = .anchorAtCenter
        parent.addChild(penRing)

        let parentRadius: Double
        switch parent {
        case let p as ArenaScene:
            parentRadius = p.size.radius
            penRing.size = p.size

        case let p as SKSpriteNode:
            parentRadius = p.size.radius
            penRing.size = p.size * 2.0

        default: fatalError()
        }

        print("pre \(penRing.radius)")

        penRing.setScale(0.5)

        let omg = (-parentRadius - penRing.radius) / 2.0
        penRing.position = CGPoint(x:omg, y: 0)

        print("child \(penRing.size), \(penRing.position), \(parentRadius), \(penRing.radius)")

        return penRing
    }

    func showRings(_ show: Bool) {
//        trundle?.showRings(show)
    }

    func setPenRingRadius(_ radius: Double) {
//        trundle?.setPenRingRadius(radius)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
