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
    lazy var arenaDiameter = 0.95 * self.size.width
    lazy var arenaRadius = arenaDiameter / 2.0

    var elves = [Elf]()

    override func didMove(to view: SKView) {
        let zilla = Elf(parent: self, color: .cyan)

//        let zilla = SpritePool.ringsPool.makeSprite()
//        zilla.size = self.size
//        zilla.color = .cyan
//        zilla.anchorPoint = .anchorAtCenter
//        self.addChild(zilla)

//        let e0 = Elf(parent: zilla, penRingRadius: 0.75, color: .magenta)
//        let e1 = Elf(parent: e0, penRingRadius: 0.71, color: .green)

        elves.append(contentsOf: [zilla])

//        for p in [e0, e1] {
//            let halfPulse0 = SKAction.move(by: CGVector(dx: p.radius * 2, dy: 0), duration: 2)
//            halfPulse0.timingMode = .easeInEaseOut
//            let pulse0Forever = SKAction.repeatForever(SKAction.sequence([halfPulse0, halfPulse0.reversed()]))
//            let waitASecond = SKAction.wait(forDuration: 1)
//            p.run(SKAction.sequence([waitASecond, pulse0Forever]))
//        }
    }

    override func update(_ currentTime: TimeInterval) {
        var rotation = 0.1 * Double.tau / 60.0

        for elf in elves {
            rotation = elf.rotate(against: rotation)
        }
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

        penRing.setScale(0.5)

        let omg = (-parentRadius - penRing.radius) / 2.0
        penRing.position = CGPoint(x:omg, y: 0)

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
