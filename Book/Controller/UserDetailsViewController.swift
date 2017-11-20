//
//  UserDetailsViewController.swift
//  Book
//
//  Created by Alexandr Voronoy on 19.11.17.
//  Copyright © 2017 Alexandr Voronoy. All rights reserved.
//

import UIKit

class UserDetailsViewController: UIViewController {
    
    @IBOutlet weak private var lcActionsBottomMargin: NSLayoutConstraint!
    @IBOutlet weak private var ibImage: UIImageView!
    @IBOutlet weak private var ibFirstName: UITextField!
    @IBOutlet weak private var ibSecondName: UITextField!
    @IBOutlet weak private var ibPhone: UITextField!
    @IBOutlet weak private var ibEmail: UITextField!
    @IBOutlet weak private var ibDelete: UIButton!
    
    private var newRegistration: Bool = false
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ibImage.image = user?.image
        ibFirstName.text = user?.firstName
        ibSecondName.text = user?.secondName
        ibPhone.text = user?.phone
        ibEmail.text = user?.email
        
        ibFirstName.delegate = self
        ibSecondName.delegate = self
        ibEmail.delegate = self
        ibPhone.delegate = self
        if let user = user {
            ibDelete.isHidden = false
        } else {
            ibDelete.isHidden = true
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    @IBAction private func userSaved(_ sender: Any) {
        //        guard var editedUser = user else { return }
        var editedUser: User
        if let user = user {
            editedUser = user
        } else {
            editedUser = User(firstName: "", secondName: "", email: "", phone: "")
            newRegistration = true
        }
       var message: String = ""
        
    
        
        let newFirstName = ibFirstName.text ?? ""
        if newFirstName.isEmpty {
            message += "First Name Please \n"
        }
        editedUser.firstName = newFirstName
        let newSecondName = ibSecondName.text ?? ""
        if newSecondName.isEmpty {
            message += "Second Name Please \n"
        }
        editedUser.secondName = newSecondName
        let newPhone = ibPhone.text ?? ""
        editedUser.phone = newPhone
        let newEmail = ibEmail.text ?? ""
        editedUser.email = newEmail
        
        if !message.isEmpty {
        let alert = UIAlertController(title: "Validation fileds",
                                      message: message,
                                      preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default) {
            (UIAlertAction: UIAlertAction) in
        }
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
        
        } else {
        newRegistration ? DataManager.instance.addUser(editedUser) : DataManager.instance.editUser(editedUser)
        
        navigationController?.popViewController(animated: true)
        }
    }
    @IBAction private func userDeleted(_ sender: Any) {
        guard let user = user else { return }
        DataManager.instance.deleteUser(user)
        navigationController?.popViewController(animated: true)
    }
    private func hideKeyboard() {
        view.endEditing(true)
    }
}

extension UserDetailsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hideKeyboard()
        return true
    }
}

extension UserDetailsViewController {
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        lcActionsBottomMargin.constant = keyboardFrame.size.height
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    @objc private func keyboardWillHide(_ notification: Notification) {
        lcActionsBottomMargin.constant = 0
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}
