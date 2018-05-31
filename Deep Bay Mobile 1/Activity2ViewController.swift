//
//  Activity2ViewController.swift
//  Deep Bay Mobile 1
//
//  Created by Michael Hammond-Todd on 2018-05-31.
//  Copyright © 2018 MMEDesignStudio. All rights reserved.
//  This is for the second mobile learning activity at Deep Bay.

import UIKit

class Activity2ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate  {
    
    
    @IBOutlet weak var output2: UILabel!
    
    
    @IBOutlet weak var input2: UITextField!
    
    
    @IBOutlet weak var cameraView2: UIImageView!
    
     var imagePickerController : UIImagePickerController!
    
    
    @IBAction func takePhotoButton2(_ sender: Any) {
        
        imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .camera
        present(imagePickerController, animated: true, completion: nil)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        imagePickerController.dismiss(animated: true, completion: nil)
        cameraView2.image = info[UIImagePickerControllerOriginalImage] as? UIImage
    }
    func saveImage(imageName: String){
        //create an instance of the FileManager
        _ = FileManager.default
        //get the image path
        _ = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(imageName)
        //get the image we took with camera
        let image = cameraView2.image!
        //get the PNG data for this image
        _ = UIImagePNGRepresentation(image)
        //store it in the document directory    fileManager.createFile(atPath: imagePath as String, contents: data, attributes: nil)
    }
    
    @IBAction func saveActivity2(_ sender: Any) {
        output2.text = input2.text
        UserDefaults.standard.set(input2.text, forKey: "myAnswer")
        input2.text = "";
        do {
            saveImage(imageName: "Activity2.png")
            
        }
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the    view.getImage(imageName: "Activity2.png")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool)
    {
        if let x = UserDefaults.standard.object(forKey: "myAnswer") as? String
        {
            output2.text = x;
            
        }
        func getImage(imageName: String){
            
            let fileManager = FileManager.default
            let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(imageName)
            if fileManager.fileExists(atPath: imagePath){
                cameraView2.image = UIImage(contentsOfFile: imagePath)
            }else{
                print("Panic! No Image!")
            }
            
        }
        
    }
    
}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


