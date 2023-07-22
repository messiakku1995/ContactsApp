//
//  ContactsVC.swift
//  ConnectsApp
//
//  Created by Utkarsh on 22/07/23.
//

import UIKit

class ContactsVC: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var imgPlus: UIImageView!
    
    var viewModel: ContactsVM!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupUI()
    }
    
    func setupUI() {
        tblView.registerCell(with: ContactCardTableViewCell.self)
    }
    
    func prepareView(vm: ContactsVM) {
        self.viewModel = vm
        
        self.viewModel.reloadView = { [weak self] in
            guard let self = self else { return }
            self.tblView.reloadData()
        }
    }
    
    @IBAction func btnSideMenuAction(_ sender: Any) {
        self.resetDefaults()
        self.setLoginVC()
    }
    
    func resetDefaults() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
    
    func setLoginVC() {
        let loginVC = LoginVC.instantiate(fromAppStoryboard: .Main)
        let nvc = UINavigationController(rootViewController: loginVC)
        SceneDelegate.shared?.window?.rootViewController = nvc
        SceneDelegate.shared?.window?.makeKeyAndVisible()
    }
}

extension ContactsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.allUsers?.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCardTableViewCell", for: indexPath) as! ContactCardTableViewCell
        
        cell.prepareView(data: self.viewModel.allUsers?.data?[indexPath.row], index: indexPath.row)
        
        let totalUser = self.viewModel.allUsers?.total ?? 0
        let loadedCount = self.viewModel.allUsers?.data?.count ?? 0
        let nextPage = self.viewModel.currentPage + 1
        
        if indexPath.row == loadedCount - 1 { // last cell
            if totalUser > loadedCount { // more items to fetch
                self.viewModel.fetchUserData()
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
}
