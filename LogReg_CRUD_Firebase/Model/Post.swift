//
//  Post.swift
//  LogReg_CRUD_Firebase
//
//  Created by Xona on 5/16/18.
//  Copyright © 2018 Xona. All rights reserved.
//

import Firebase
import UIKit
import SwiftyJSON

class Post {
    
    var title: String!
    var image: UIImage!
    var downloadURL: String?
    
    init(image: UIImage, title: String) {
        self.image = image
        self.title = title
    }
    
   //save the data to the storage
    func save() {
        let newPostRef = Database.database().reference().child("Posts").childByAutoId()
        let newPostKey = newPostRef.key
        
        // 1. save image
        if let imageData = UIImageJPEGRepresentation(image, 0.5) {
            let storage = Storage.storage().reference().child("images/\(newPostKey)")
            
            storage.putData(imageData).observe(.success, handler: { (snapshot) in
                self.downloadURL = snapshot.metadata?.downloadURL()?.absoluteString
                let postDictionary = [
                    "imageDownloadURL" : self.downloadURL,
                    "title" : self.title
                ]
                newPostRef.setValue(postDictionary)
            })
        }
    }
}
