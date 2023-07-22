//
//  RegisterUserVC.swift
//  ConnectsApp
//
//  Created by Utkarsh on 22/07/23.
//

import UIKit

class RegisterUserVC: BaseVC {
    
    @IBOutlet weak var emailTextFieldView: CommonTextFieldView!
    @IBOutlet weak var passwordTextFieldView: CommonTextFieldView!
    @IBOutlet weak var btnRegister: UIButton!
    
    var viewModel: LoginVM!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    func setupUI(){
        emailTextFieldView.txtField.delegate = self
        emailTextFieldView.setPlaceHolder(text: "Email Address")
        emailTextFieldView.txtField.title = "Email Address"
        emailTextFieldView.textFieldType(textField: .email)
        emailTextFieldView.txtField.addTarget(self, action: #selector(textFieldValueChange(_:)), for: .editingChanged)
        passwordTextFieldView.txtField.delegate = self
        passwordTextFieldView.txtField.title = "Password"
        passwordTextFieldView.setPlaceHolder(text: "Password")
        passwordTextFieldView.textFieldType(textField: .password)
        passwordTextFieldView.txtField.addTarget(self, action: #selector(textFieldValueChange(_:)), for: .editingChanged)
        passwordTextFieldView.txtSuperView.addBorder(color: ThemeWrapper.Shared.appColors.grayTxtFieldShadow, width: 1)
        passwordTextFieldView.rightSideBtn.setImage(UIImage(named:"eyeProtectIcon"), for: .normal)
        passwordTextFieldView.rightSideBtn.setImage(UIImage(named: "10131949_eye_line_icon"), for: .selected)
        passwordTextFieldView.rightSideBtn.backgroundColor = .clear
        emailTextFieldView.txtSuperView.addBorder(color: ThemeWrapper.Shared.appColors.grayTxtFieldShadow, width: 1)
        btnRegister.backgroundColor = ThemeWrapper.Shared.appColors.themeColor
        btnRegister.dropShadow(cornerRadus: 6, shadowColor: ThemeWrapper.Shared.appColors.themeColor, shadowOffset: CGSize(width: 0, height: 6), shadowOpacity: 0.6, shadowRadius: 6)
        btnRegister.setTitle("REGISTER", for: .normal)
        btnRegister.titleLabel?.font = UIFont.Poppins_SemiBold(setsize: 16)
        btnRegister.setTitleColor(.white, for: .normal)
        
        passwordTextFieldView.rightSideBtnTapped = {[weak self] selected in
            
        }
    }
    
    func prepareView(vm: LoginVM) {
        self.viewModel = vm
    }
    
    @IBAction func btnRegisterAction(_ sender: Any) {
        guard let emailText = emailTextFieldView.txtField.text, let password =  passwordTextFieldView.txtField.text else { return  }
        if emailText.isEmpty {
            self.displayToastMessage("Please Enter Email")
        }else if !emailText.isValidEmail(){
            self.displayToastMessage("Please Enter a Valid Email")
        }else if password.isEmpty{
            self.displayToastMessage("Please Enter Password")
        }else{
            viewModel.register(loginRequest: LoginInRequest(email: emailText ,password: password )) { [weak self] suceessData in
                guard let self = self, let loginData = suceessData else {return}
                if (loginData.token != nil) {
                    UserDefaults.standard.set(loginData.token ?? "", forKey: "token")
                    self.navigateOnViewController(pushedVC: .home, parentVC: self)
                }else{
                    self.displayToastMessage(loginData.error ?? "")
                }
            }
        }
    }
}

extension RegisterUserVC: UITextFieldDelegate{
    @objc func textFieldValueChange(_ textField: UITextField){
        if textField == emailTextFieldView.txtField{
            emailTextFieldView.txtSuperView.addBorder(color: textField.text?.isEmpty ?? false ? ThemeWrapper.Shared.appColors.grayTxtFieldShadow : ThemeWrapper.Shared.appColors.themeColor, width: 1)
        }else{
            passwordTextFieldView.txtSuperView.addBorder(color: textField.text?.isEmpty ?? false ? ThemeWrapper.Shared.appColors.grayTxtFieldShadow : ThemeWrapper.Shared.appColors.themeColor, width: 1)
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == passwordTextFieldView.txtField{
            let minLength = 8
            let maxLength = 20
            let currentString: NSString = textField.text! as NSString
            
            let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
            return (minLength <= newString.length) || (newString.length <= maxLength)
        }else{
            return true
        }
    }
}

