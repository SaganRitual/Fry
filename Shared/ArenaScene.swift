// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit
import SwiftUI

// Only handles internal scaling, knows nothing about the final scale to
// the arena
class ScaleTracker {
    var scales = [Double]()

    func getAccumulatedScale(at index: Int) -> Double {
        if index == 0 { return 1 }

        return scales.dropLast(scales.count - index).reduce(1, *)
    }

    func registerScale(_ scale: Double) { scales.append(scale) }

    func rescale(at index: Int, penRingRadius: Double) {
        scales[index] = penRingRadius
    }
}

class ArenaScene: SKScene, SKSceneDelegate, ObservableObject {
    var tickCount = 0

    lazy var dotter = Dotter(
        self, dotSize: CGSize(square: 2.5), dotLifespan: 10
    )

    override init(size: CGSize) {
        super.init(size: size)

        backgroundColor = NSColor(calibratedWhite: 0.1, alpha: 0.1)
        anchorPoint = CGPoint(x: 0.5, y: 0.5)

        let mainRingSpinHz = UserDefaults.standard.double(forKey: "mainRingSpinRate")
        babushka = Babushka(arena: self, rotationHz: mainRingSpinHz)
    }

    // The radius is our scale factor. The 95% is to shrink it enough to
    // keep the circles visible
    lazy var arenaDiameter = 0.95 * self.size.width
    lazy var arenaRadius = arenaDiameter / 2.0

    var babushka: Babushka!

    override func didMove(to view: SKView) {
        makeRings(2)
    }

    func makeRings(_ cRings: Int) {
        let hueDelta = 1.0 / Double(cRings)

        for ringIx in 0..<cRings {
            let hue = (0.5 + Double(ringIx) * hueDelta).truncatingRemainder(dividingBy: 1)

            let color = SKColor(calibratedHue: hue, saturation: 0.5, brightness: 1, alpha: 1)
            let penRingRadius = 1.0 - Double(ringIx) * 0.1

            precondition(penRingRadius > 0, "Weird pen ring radius")

            print("makeRings penRingRadius = \(penRingRadius.asString(decimals: 4))")

            babushka.makeRing(penRingRadius: penRingRadius, color: color)
        }
    }

    override func update(_ currentTime: TimeInterval) {
        tickCount += 1

        babushka.rotate()
//
//        let hue = Double(tickCount % 600) / 600.0
//        let color = EnglishBobColor(hue: hue, saturation: 1, brightness: 1, alpha: 1)
//
//        let e = elves.last!
//        let s = e.sprite
//        let p = (s.position - CGPoint(x: 5, y: 0)) + CGPoint(x: e.penRingRadius * s.radius, y: 0)
//        let drop = s.convert(p, to: self)
//        dotter.dropDot(at: drop, color: color)
    }

    func showRings(_ show: Bool) {
//        trundle?.showRings(show)
    }

    func setPenRingRadius(_ radius: Double) {
//        if elves.count > 1 {
//            print("arena set prr \(radius), scale \(self.size.radius)")
//            elves[1].setPenRingRadius(radius, arenaScale: self.size.radius)
//        }
    }

    func setMainRingSpeed(_ cyclesPerSecond: Double) {
        babushka.setMainRingSpeed(cyclesPerSecond)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
