//
//  UIExtenstions.swift
//  CloseWise
//
//  Created by Manoj  on 25/03/23.
//

import Foundation
import UIKit

extension UIColor {
    
    public convenience init(_ r : CGFloat, _ g : CGFloat, _ b : CGFloat, _ alpha : CGFloat = 1.0) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
    }
    
    class var randomColor: UIColor {
        get {
            let red = CGFloat(arc4random()%256)/255.0
            let green = CGFloat(arc4random()%256)/255.0
            let blue = CGFloat(arc4random()%256)/255.0
            return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        }
    }
}
extension UIView {
    /**
     Methods will return view from nib.
     **/
    @discardableResult
    class func fromNib<T: UIView>() -> T {
        guard let contentView = Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)?.first as? T else {
            // xib not loaded, or its top view is of the wrong type
            fatalError("xib not loaded")
        }
        return contentView
    }
    
    /**
     Methods will load nib from given view identifier.
     - parameter identifier : UIView.Type
     **/
    func loadNib(identifier: UIView.Type) {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "\(identifier)", bundle: bundle)
        if let view = nib.instantiate(withOwner: self, options: nil).first as? UIView {
            view.frame = self.bounds
            self.addSubview(view)
        }
    }
    /**
     Methods will set corner radius with clip to bound enable.
     - parameter radius : CGFloat
     **/
    func setCornerRadius(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
    func dropShadow(cornerRadus: CGFloat, shadowColor: UIColor, shadowOffset: CGSize = .zero, shadowOpacity: Float,shadowRadius: CGFloat) {
           self.layer.masksToBounds = false
           self.layer.cornerRadius = cornerRadus
           self.layer.shadowColor = shadowColor.cgColor
           self.layer.shadowOffset = shadowOffset
           self.layer.shadowOpacity = shadowOpacity
           self.layer.shadowRadius = shadowRadius
       }
    /**
     Method will add border w.r.t given color, width and radius.
     - parameter color : UIColor
     - parameter width : CGFloat
     - parameter cornerRadius : CGFloat = 0.0
     **/
    func addBorder(color: UIColor, width: CGFloat, cornerRadius: CGFloat = 0.0) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
        if cornerRadius > 0.0 {
            self.layer.cornerRadius = cornerRadius
        }
    }
    func addDashBorder(color: UIColor, width: CGFloat = 1, cornerRadius: CGFloat = 0.0, dashPattern: [NSNumber] = [2,2]) {

        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.name = "ShapeLayer"
        shapeLayer.lineWidth = width
        shapeLayer.lineDashPattern = dashPattern
        shapeLayer.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerRadius).cgPath//UIBezierPath(rect: self.bounds).cgPath
        self.layer.masksToBounds = false
        self.layer.addSublayer(shapeLayer)
    }
}

extension UIViewController{
    class var storyboardID: String {
        return "\(self)"
    }

    static func instantiate(fromAppStoryboard appStoryboard: AppStoryboard) -> Self {
        return appStoryboard.viewController(viewControllerClass: self)
    }

}
extension UITableView{
    // Dequeue Collection View Cell
    func dequeueCell <T: UITableViewCell> (with identifier: T.Type, indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: "\(identifier.self)", for: indexPath) as! T
    }
    /**
    Register Cell Nib
    - parameter with: UITableViewCell.Type
    */
   func registerCell(with identifier: UITableViewCell.Type, bundle: Bundle? = nil) {
       self.register(UINib(nibName: "\(identifier.self)", bundle: bundle), forCellReuseIdentifier: "\(identifier.self)")
   }
   
   /**
    Register Header Footer View Nib
    - parameter with: UITableViewHeaderFooterView.Type
    */
   func registerHeaderFooter(with identifier: UITableViewHeaderFooterView.Type, bundle: Bundle? = nil) {
       self.register(UINib(nibName: "\(identifier.self)", bundle: bundle), forHeaderFooterViewReuseIdentifier: "\(identifier.self)")
   }
   
}
