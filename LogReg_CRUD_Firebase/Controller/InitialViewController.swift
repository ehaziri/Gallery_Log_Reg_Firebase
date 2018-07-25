//
//  ViewController.swift
//  LogReg_CRUD_Firebase
//
//  Created by Xona on 5/18/18.
//  Copyright © 2018 Xona. All rights reserved.
//

import UIKit
import FirebaseAuth

class InitialViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Current user logged in
        if let user = Auth.auth().currentUser{
            print("Current user: \(String(describing: user.displayName!))")
            
            self.performSegue(withIdentifier: "toMainScreen", sender: self)
        }
    }
    
    @IBAction func unwindSegue(_ sender: UIStoryboardSegue){
        print("Unwind...")
    }

}

