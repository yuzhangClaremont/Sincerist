//
//  ViewController.swift
//  HellowWorld
//
//  Created by Yun Zhang on 8/15/19.
//  Copyright © 2019 Yun Zhang. All rights reserved.
//

import UIKit
import AVKit
//import FirebaseUI
//import FacebookLogin

var videoPlayer: AVPlayer?
var videoPlayLayer: AVPlayerLayer?

class ViewController: UIViewController {

    @IBOutlet weak var newAccountButton: UIButton!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        let loginButton = LoginButton(readPermissions: [ .publicProfile ])
//        loginButton.center = view.center
//        
//        view.addSubview(loginButton)
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        setUpVideo()
    }
    
    func setUpVideo()
    {
        // GET PATH TO THE RESOURCE IN THE BUNDLE
        let bundlePath = Bundle.main.path(forResource: "fatherSon", ofType: "mp4")
        guard bundlePath != nil else{
            return
        }
        // CREATE A URL FROM IT
        let url = URL(fileURLWithPath: bundlePath!)
        
        // create the video player item
        let item = AVPlayerItem(url: url)
        // create the player
        videoPlayer = AVPlayer(playerItem: item)
        // create the layer
        videoPlayLayer = AVPlayerLayer(player: videoPlayer)
        
        // adjust size and frame
        videoPlayLayer?.frame = CGRect(x: -self.view.frame.size.width*1.5, y: 0, width: self.view.frame.size.width*4, height: self.view.frame.size.height)
        view.layer.insertSublayer(videoPlayLayer!, at: 0)
        // add to the view and play it
        videoPlayer?.volume = 0
        videoPlayer?.playImmediately(atRate: 0.6)
    }



}

