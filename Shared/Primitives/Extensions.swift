// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit

extension CGSize {
    init(square: Double) {
        self.init(width: square, height: square)
    }

    var radius: Double { width / 2.0 }
}

extension SKSpriteNode {
    var radius: Double {
        get { size.width / 2.0 }
        set { size = CGSize(square: newValue * 2.0) }
    }
}

extension CGFloat {
    static let tau = CGFloat.pi * 2

    func asString(decimals: Int) -> String {
        Double(self).asString(decimals: decimals)
    }
}

extension Double {
    static let tau = Double.pi * 2

    func asString(decimals: Int) -> String {
        let format = String(format: "%%.0\(decimals)f")
        return String(format: format, self)
    }
}

// 🙏
// https://gist.github.com/backslash-f/487f2b046b1e94b2f6291ca7c7cd9064
extension ClosedRange {
    func clamp(_ value: Bound) -> Bound {
        return lowerBound > value ? self.lowerBound
            : upperBound < value ? self.upperBound
            : value
    }
}

extension CGPoint {
    static let anchorAtCenter = CGPoint(x: 0.5, y: 0.5)

    enum CompactType { case xy, rθ }

    func getCompact(_ type: CompactType = CompactType.xy) -> String {
        switch type {
        case .xy:
            let xx = Double(self.x).asString(decimals: 2)
            let yy = Double(self.y).asString(decimals: 2)
            return "(x: \(xx), y: \(yy))"

        case .rθ:
            let rr = Double(self.hypotenuse / 2).asString(decimals: 2)
            let θθ = Double(self.theta).asString(decimals: 2)
            return "(r: \(rr), θ: \(θθ))"
        }
    }
}
