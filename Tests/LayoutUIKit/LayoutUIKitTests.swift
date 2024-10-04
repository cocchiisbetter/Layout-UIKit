// Copyright © 2024 Cocchi is better. All rights reserved.

import Testing
import UIKit
import LayoutUIKit

@MainActor enum Tests {
    @Test static func simpleApplyTest() {
        let frame = CGRect(x: 0, y: 100, width: 200, height: 300)
        let view = UIView()

        view.layout { f in
            f = frame
        }

        #expect(view.frame == frame)
    }

    @Test static func transformeDurabilityTest() {
        let frame = CGRect(x: 0, y: 100, width: 200, height: 300)
        let view = UIView()

        view.transform = .init(rotationAngle: .pi / 2)
        view.layout { f in
            f = frame
        }
        view.transform = .identity

        #expect(view.frame == frame)
    }

    @Test static func transforme3dDurabilityTest() {
        let frame = CGRect(x: 0, y: 100, width: 200, height: 300)
        let view = UIView()

        var transform3d = CATransform3DIdentity
        transform3d = CATransform3DScale(transform3d, 2, 2, 2)

        view.layer.transform = transform3d
        view.layout { f in
            f = frame
        }
        view.layer.transform = CATransform3DIdentity

        #expect(view.frame == frame)
    }

    @Test static func bothTransformDurabilityTest() {
        let frame = CGRect(x: 0, y: 100, width: 200, height: 300)
        let view = UIView()

        var transform3d = CATransform3DIdentity
        transform3d = CATransform3DScale(transform3d, 2, 2, 2)

        view.transform = .init(rotationAngle: .pi / 2)
        view.layer.transform = transform3d
        view.layout { f in
            f = frame
        }
        view.transform = .identity
        view.layer.transform = CATransform3DIdentity

        #expect(view.frame == frame)
    }
}
