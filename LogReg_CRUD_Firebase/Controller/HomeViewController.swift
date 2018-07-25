//
//  HomeViewController.swift
//  LogReg_CRUD_Firebase
//
//  Created by Xona on 5/18/18.
//  Copyright © 2018 Xona. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var activityView:UIActivityIndicatorView!
   var ref: DatabaseReference?
   var databaseHandle: DatabaseHandle?
     
    var postData = [Post]()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        activityView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityView.color = UIColor(red: 255/255, green: 148/255, blue: 230/255, alpha: 1)
        activityView.frame = CGRect(x: 0, y: 0, width: 50.0, height: 50.0)
        view.addSubview(activityView)
        activityView.startAnimating()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = 300
        
        /*
         TODO: Use SwiftJSON to manage the data we get below;
         put the necessary code in the Modelß
         */
        
        
        ref = Database.database().reference()
        
        //Get the data from the database
        databaseHandle = ref?.child("Posts").observe(DataEventType.value, with: { (snapshot) in
            self.postData.removeAll()
            for post in (snapshot.children.allObjects as? [DataSnapshot])! {
                let postObject = post.value as? [String: AnyObject]
                let postTitle = postObject?["title"] as! String
                let postUrl = postObject?["imageDownloadURL"]

                let url = URL(string: postUrl! as! String)
                let data = try? Data(contentsOf: url!)
                
                let postImg: UIImage = UIImage(data: data!)!
                let actualPost = Post(image: postImg, title: postTitle)
                self.postData.append(actualPost)
            }
            self.tableView.reloadData()
        })
    }

    //Manage the rows of the table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postData.count
    }
    //Manage the rows of the table
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostTableViewCell
        //Display the post content in the cell
        cell.postTitle.text = postData[indexPath.row].title
        cell.postImg.image = postData[indexPath.row].image
        return cell
    }
    
    //Log out the current user
    @IBAction func handleLogOut(_ sender: UIBarButtonItem) {
        try! Auth.auth().signOut()
        self.dismiss(animated: true, completion: nil)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
