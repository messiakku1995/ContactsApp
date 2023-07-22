//
//  Utilities.swift
//  CloseWise
//
//  Created by Manoj  on 28/03/23.
//

import Foundation
import UIKit

@IBDesignable
class RoundedCornerButton: UIButton {

    override func draw(_ rect: CGRect) {
        self.clipsToBounds = true
    }

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderColor: UIColor = .clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    @IBInspectable var shadowColor: UIColor = .clear {
        didSet {
            self.layer.shadowColor = shadowColor.cgColor
        }
    }
    @IBInspectable var shadowOffset: CGSize = .zero {
        didSet {
            self.layer.shadowOffset = shadowOffset
        }
    }
    @IBInspectable var shadowOpacity: Float = 1 {
        didSet {
            self.layer.shadowOpacity = shadowOpacity
        }
    }
    @IBInspectable var shadowRadius: CGFloat = 0 {
        didSet {
            self.layer.shadowRadius = shadowRadius
        }
    }
    
}
@IBDesignable
class CustomView: UIView {
    
    @IBInspectable var cornerEdges : CGFloat = 0
    @IBInspectable  var topLeft: Bool = false
    @IBInspectable  var topRight: Bool = false
    @IBInspectable  var bottomLeft: Bool = false
    @IBInspectable  var bottomRight: Bool = false
    
    override func draw(_ rect: CGRect) {
        self.clipsToBounds = true
        if cornerEdges > 0{
            self.cornerRadiusOnView()
        }
    }

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.setCornerRadius(radius: cornerRadius)
        }
    }
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderColor: UIColor = .clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    @IBInspectable var shadowColor: UIColor = .clear {
        didSet {
            self.layer.shadowColor = shadowColor.cgColor
        }
    }
    @IBInspectable var shadowOffset: CGSize = .zero {
        didSet {
            self.layer.shadowOffset = shadowOffset
        }
    }
    @IBInspectable var shadowOpacity: Float = 1 {
        didSet {
            self.layer.shadowOpacity = shadowOpacity
        }
    }
    @IBInspectable var shadowRadius: CGFloat = 0 {
        didSet {
            self.layer.shadowRadius = shadowRadius
        }
    }
     func cornerRadiusOnView() {
       var options = UIRectCorner()
       if topLeft {
           options =  options.union(.topLeft)
       }
       if topRight {
           options =  options.union(.topRight)
       }
       if bottomLeft {
           options =  options.union(.bottomLeft)
       }
       if bottomRight {
           options =  options.union(.bottomRight)
       }


       let path = UIBezierPath(roundedRect:self.bounds,
                               byRoundingCorners:options,
                               cornerRadii: CGSize(width: self.cornerEdges, height: self.cornerEdges))

       let maskLayer = CAShapeLayer()

       maskLayer.path = path.cgPath
       self.layer.mask = maskLayer
   }
}
class RectangularDashedView: CustomView {

    @IBInspectable var dashWidth: CGFloat = 0
    @IBInspectable var dashColor: UIColor = .clear
    @IBInspectable var dashLength: CGFloat = 0
    @IBInspectable var betweenDashesSpace: CGFloat = 0
    
    var dashBorder: CAShapeLayer?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        dashBorder?.removeFromSuperlayer()
        let dashBorder = CAShapeLayer()
        dashBorder.lineWidth = dashWidth
        dashBorder.strokeColor = dashColor.cgColor
        dashBorder.lineDashPattern = [dashLength, betweenDashesSpace] as [NSNumber]
        dashBorder.frame = bounds
        dashBorder.fillColor = nil
        if cornerRadius > 0 {
            dashBorder.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        } else {
            dashBorder.path = UIBezierPath(rect: bounds).cgPath
        }
        layer.addSublayer(dashBorder)
        self.dashBorder = dashBorder
    }
}
enum AppStoryboard: String{
    case Container
    case Main
    case Popups
    
    var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    func viewController<T: UIViewController>(viewControllerClass: T.Type, function: String = #function, line: Int = #line, file: String = #file) -> T {
        
        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
        guard let scene = instance.instantiateViewController(withIdentifier: storyboardID) as? T else {
            fatalError("ViewController with identifier \(storyboardID), not found in \(self.rawValue) Storyboard.\nFile : \(file) \nLine Number : \(line) \nFunction : \(function)")
        }
        return scene
    }
    
    func initialViewController() -> UIViewController? {
        return instance.instantiateInitialViewController()
    }
}
