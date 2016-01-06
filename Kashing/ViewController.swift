//
//  ViewController.swift
//  Kashing
//
//  Created by Home on 1/3/16.
//  Copyright © 2016 DanielOng. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // func that logs u in if u already logged in before
    override func viewDidAppear(animated: Bool) {
        if NSUserDefaults.standardUserDefaults().valueForKey(KEY_TOKEN) != nil {
            self.performSegueWithIdentifier("loggedIn", sender: nil)
        }
    }
    
    @IBAction func FBLogin(sender: UIButton!) {
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logInWithReadPermissions(["email"]) { (Result: FBSDKLoginManagerLoginResult!, facebookError: NSError!) -> Void in
            
            if facebookError != nil {
            print ("Facebook login failed. Error \(facebookError)")
            } else {
                let accessToken = FBSDKAccessToken.currentAccessToken().tokenString
                print("Successfully logged in \(accessToken)")
                
                DataService.ds.URL.authWithOAuthProvider("facebook", token: accessToken, withCompletionBlock: { error, authData in
                    
                    if error != nil {
                        print("Login failed. \(error)")
                    }
                    else
                    {
                        print("Logged In!\(authData)")
                        
                        let user = ["provider": authData.provider!, "blah":"test"]
                        DataService.ds.createUser(authData.uid, user: user)
                        NSUserDefaults.standardUserDefaults().setValue(authData.uid, forKey: KEY_TOKEN)
                        self.performSegueWithIdentifier("loggedIn", sender: nil)
                    }
                    
                })
            }
        }
    }


}

