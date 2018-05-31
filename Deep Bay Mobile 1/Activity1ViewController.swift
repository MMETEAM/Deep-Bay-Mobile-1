//
//  Activity1ViewController.swift
//  Deep Bay Mobile 1
//
//  Created by Michael Hammond-Todd on 2018-05-22.
//  Copyright © 2018 MMEDesignStudio. All rights reserved.
//  This is the ViewController for the first activity.

import Foundation
import UIKit

class Activity1ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    
    @IBOutlet weak var output1: UILabel!
    
    
    @IBOutlet weak var input1: UITextField!
    
    
    @IBOutlet weak var cameraView: UIImageView!
    
     var imagePickerController : UIImagePickerController!
    
    
    @IBAction func takePhotoButton(_ sender: Any) {
        imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .camera
        present(imagePickerController, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        imagePickerController.dismiss(animated: true, completion: nil)
        cameraView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
    }
    func saveImage(imageName: String){
        //create an instance of the FileManager
        _ = FileManager.default
        //get the image path
        _ = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(imageName)
        //get the image we took with camera
        let image = cameraView.image!
        //get the PNG data for this image
        _ = UIImagePNGRepresentation(image)
        //store it in the document directory    fileManager.createFile(atPath: imagePath as String, contents: data, attributes: nil)
    }
    
    @IBAction func saveActivity1(_ sender: Any) {
        output1.text = input1.text
        UserDefaults.standard.set(input1.text, forKey: "myAnswer")
        input1.text = "";
        do {
            saveImage(imageName: "Activity1.png")
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the    view.getImage(imageName: "Activity1.png")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        if let x = UserDefaults.standard.object(forKey: "myAnswer") as? String
        {
            output1.text = x;
            
        }
        func getImage(imageName: String){
            
            let fileManager = FileManager.default
            let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(imageName)
            if fileManager.fileExists(atPath: imagePath){
                cameraView.image = UIImage(contentsOfFile: imagePath)
            }else{
                print("Panic! No Image!")
            }
            
        }
        
    }
    
}

