// Copyright © 2024 Cocchi is better. All rights reserved.

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        // 1. construct the view hierarchy
        view.addSubview(indicator)
        view.addSubview(scrollView)
        scrollView.addSubview(label)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        let w = view.bounds.width
        let h = view.bounds.height
        let progress = scrollView.contentOffset.y / (scrollView.contentSize.height - h)

        label.font = .systemFont(ofSize: w, weight: .heavy)
        label.textColor = .init(white: progress, alpha: 1)
        scrollView.contentSize.height = label.frame.height
        scrollView.indicatorStyle = (0.5 < progress ? .white : .black)

        // 2. set view.bound to fill screen
        scrollView.layout { f in
            f = view.bounds
        }

        // 3. calculate the frame to lay out a view
        label.layout { f in
            f.size = label.sizeThatFits(.zero)
            f.origin.x = (w - f.width) / 2
            f.origin.y = (f.width - f.height) / 2
        }

        // 4. use .floating mode to implement smooth parallax
        indicator.layout(.floating) { f in
            f.size.width = w
            f.size.height = h * progress
            f.origin.y = h * (1 - progress)
        }
    }

    // MARK: - Subviews

    lazy var scrollView: UIScrollView = {
        let v = UIScrollView()
        v.delegate = self
        v.backgroundColor = .clear
        return v
    }()

    lazy var label: UILabel = {
        let v = UILabel()
        v.text = "HELLO WORLD"
        v.transform = .init(rotationAngle: .pi / 2)
        return v
    }()

    lazy var indicator: UIView = {
        let v = UIView()
        v.backgroundColor = .black
        return v
    }()
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.setNeedsLayout()
    }
}
