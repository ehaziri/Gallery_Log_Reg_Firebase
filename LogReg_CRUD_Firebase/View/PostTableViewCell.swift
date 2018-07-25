//
//  PostTableViewCell.swift
//  LogReg_CRUD_Firebase
//
//  Created by Xona on 5/18/18.
//  Copyright © 2018 Xona. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var postTitle: UILabel!
    
    var post: Post?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
