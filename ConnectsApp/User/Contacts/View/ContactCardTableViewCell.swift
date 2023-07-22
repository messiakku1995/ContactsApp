//
//  ContactCardTableViewCell.swift
//  ConnectsApp
//
//  Created by Utkarsh on 22/07/23.
//

import UIKit
import Kingfisher

class ContactCardTableViewCell: UITableViewCell {

    @IBOutlet weak var viewImgOverlay: UIView!
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var viewStatus: CustomView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblUserCompany: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func prepareView(data: UserContact?, index: Int) {
        self.viewImgOverlay.isHidden = index == 1
        if index % 2 != 0 {
            self.bgView.backgroundColor = .lightGray.withAlphaComponent(0.15)
        } else {
            self.bgView.backgroundColor = .white
        }
        
        guard let user = data else { return }
        if let imgUrl = URL(string: user.avatar) {
            self.imgUser.kf.setImage(with: imgUrl)// .load(url: imgUrl)
        }
        
        self.lblUserName.text = "\(user.firstName) \(user.lastName)"
        self.lblUserCompany.text = "\(user.email)"
    }
    
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

