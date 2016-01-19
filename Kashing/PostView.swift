//
//  PostView.swift
//  Kashing
//
//  Created by Home on 1/6/16.
//  Copyright © 2016 DanielOng. All rights reserved.
//

import UIKit
import Firebase
import Alamofire

class PostView: UIViewController, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var imagePicker: UIImagePickerController!
    
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var descField: UITextField!
    
    @IBOutlet weak var postImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        postImage.image = image
    }

    @IBAction func selectImage(sender: UITapGestureRecognizer) {
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func makePost(sender: AnyObject) {
        if let txt = priceField.text where txt != "" {
            if let text2 = descField.text where text2 != "" {
                if let img = postImage.image {
                    let urlStr = "https://post.imageshack.us/upload_api.php"
                    let url = NSURL(string: urlStr)!
                    let imgData = UIImageJPEGRepresentation(img, 0.3)!
                    let keyData = " 9DILSVWX88e905818c9eed489e2629ba037fa2d6".dataUsingEncoding(NSUTF8StringEncoding)
                    let keyJSON = "json".dataUsingEncoding(NSUTF8StringEncoding)
                    
                    Alamofire.upload(.POST, url, multipartFormData: { multipartFormData in
                        
                        multipartFormData.appendBodyPart(data: imgData, name: "fileupload", fileName:"image", mimeType: "image/jpg")
                        multipartFormData.appendBodyPart(data: keyData!, name: "key")
                        multipartFormData.appendBodyPart(data: keyJSON!, name: "format")
                        
                        
                        }) { encodingResult in
                            
                            switch encodingResult {
                                case .Success(let upload, _, _):
                                    upload.responseJSON(completionHandler: {response in
                                        if let info = response.result.value as? Dictionary<String, AnyObject>{
                                            if let links = info["links"] as? Dictionary<String, AnyObject> {
                                                if let imgLink = links["image_link"] as? String {
                                                    print("\(imgLink)")
                                                }
                                            }
                                        }
                                })
                            case .Failure(let error):
                                print(error)
                            }
                        /*
                            switch encodingResult {
                            case .Success(let upload, _, _):
                                upload.responseJSON(completionHandler: {request, response, result in
                                    if let info = result.value as? Dictionary<String, AnyObject> {
                                        if let links = info["links"] as? Dictionary<STring, AnyObject> {
                                            if let imgLink = links["image_link"] as? String {
                                                print("\(imgLink)");
                                            }
                                        }
                                    }
                                })
                                
                            case .Failure(let error):
                                print(error)
                            }
                    */
                    }
                dismissViewControllerAnimated(true, completion: nil)
            }
        }
    }
}
}