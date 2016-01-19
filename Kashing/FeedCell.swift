//
//  FeedCell.swift
//  Kashing
//
//  Created by Home on 1/6/16.
//  Copyright © 2016 DanielOng. All rights reserved.
//

import UIKit
import Alamofire

class FeedCell: UITableViewCell {
    
    @IBOutlet weak var profileImg: UIImageView!
    var post: Post!
    
    @IBOutlet weak var desc: UITextView!
    @IBOutlet weak var likesLbl: UILabel!
    @IBOutlet weak var itemImg: UIImageView!
    var request: Request?
    
    override func awakeFromNib() {
        
            super.awakeFromNib()
        }
    
    func configureCell(post: Post, img: UIImage?)
    {
        self.post = post
        self.desc.text = post.postdesc
        self.likesLbl.text = "\(post.likes)"
        
        if post.imageURL != nil {
            if img != nil {
                self.itemImg.image = img
            } else {
                request = Alamofire.request(.GET, post.imageURL!).validate(contentType: ["image/*"]).response(completionHandler: {request, response, data, err in
                    
                    if err == nil {
                        let img = UIImage(data:data!)!
                        self.itemImg.image = img
                        FeedVC.imageCache.setObject(img, forKey: self.post.imageURL!)
                    }
                    
                })
            }
        } else {
            self.itemImg.hidden = true
        }
    }
    

}
