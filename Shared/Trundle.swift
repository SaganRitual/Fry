// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit

class Trundle {
    let spindleSR: SpinnyRing
    let penSR: SpinnyRing

    let pis = NSNotification.Name("parentIsScaling")

    var trundleScaleFactor: Double { 1 - spindleSR.sprite.radius }
    let sceneScaleFactor: CGSize

    init(
        sceneSize: CGSize, parentTrundle: SKNode, color: SKColor
    ) {
        self.sceneScaleFactor = sceneSize

        self.spindleSR = SpinnyRing(
            type: .spindle, parentSKNode: parentTrundle, color: .yellow
        )

        self.penSR = SpinnyRing(
            type: .pen, parentSKNode: parentTrundle,
            color: .red, penRadius: 0.37
        )

        NotificationCenter.default.addObserver(
            forName: pis, object: nil, queue: nil, using: parentIsScaling
        )

        NotificationCenter.default.post(name: pis, object: nil)
    }

    func parentIsScaling(_ notification: Notification) {
        print("parent is scaling")
    }

    func setPenRingRadius(_ targetRadius: Double) {
        print("sprr", abs(targetRadius - penSR.sprite.radius), targetRadius, penSR.sprite.radius)
        let currentRadius = penSR.sprite.radius

        let scaleToTargetRadius = SKAction.customAction(
            withDuration: abs(targetRadius - penSR.sprite.radius)
        ) { [self] _, newRadius in
            penSR.sprite.radius = currentRadius + newRadius * trundleScaleFactor
            print("scaleRadius", penSR.sprite.radius, newRadius, trundleScaleFactor)
        }

        penSR.sprite.run(scaleToTargetRadius, withKey: "animatePenRingRadius")
    }

    func showRings(_ show: Bool) {
        spindleSR.isVisible = show
        penSR.isVisible = show
    }
}
