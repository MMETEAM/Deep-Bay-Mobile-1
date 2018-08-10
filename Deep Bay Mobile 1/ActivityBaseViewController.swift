//
//  ActivityBaseViewController.swift
//  Deep Bay Mobile 1
//
//  Created by Michael Hammond-Todd on 2018-08-10.
//  Copyright © 2018 MMEDesignStudio. All rights reserved.
//


import AVKit
import AVFoundation
import MobileCoreServices
import Foundation
import UIKit


// all the movie related code is commented out
class ActivityBaseViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var textKey: String { return "myAnswer"}
    var imageFileName: String { return "Activity1.png" }
    
    @IBOutlet weak var output1: UILabel!
    @IBOutlet weak var input1: UITextField!
    @IBOutlet weak var cameraView: UIImageView!
    
    var imagePickerController : UIImagePickerController!
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // set the text if saved
        if let x = UserDefaults.standard.object(forKey: textKey) as? String
        {
            output1.text = x;
        }
        
        // set the image if saved
        getImage(imageName: imageFileName)
    }
    
    // MARK: Actions
    
    @IBAction func takePhotoButton(_ sender: Any) {
        
        // use this to take a picture
        imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .camera
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func enteredText(_ sender: Any) {
        // save the text
        UserDefaults.standard.set(input1.text, forKey: textKey)
    }
    
    // MARK: UIImagePickerControllerDelegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // save the image and display
        cameraView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        DBFileManager.shared.saveImage(cameraView.image!, imageName: imageFileName)
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: Activity Functions
    
    func getImage(imageName: String) {
        if let image = DBFileManager.shared.retrieveImage(imageName: imageName) {
            cameraView.image = image
        } else {
            print("Panic! No Image!")
        }
    }
}



