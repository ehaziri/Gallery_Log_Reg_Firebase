//
//  ComposeViewController.swift
//  LogReg_CRUD_Firebase
//
//  Created by Xona on 5/18/18.
//  Copyright © 2018 Xona. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ComposeViewController: UIViewController {

    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var postInput: UITextView!
    var takenImage: UIImage!
    var imagePicker: UIImagePickerController!
    var didShowCamera = false
    
    var ref: DatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.postImg.image = takenImage
    }
    
    @IBAction func cancelPost(_ sender: Any) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }

    @IBAction func uploadPressed(_ sender: Any) {
        if !didShowCamera {
            imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            
            //if there is a camera
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePicker.sourceType = .camera
                imagePicker.cameraCaptureMode = .photo
                //if there is no camera
            } else {
                imagePicker.sourceType = .photoLibrary
            }
            
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    @IBAction func savePost(_ sender: UIBarButtonItem) {
        //check for the presence of image and its title
        if postInput.text != "" && takenImage != nil {
            let newPost = Post(image: self.takenImage, title: self.postInput.text)
            newPost.save()
            self.dismiss(animated: true, completion: nil)
        }
        else{
            print("Please fill in the title and select the image")
        }
        
    }
}

//Manage the imagePicker
extension ComposeViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.takenImage = image
        didShowCamera = true
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}
