//
//  LoginViewController.swift
//  LogReg_CRUD_Firebase
//
//  Created by Xona on 5/18/18.
//  Copyright © 2018 Xona. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var continueBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailInput.delegate = self
        passwordInput.delegate = self
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    @IBAction func handleContinueBtn(_ sender: UIButton) {
        guard let email = emailInput.text else { return }
        guard let password = passwordInput.text else { return }
        
        /*
         TODO:
         Data validation using Regex
         */
         Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let u = user{
                print("User: \(u.email!)")
                self.dismiss(animated: false, completion: nil)
            }
            else{
                self.alertBox(errorMessage: error!.localizedDescription)
            }
        }
    }
    
    func alertBox(errorMessage: String){
        let alert = UIAlertController(title: "Something wrong!", message: errorMessage, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    //Dismiss KEYBOARD when the user touches anywhere
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    //When user tapps RETURN button on keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailInput{
            passwordInput.becomeFirstResponder()
        }else if textField == passwordInput{
            textField.resignFirstResponder()
        }
        return true
    }
}
