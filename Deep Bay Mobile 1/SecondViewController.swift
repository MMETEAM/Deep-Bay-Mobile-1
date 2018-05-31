//
//  SecondViewController.swift
//  Deep Bay Mobile 1
//
//  Created by Michael Hammond-Todd on 2018-05-21.
//  Copyright © 2018 MMEDesignStudio. All rights reserved.
//  This ViewController plays the introductory video for the mobile learning activity.

import UIKit
import AVKit


class SecondViewController: UIViewController {
    
    @IBAction func buttonAction(_ sender: Any) {
    
        if let path = Bundle.main.path(forResource: "introduction", ofType: "mp4")
        {
            let introduction = AVPlayer(url: URL(fileURLWithPath: path))
            let introductionPlayer = AVPlayerViewController()
            introductionPlayer.player = introduction
            
            present(introductionPlayer, animated: true, completion: {
                introduction.play()
            })
            
        }// This function plays the introductory video. 
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


    

