// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit

class Trundle {
    let spindleSR: SpinnyRing
    let penSR: SpinnyRing

    let pis = NSNotification.Name("parentIsScaling")

    var trundleScaleFactor: Double { penSR.sprite.radius }
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

    func setPenRingRadius(_ radius: Double) {
        let scaleRadius = SKAction.customAction(
            withDuration: abs(radius - penSR.sprite.radius)
        ) { [self] _, newRadius in
            penSR.sprite.radius = newRadius * trundleScaleFactor
        }

        penSR.sprite.run(scaleRadius, withKey: "animatePenRingRadius")
    }

    func showRings(_ show: Bool) {
        spindleSR.isVisible = show
        penSR.isVisible = show
    }
}
