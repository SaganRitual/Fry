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
        makeRings(3)
    }

    func makeRings(_ cRings: Int) {
        let hueDelta = 1.0 / Double(cRings)

        for ringIx in 0..<cRings {
            let hue = (0.5 + Double(ringIx) * hueDelta).truncatingRemainder(dividingBy: 1)

            let color = SKColor(calibratedHue: hue, saturation: 0.5, brightness: 1, alpha: 1)
            let penRingRadius = 0.95 - Double(ringIx) * 0.1

            let elf = (ringIx == 0) ?
            Elf(parent: self, color: color) :
            Elf(parent: elves.last!, penRingRadius: penRingRadius, color: color)

            elves.append(elf)
        }
    }

    let radiansPerCycle = Double.tau
    let cyclesPerSecond = 1.0
    let ticksPerSecond = 60.0
    var radiansPerTick = Double.tau / 60

    func setMainRingSpeed(_ cyclesPerSecond: Double) {
        self.radiansPerTick =
            radiansPerCycle / ticksPerSecond * cyclesPerSecond
    }

    override func update(_ currentTime: TimeInterval) {
        var rotation = radiansPerTick

        var applyRotation = [Bool](repeating: true, count: elves.count)
        applyRotation[0] = true

        for (elf, apply) in zip(elves, applyRotation) {
            rotation = elf.rotate(against: rotation, applyToSprite: apply)
        }
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
