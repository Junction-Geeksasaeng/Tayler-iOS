//
//  UIView+Extension.swift
//  tayler
//
//  Created by 서은수 on 2022/08/20.
//

import UIKit

extension UIView {
    /* view에 그라데이션 적용 -> vertical style */
    func setGradient(startColor: UIColor, endColor: UIColor){
        let gradient = CAGradientLayer()
        // startColor가 더 연한 색깔
        gradient.colors = [startColor.cgColor, endColor.cgColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.frame = bounds
        layer.addSublayer(gradient)
    }
}
