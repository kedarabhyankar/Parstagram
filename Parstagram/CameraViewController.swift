//
//  CameraViewController.swift
//  Parstagram
//
//  Created by Kedar Abhyankar on 4/16/20.
//  Copyright © 2020 Kedar Abhyankar. All rights reserved.
//

import UIKit
import AlamofireImage
import Parse

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate,
UITextFieldDelegate{
    
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var commentInput: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.commentInput.delegate = self
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func onCommentSubmit(_ sender: Any) {
        let post = PFObject(className: "Posts")
        
        post["caption"] = commentInput.text!
        post["author"] = PFUser.current()!
        
        let imageData = imageView.image!.pngData()
        let firstPartFileName = randomString(length: 20)
        let fullFileName = firstPartFileName + ".png"
        print(fullFileName)
        let file = PFFileObject(name: fullFileName, data: imageData!)
        
        post["image"] = file
        
        post.saveInBackground {
            (success, error) in
            if success {
                self.dismiss(animated: true, completion: nil)
                print("saved")
            } else {
                print("failed")
            }
        }
    }
    
    @IBAction func onCameraButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if(UIImagePickerController.isSourceTypeAvailable)(.camera){
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker:
        UIImagePickerController, didFinishPickingMediaWithInfo info:
        [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af.imageAspectScaled(toFit: size)
        imageView.image = scaledImage
        dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyz0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
}
