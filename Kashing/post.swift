//
//  post.swift
//  Kashing
//
//  Created by Home on 1/6/16.
//  Copyright © 2016 DanielOng. All rights reserved.
//

import Foundation

class Post {
    
    private var _postdesc: String!
    private var _imageURL: String?
    private var _likes: Int!
    private var _username: String!
    private var _postKey: String!
    private var _price: Double!
    
    var postdesc: String {
        return _postdesc
    }
    
    var imageURL: String? {
        return _imageURL
    }
    
    var likes: Int {
        return _likes
    }
    
    var username: String {
        return _username
    }
    
    var postKey: String {
        return _postKey
    }
    
    var price: Double {
        return _price
    }
    
    init (desc: String, imageURL: String?, username: String, price: Double)
    {
        self._postdesc = desc
        self._imageURL = imageURL
        self._username = username
        self._price = price
    }
    
    init(postKey: String, dictionary: Dictionary<String, AnyObject>)
    {
        self._postKey = postKey
        
        //THESE NAMES HAVE TO BE THE EXACT SAME AS IN FIREBASE
        if let likes = dictionary["likes"] as? Int {
            self._likes = likes
        }
        
        if let imageURL = dictionary["imageURL"] as? String {
            self._imageURL = imageURL
        }
        
        if let desc = dictionary["desc"] as? String {
            self._postdesc = desc
        }
        
        if let price = dictionary["price"] as? Double {
            self._price = price
        }
    }
    
}