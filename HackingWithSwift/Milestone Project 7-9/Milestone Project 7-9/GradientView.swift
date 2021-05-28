//
//  GradientView.swift
//  Milestone Project 7-9
//
//  Created by Andrei Chenchik on 28/5/21.
//

import UIKit

class GradientView: UIView {
    private let gradient: CAGradientLayer = CAGradientLayer()
    private let gradientStartColor: UIColor
    private let gradientEndColor: UIColor
    
    init(gradientStartColor: UIColor, gradientEndColor: UIColor) {
        self.gradientStartColor = gradientStartColor
        self.gradientEndColor = gradientEndColor
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        gradient.frame = self.bounds
    }
    
    override func draw(_ rect: CGRect) {
        gradient.frame = self.bounds
        gradient.colors = [gradientStartColor.cgColor, gradientEndColor.cgColor]
        if gradient.superlayer == nil {
            layer.insertSublayer(gradient, at: 0)
        }
    }
}
