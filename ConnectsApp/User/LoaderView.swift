//
//  LoaderView.swift
//  ConnectsApp
//
//  Created by Utkarsh on 22/07/23.
//

import UIKit
import IHProgressHUD

class LoaderView: UIView {
    
    override func awakeFromNib() {
       
    }
    func showHood(){
        IHProgressHUD().center = self.center
        guard let screen =  SceneDelegate.shared?.window else {return}
        IHProgressHUD.setOffsetFromCenter(UIOffset(horizontal: screen.center.x , vertical: screen.center.y ))
        IHProgressHUD.show()
        
    }
}
