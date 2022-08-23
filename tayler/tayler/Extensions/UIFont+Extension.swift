//
//  UIFont+Extension.swift
//  tayler
//
//  Created by 서은수 on 2022/08/20.
//

import UIKit

extension UIFont {
    public enum robotoFontType: String {
        case robotoBold = "Roboto-Bold"
        case robotoMedi = "Roboto-Medium"
        case robotoRegular = "Roboto-Regular"
    }
    
    static func robotoFont(_ type: robotoFontType, size: CGFloat) -> UIFont {
        return UIFont(name: "\(type.rawValue)", size: size)!
    }
}
