//
//  UploadData.swift
//  CloseWise
//
//  Created by Manoj  on 25/03/23.
//

import UIKit
import SkyFloatingLabelTextField

enum TextFieldType{
    case name
    case email
    case mobileNumber
    case none
    case password
    case nnaProfile
    case linkdin
    case website
    case address
    case reason
}

@IBDesignable
class CommonTextFieldView: UIView {

//    MARK:- IBOutlets
//    =================
    @IBOutlet weak var rightSideBtn: UIButton!
    @IBOutlet weak var txtSuperView: UIView!
    @IBOutlet weak var txtField: SkyFloatingLabelTextField!
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var alertLbl: UILabel!
    @IBOutlet weak var separartoreView: UIView!
    @IBOutlet weak var leftButton: UIButton!
    //    MARK:- Variables
//    =================
    var rightSideBtnTapped: (( _ selected : Bool) -> Void)?
    private var isAlert: Bool = true
    
    var isHaveAlert: Bool {
        get{
            return isAlert
        }
        set(newValue){
           isAlert = newValue
        }
    }
        
    var type: TextFieldType = .name
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppreance()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupAppreance()
    }
    @IBAction func rightSideBtnTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        rightSideBtn.setImage(sender.isSelected ? UIImage(named: "dropDown") : UIImage(named: "eyeProtectIcon"), for: .normal)
        txtField.isSecureTextEntry = !sender.isSelected
        self.rightSideBtnTapped?(sender.isSelected)
    }
    
    private func setupAppreance(){
        self.loadNib(identifier: CommonTextFieldView.self)
        txtField.font = UIFont.Poppins_Medium(setsize: 14)
        txtField.textColor = ThemeWrapper.Shared.appColors.txtFieldTextBlack
        txtField.placeholderColor = ThemeWrapper.Shared.appColors.txtPlaceholder
        txtSuperView.backgroundColor = ThemeWrapper.Shared.appColors.white
        txtField.titleFont = UIFont.Poppins_Regular(setsize: 12)
        txtField.selectedTitleColor = ThemeWrapper.Shared.appColors.txtPlaceholder
        txtField.placeholderFont = UIFont.Poppins_Regular(setsize: 12)
        txtField.titleColor = ThemeWrapper.Shared.appColors.txtPlaceholder
        txtField.lineHeight = 0.0
        txtField.title = ""
        txtField.lineColor = ThemeWrapper.Shared.appColors.clearColor
        txtField.selectedLineColor = ThemeWrapper.Shared.appColors.clearColor
        txtField.selectedLineHeight = 0.0
        alertLbl.text = ""
        self.backgroundColor = ThemeWrapper.Shared.appColors.white
        self.txtSuperView.dropShadow(cornerRadus: 5, shadowColor: ThemeWrapper.Shared.appColors.selectedTxtFieldShadow.withAlphaComponent(0.16), shadowOffset: CGSize(width: 0, height: 3), shadowOpacity: 1, shadowRadius: 6)
        self.txtSuperView.addBorder(color: ThemeWrapper.Shared.appColors.selectedTxtFieldShadow, width: 1)
        separartoreView.backgroundColor = ThemeWrapper.Shared.appColors.grayTxtFieldShadow
    }
    
   
    func setPlaceHolder(text: String){
        txtField.placeholder = text.capitalized
    }
    
    func textFieldType(textField: TextFieldType){
        type = textField
        switch type {
        case .email:
            txtField.autocorrectionType = .yes
            txtField.textContentType = .emailAddress
            txtField.keyboardType = .emailAddress
            txtField.returnKeyType = .done
            rightSideBtn.isHidden = true
            leftView.isHidden = true
        case .mobileNumber:
            txtField.textContentType = .telephoneNumber
            txtField.autocorrectionType = .yes
            txtField.keyboardType = .numberPad
            txtSuperView.semanticContentAttribute = .forceLeftToRight
            rightSideBtn.isHidden = true
            leftView.isHidden = false
            leftButton.setImage(UIImage(named: ""), for: .normal)
        case .name:
            txtField.autocorrectionType = .yes
            txtField.textContentType = .name
            txtField.keyboardType = .namePhonePad
            txtField.returnKeyType = .next
            rightSideBtn.isHidden = true
            leftView.isHidden = true
        case .password:
            txtField.keyboardType = .default
            txtField.returnKeyType = .next
            rightSideBtn.isHidden = false
            txtField.isSecureTextEntry = true
            leftView.isHidden = true
        case .linkdin:
            txtField.keyboardType = .default
            txtField.returnKeyType = .next
            rightSideBtn.isHidden = true
            leftView.isHidden = false
            leftButton.setImage(UIImage(named: "eyeProtectIcon"), for: .normal)
            leftButton.setTitle("", for: .normal)
        case .website:
            txtField.keyboardType = .default
            txtField.returnKeyType = .next
            rightSideBtn.isHidden = true
            leftView.isHidden = false
            leftButton.setImage(UIImage(named: "eyeProtectIcon"), for: .normal)
            leftButton.setTitle("", for: .normal)
        case .address:
            txtField.keyboardType = .default
            txtField.returnKeyType = .next
            rightSideBtn.isHidden = true
            leftView.isHidden = false
            leftButton.setImage(UIImage(named: "eyeProtectIcon"), for: .normal)
            leftButton.setTitle("", for: .normal)

        default:
            txtField.keyboardType = .default
            txtField.returnKeyType = .next
            rightSideBtn.isHidden = true
            leftView.isHidden = true
        }
        self.layoutIfNeeded()
    }
    
    func setAlert(isHaveAlert: Bool, msg: String, isBorder: Bool = false){
        self.isHaveAlert = isHaveAlert
        alertLbl.isHidden = !isHaveAlert
        txtField.lineColor = isHaveAlert ? .orange : .black
        showAlertLbl(isShow: isHaveAlert)
        alertLbl.text = msg
    }
    
    func setAlertForPhone(isHaveAlert: Bool, msg: String){
        self.isHaveAlert = isHaveAlert
        alertLbl.isHidden = false
        txtField.lineColor = isHaveAlert ? .orange : .black
        showAlertLbl(isShow: isHaveAlert)
       // alertLbl.text = msg.isEmpty ? StringConstants.mobileNumberExample.localized + getnumberHint() : msg
    }
    
    func setAlertText(msg: String){
        showAlertLbl(isShow: true)
        alertLbl.text = msg
    }
    
    func setAlertTextForPhone(msg: String){
        showAlertLbl(isShow: true)
    }
    
    func showAlertLbl(isShow: Bool){
        alertLbl.isHidden = !isShow
    }
    
    func setText(txt: String){
        txtField.text = txt
    }
    
}


