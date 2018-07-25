//
//  RegisterViewController.swift
//  LogReg_CRUD_Firebase
//
//  Created by Xona on 5/18/18.
//  Copyright © 2018 Xona. All rights reserved.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var usernameInput: UITextField!
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var continueBtn: UIButton!
    
    override func viewDidLoad() {
        usernameInput.delegate = self
        emailInput.delegate = self
        passwordInput.delegate = self
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
//    @IBAction func handleDismissBtn(_ sender: Any) {
//        self.dismiss(animated: true, completion: nil)
//    }
    

    @IBAction func handleContinueBtn(_ sender: UIButton) {
        guard let email = emailInput.text else { return }
        guard let password = passwordInput.text else { return }
        guard let username = usernameInput.text, username != "" else {
            alertBox(errorMessage: "No name to submit")
            return
        }
        
        /*
         TODO:
                Data validation using Regex
        */
    
        //Check whether the any of the inputs of the user is nil
        Auth.auth().createUser(withEmail: email, password: password){ user, error in
            if error == nil && user != nil {
                print("User created here!")
                
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = username
                changeRequest?.commitChanges { error in
                    if error == nil{
                        print("User display name changed!")
                        self.dismiss(animated: false, completion: nil)
                    }
                }
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
        if textField == usernameInput{
            emailInput.becomeFirstResponder()
        }
        else if textField == emailInput{
            passwordInput.becomeFirstResponder()
        }
        else if textField == passwordInput{
            textField.resignFirstResponder()
        }
        return true
    }

}
