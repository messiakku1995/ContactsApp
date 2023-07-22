//
//  BaseVC.swift
//  CloseWise
//
//  Created by Manoj  on 25/03/23.
//

import UIKit

enum Controller{
    case login
    case register
    case home
}
class BaseVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
     //   self.setDefaultNvBar()
        // Do any additional setup after loading the view.
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) {
            return .lightContent
        } else {
            return .default
        }
    }
    func setNavigationBarTitle(controllerName: Controller, nav: UINavigationController?, headerTitle: String){
        let headerTitle  = ""
        nav?.navigationItem.titleView?.tintColor = .white
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white, NSAttributedString.Key.font: UIFont.Poppins_SemiBold(setsize: 20)]
        nav?.navigationBar.titleTextAttributes = textAttributes
    }
    func displayToastMessage(_ message : String) {

            let toastView = UILabel()
            toastView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
            toastView.textColor = UIColor.white
            toastView.textAlignment = .center
            toastView.font = UIFont.preferredFont(forTextStyle: .caption1)
            toastView.layer.cornerRadius = 25
            toastView.layer.masksToBounds = true
            toastView.text = message
            toastView.numberOfLines = 0
            toastView.alpha = 0
            toastView.translatesAutoresizingMaskIntoConstraints = false

            guard let window = UIApplication.shared.mainKeyWindow else {
               return
            }
        window.addSubview(toastView)

            let horizontalCenterContraint: NSLayoutConstraint = NSLayoutConstraint(item: toastView, attribute: .centerX, relatedBy: .equal, toItem: window, attribute: .centerX, multiplier: 1, constant: 0)

            let widthContraint: NSLayoutConstraint = NSLayoutConstraint(item: toastView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: 275)

            let verticalContraint: [NSLayoutConstraint] = NSLayoutConstraint.constraints(withVisualFormat: "V:|-(>=200)-[loginView(==50)]-68-|", options: [.alignAllCenterX, .alignAllCenterY], metrics: nil, views: ["loginView": toastView])

            NSLayoutConstraint.activate([horizontalCenterContraint, widthContraint])
            NSLayoutConstraint.activate(verticalContraint)

            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
                toastView.alpha = 1
            }, completion: nil)

            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double((Int64)(2 * NSEC_PER_SEC)) / Double(NSEC_PER_SEC), execute: {
                UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
                    toastView.alpha = 0
                }, completion: { finished in
                    toastView.removeFromSuperview()
                })
            })
        }

    func navigateOnViewController(pushedVC: Controller, parentVC: UIViewController, orderId: String = ""){
        switch pushedVC {
        case .register:
            let vc = RegisterUserVC.instantiate(fromAppStoryboard: .Main)
            vc.prepareView(vm: LoginVM())
            parentVC.navigationController?.pushViewController(vc, animated: true)
        case .home:
            let vc = ContactsVC.instantiate(fromAppStoryboard: .Main)
            vc.prepareView(vm: ContactsVM(repo: BaseRepository()))
            parentVC.navigationController?.setViewControllers([vc], animated: true)
        default:
            let vc = RegisterUserVC.instantiate(fromAppStoryboard: .Main)
            vc.prepareView(vm: LoginVM())
            parentVC.navigationController?.pushViewController(vc, animated: true)
        }
    }
    func setDefaultNvBar(tintColor: UIColor = .black, barTintColor: UIColor = ThemeWrapper.Shared.appColors.themeColor){

           self.navigationController?.navigationBar.tintColor = tintColor


           self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : tintColor, NSAttributedString.Key.font : UIFont.Poppins_Regular(setsize: 12)]

           self.navigationController?.navigationBar.barTintColor = barTintColor

           self.navigationController?.navigationBar.isTranslucent = false

           self.navigationController?.navigationBar.shadowImage = UIImage()

           if #available(iOS 15.0, *) {

                   let appearance = UINavigationBarAppearance()

              appearance.configureWithOpaqueBackground()

              appearance.backgroundColor =  barTintColor

              appearance.shadowColor = .clear

              appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor : tintColor, NSAttributedString.Key.font :                UIFont.Poppins_Regular(setsize: 12)]

                   self.navigationController?.navigationBar.standardAppearance = appearance

                   self.navigationController?.navigationBar.scrollEdgeAppearance = appearance

               }

             }
}

func displayToastMessageOutside(_ message : String) {

        let toastView = UILabel()
        toastView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        toastView.textColor = UIColor.white
        toastView.textAlignment = .center
        toastView.font = UIFont.preferredFont(forTextStyle: .caption1)
        toastView.layer.cornerRadius = 25
        toastView.layer.masksToBounds = true
        toastView.text = message
        toastView.numberOfLines = 0
        toastView.alpha = 0
        toastView.translatesAutoresizingMaskIntoConstraints = false

        guard let window = UIApplication.shared.mainKeyWindow else {
           return
        }
    window.addSubview(toastView)

        let horizontalCenterContraint: NSLayoutConstraint = NSLayoutConstraint(item: toastView, attribute: .centerX, relatedBy: .equal, toItem: window, attribute: .centerX, multiplier: 1, constant: 0)

        let widthContraint: NSLayoutConstraint = NSLayoutConstraint(item: toastView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: 275)

        let verticalContraint: [NSLayoutConstraint] = NSLayoutConstraint.constraints(withVisualFormat: "V:|-(>=200)-[loginView(==50)]-68-|", options: [.alignAllCenterX, .alignAllCenterY], metrics: nil, views: ["loginView": toastView])

        NSLayoutConstraint.activate([horizontalCenterContraint, widthContraint])
        NSLayoutConstraint.activate(verticalContraint)

        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
            toastView.alpha = 1
        }, completion: nil)

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double((Int64)(2 * NSEC_PER_SEC)) / Double(NSEC_PER_SEC), execute: {
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
                toastView.alpha = 0
            }, completion: { finished in
                toastView.removeFromSuperview()
            })
        })
    }
