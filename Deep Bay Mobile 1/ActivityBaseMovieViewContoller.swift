//
//  ActivityBaseMovieViewContoller.swift
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

//This is the base code for creating video recordings.

class ActivityBaseMovieViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var movieFileName: String { return "Activity1.mov"}
    
    @IBOutlet weak var cameraView: UIImageView!
    
    var imagePickerController : UIImagePickerController!
    var moviePlayer = AVPlayer()
    var moviePlayerViewController = AVPlayerViewController()
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set the movie if saved
//        getImage(imageName: movieFileName)
    }
    
    // MARK: Actions
    
    @IBAction func takeMovieButton(_ sender: Any) {
        // use this to record a movie
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            // NOTE: video also needs NSMicrophoneUsageDescription key in Info.plist
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = .camera
            imagePickerController.mediaTypes = [kUTTypeMovie as String]
            imagePickerController.videoMaximumDuration = 10 // or whatever you want
            imagePickerController.videoQuality = .typeMedium
            imagePickerController.allowsEditing = false
            present(imagePickerController, animated: true, completion: nil)
        }
    }
   
    
    // MARK: UIImagePickerControllerDelegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // display the movie
////
        // save the movie
        let mediaType = info[UIImagePickerControllerMediaType] as! String
        if mediaType == kUTTypeMovie as String, let movieURL = info[UIImagePickerControllerMediaURL] as? URL {
            print("VIDEO URL: \(movieURL)")
            DBFileManager.shared.saveMovie(movieURL, movieName: "Activity1.mov")
        }
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: Activity Functions

    func getMovie() {
        if let movie = DBFileManager.shared.retrieveMovie(movieName: "Activity1.mov") {
            playMovie(movie)
        }
    }
    
    func playMovie(_ movieUrl: URL) {
        // Create the view controller and player
        moviePlayerViewController = AVPlayerViewController()
        moviePlayer = AVPlayer(url: movieUrl)

        self.addChildViewController(moviePlayerViewController)////
        
        // Add your view Frame
        moviePlayerViewController.view.frame = cameraView.frame
        
        // Add sub view in your view
        cameraView.addSubview(moviePlayerViewController.view)
        
        moviePlayer.play()
        
//        // Initialize the AVPlayer
//        moviePlayerViewController.player = moviePlayer
//
//        // Present movie player and play when completion
//        self.present(moviePlayerViewController, animated: false, completion: {
//            moviePlayerViewController.player?.play()
//        })
    }
}


/*
import AVFoundation
import AVKit

var player = AVPlayer()
var playerController = AVPlayerViewController()

func playVideo() {
    let videoURL = NSURL(string: videoUrl)
    player = AVPlayer(url: videoURL! as URL)
    let playerController = AVPlayerViewController()
    playerController.player = player
    self.addChildViewController(playerController)
    
    // Add your view Frame
    playerController.view.frame = self.view.frame
    
    // Add sub view in your view
    self.view.addSubview(playerController.view)
    
    player.play()
}
 
 func stopVideo() {
 player.pause()
 }
 */
