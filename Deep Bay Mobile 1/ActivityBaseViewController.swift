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
    
    var imageFileName: String { return "Activity1.png" }
    var movieFileName: String { return "Activity1.mov"}
    
    @IBOutlet weak var output1: UILabel!
    @IBOutlet weak var input1: UITextField!
    @IBOutlet weak var cameraView: UIImageView!
    
    var imagePickerController : UIImagePickerController!
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // set the text if saved
        if let x = UserDefaults.standard.object(forKey: "myAnswer") as? String
        {
            output1.text = x;
        }
        
        // set the image if saved
        getImage(imageName: "Activity1.png")
    }
    
    // MARK: Actions
    
    @IBAction func takePhotoButton(_ sender: Any) {
        //        // use this to record a movie
        //        if UIImagePickerController.isSourceTypeAvailable(.camera) {
        //            // NOTE: video also needs NSMicrophoneUsageDescription key in Info.plist
        //            let imagePickerController = UIImagePickerController()
        //            imagePickerController.delegate = self
        //            imagePickerController.sourceType = .camera
        //            imagePickerController.mediaTypes = [kUTTypeMovie as String]
        //            imagePickerController.videoMaximumDuration = 10 // or whatever you want
        //            imagePickerController.videoQuality = .typeMedium
        //            imagePickerController.allowsEditing = false
        //            present(imagePickerController, animated: true, completion: nil)
        //        }
        
        // use this to take a picture
        imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .camera
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func saveActivity1(_ sender: Any) {
        // save the text
        output1.text = input1.text
        UserDefaults.standard.set(input1.text, forKey: "myAnswer")
        input1.text = "";
        
        // save the image
        DBFileManager.shared.saveImage(cameraView.image!, imageName: "Activity1.png")
    }
    
    // MARK: UIImagePickerControllerDelegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // if just taking picture
        cameraView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        dismiss(animated: true, completion: nil)
        
        //        // can be used for movie or picture
        //        let mediaType = info[UIImagePickerControllerMediaType] as! String
        //        if mediaType == kUTTypeMovie as String, let movieURL = info[UIImagePickerControllerMediaURL] as? URL {
        //            print("VIDEO URL: \(movieURL)")
        //            DBFileManager.shared.saveMovie(movieURL, movieName: "Activity1.mov")
        //        } else {
        //            cameraView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        //        }
        //        dismiss(animated: true, completion: nil)
    }
    
    // MARK: Activity Functions
    
    func getImage(imageName: String) {
        if let image = DBFileManager.shared.retrieveImage(imageName: imageName) {
            cameraView.image = image
        } else {
            print("Panic! No Image!")
        }
    }
    
    func getMovie() {
        if let movie = DBFileManager.shared.retrieveMovie(movieName: "Activity1.mov") {
            playMovie(movie)
        }
    }

    func playMovie(_ movieUrl: URL) {
        // Create the view controller and player
        let moviePlayerViewController = AVPlayerViewController()
        let moviePlayer = AVPlayer(url: movieUrl)

        // Initialize the AVPlayer
        moviePlayerViewController.player = moviePlayer

        // Present movie player and play when completion
        self.present(moviePlayerViewController, animated: false, completion: {
            moviePlayerViewController.player?.play()
        })
    }
}


