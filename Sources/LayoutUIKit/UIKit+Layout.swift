// Copyright © 2024 Cocchi is better. All rights reserved.

import UIKit

public enum LayoutUIKit {
    public enum Mode {
        /// (Default) Rounds the frame according to screen scaling.
        case rounded
        /// Non-rounding mode. Used to implement parallax, etc.
        case floating
    }
}

public extension UIView {
    func layout(_ mode: LayoutUIKit.Mode = .rounded, _ modifier: (inout CGRect) -> Void) {
        var f = CGRect(origin: .zero, size: bounds.size)
        modifier(&f)

        switch mode {
        case .rounded:
            setFrameWithIdentityTransform(f.rounded)

        case .floating:
            setFrameWithIdentityTransform(f)
        }
    }
}

extension UIView {
    func setFrameWithIdentityTransform(_ rect: CGRect) {
        if transform != .identity && !CATransform3DIsIdentity(layer.transform) {
            let lastTransform = transform
            let lastTransform3D = layer.transform

            transform = .identity
            layer.transform = CATransform3DIdentity
            setFrameIfNeeded(rect)

            transform = lastTransform
            layer.transform = lastTransform3D
        }
        else if transform != .identity {
            let lastTransform = transform

            transform = .identity
            setFrameIfNeeded(rect)

            transform = lastTransform
        }
        else if !CATransform3DIsIdentity(layer.transform) {
            let lastTransform3D = layer.transform

            layer.transform = CATransform3DIdentity
            setFrameIfNeeded(rect)

            layer.transform = lastTransform3D
        }
        else {
            setFrameIfNeeded(rect)
        }
    }

    func setFrameIfNeeded(_ rect: CGRect) {
        if frame != rect {
            frame = rect
            setNeedsLayout()
        }
    }
}

extension CGRect {
    @MainActor var rounded: CGRect {
        let scale = UIScreen.main.scale
        return CGRect(x: (origin.x * scale).rounded() / scale,
                      y: (origin.y * scale).rounded() / scale,
                      width: (width * scale).rounded(.up) / scale,
                      height: (height * scale).rounded(.up) / scale)
    }
}
