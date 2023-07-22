//
//  ConstantFile.swift
//  CloseWise
//
//  Created by Manoj  on 25/03/23.
//

import Foundation
import UIKit

class ThemeWrapper {
    static let Shared : ThemeWrapper = {
        return ThemeWrapper()
    }()
    
    lazy var appColors = AppColors()
}

struct AppColors{
    var themeColor = UIColor(76, 150, 206)
    var blackTextColor = UIColor(27, 36, 48, 1)
    var secondaryColor = UIColor(76, 150, 206)
    var disbaleButtonColor = UIColor(76, 150, 206, 0.7)
    var txtFieldTextBlack = UIColor(33, 33, 35, 0.8)
    var white = UIColor.white
    var txtPlaceholder = UIColor(118, 118, 118, 1)
    var grayColor = UIColor(118, 118, 118, 1)
    var clearColor = UIColor.clear
    var selectedTxtFieldShadow = UIColor(76, 150, 206)
    var grayTxtFieldShadow = UIColor(221, 221, 221, 1)
    var grayBorderColor = UIColor(229, 229, 229, 1)
    var lightBlueColor =  UIColor(130, 189, 222, 0.16)
    var dashGrayColor = UIColor(217, 217, 217, 1)
    var lightGrayBorder = UIColor(235, 235, 235, 1)
    var lightBlueShaddowColor = UIColor(224, 232, 252, 1)
    var orangeColor = UIColor(227, 173, 25, 1)
    var orangeLightColor = UIColor(254, 241, 233, 1)
    var greenColor = UIColor(217, 255, 234, 1)
    var darkGreenColor = UIColor(58, 163, 106, 1)
    var darkOrange = UIColor(238, 129, 87, 1)
    var greenButtonColor = UIColor(108, 208, 152, 1)
    var redButtonColor = UIColor(108, 208, 152, 1)
    var lightOrangeViewColor = UIColor(255, 248, 237, 1)
    var lightGreenViewColor = UIColor(227, 250, 255, 1)
    var lightRedViewColor = UIColor(239, 129, 87, 1)
    var disabledEmailColor = UIColor(245, 245, 245, 1)
    var shadowColor = UIColor(244, 247, 254)
    var yellowDotColor = UIColor(251, 198, 88, 1)
    var redBgColor = UIColor(255, 248, 237, 1)
    let confirmGreenColor = UIColor(107, 208, 152, 1)
}

