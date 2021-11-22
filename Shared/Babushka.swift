// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation

class Babushka {
    var arena: ArenaScene
    var rings = [Owl]()

    var count: Int { rings.count }
    var isEmpty: Bool { rings.isEmpty }

    var applyRotation = [Bool]()

    let ticksPerSecond = 60.0
    let radiansPerCycle = Double.tau
    var radiansPerTick: Double

    init(arena: ArenaScene, rotationHz: Double) {
        self.arena = arena
        self.radiansPerTick = rotationHz * radiansPerCycle / ticksPerSecond
    }

    func deepScale() -> Double { deepScale(at: rings.count) }

    func deepScale(at index: Int) -> Double {
        if index == 0 { return arena.size.radius }

        precondition(index <= rings.count)

        return rings[0..<index].reduce(arena.size.radius) {
            $0 * $1.penRingRadius
        }
    }

    func makeRing(penRingRadius: Double, color: EnglishBobColor) {
        precondition(
            !rings.isEmpty || penRingRadius == 1.0,
            "Outermost ring's radius must always be 1"
        )

        let owl = Owl(
            penRingRadius: penRingRadius,
            scale: deepScale(), color: color
        )

        if let parentRing = rings.last {
            parentRing.ringSprite.addChild(owl.ringSprite)
        } else {
            arena.addChild(owl.ringSprite)
        }

        rings.append(owl)
    }

    func rotate() {
        var rotation = radiansPerTick

        if applyRotation.isEmpty {
            applyRotation = [Bool](repeating: true, count: rings.count)
        }

        for (owl, apply) in zip(rings, applyRotation) {
            rotation = owl.rotate(against: rotation, applyToSprite: apply)
        }
    }

    func setMainRingSpeed(_ rotationHz: Double) {
        self.radiansPerTick =
            radiansPerCycle / ticksPerSecond * rotationHz
    }

    func setPenRingRadius(_ radius: Double, forRing ringIx: Int) {
        // This only happens because we do our scene init in didMove(),
        // which happens approximately 4.7 years after the UI views appear
        if rings.isEmpty { return }

        precondition(
            ringIx > 0, "Pen ring radius is always 1 for the outer ring"
        )

        let ds = deepScale(at: ringIx)
        rings[ringIx].setPenRingRadius(radius, deepScale: ds)

        for ix in (ringIx + 1)..<rings.count {
            rings[ix].rescale(to: deepScale(at: ix))
        }
    }
}
