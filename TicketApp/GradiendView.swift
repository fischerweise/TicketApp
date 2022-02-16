//
//  GradiendView.swift
//  TicketApp
//
//  Created by Mustafa Pekdemir on 13.02.2022.
//

import Foundation
import UIKit
import ALBusSeatView

@IBDesignable final class GradientView: UIView {

    @IBInspectable var startColor: UIColor = UIColor(hexString: "#2c3e50")
    @IBInspectable var endColor: UIColor = UIColor(hexString: "#4ca1af")

    override class var layerClass: AnyClass {
        get {
            return CAGradientLayer.self
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradient()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupGradient()
    }

    private func setupGradient() {
        let gradient = self.layer as! CAGradientLayer
        gradient.colors = [startColor.cgColor, endColor.cgColor]
    }

}
