//
//  DataService.swift
//  Kashing
//
//  Created by Home on 1/5/16.
//  Copyright © 2016 DanielOng. All rights reserved.
//

import Foundation
import Firebase

class DataService {
    static let ds = DataService()
    private var _URL = Firebase(url: "https://Kashing.firebaseio.com")
    private var _REF_POSTS = Firebase(url: "https://Kashing.firebaseio.com/posts")
    private var _REF_USERS = Firebase(url: "https://Kashing.firebaseio.com/users")
    
    var URL: Firebase {
        return _URL
    }
    
    var REF_POSTS: Firebase {
        return _REF_POSTS
    }
    
    var REF_USERS: Firebase {
        return _REF_USERS
    }
    
    func createUser(uid: String, user: Dictionary<String, String>) {
        REF_USERS.childByAppendingPath(uid).setValue(user)
    }
    
}