//
//  ViewController.swift
//  Simulasi
//
//  Created by Stefani Kurnia Permata Dewi on 13/10/19.
//  Copyright © 2019 Stefani Kurnia Permata Dewi. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController{

    @IBOutlet weak var trackTitle: UILabel!
    @IBOutlet weak var singerName: UILabel!
    @IBOutlet weak var playedTime: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    var audioPlayer:AVAudioPlayer?
    var isPlaying = false
    var timer:Timer!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        trackTitle.text = "Laskar Pelangi"
        singerName.text = "Nidji"
        audioPlayer = initializePlayer()
    }
    
    private func initializePlayer() -> AVAudioPlayer?
    {
        guard let path = Bundle.main.path(forResource: "Laskar Pelangi", ofType: "mp3")
        else {
            return nil
        }

        return try? AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
    }

    
    @IBAction func playButton(_ sender: Any)
    {
        if isPlaying
            {
                audioPlayer?.pause()
                isPlaying = false
            } else
            {
                audioPlayer?.play()
                isPlaying = true
                timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime),
                userInfo: nil, repeats: true)
                
                progressView.setProgress(Float (audioPlayer!.currentTime/audioPlayer!.duration), animated: true)
        }
    }
    
    @objc func updateTime()
    {
        let currentTime = Int(audioPlayer!.currentTime)
        let minutes = currentTime/60
        let seconds = currentTime - minutes * 60
        playedTime.text = String(format: "%02d:%02d", minutes,seconds) as String
        
        progressView.setProgress(Float (audioPlayer!.currentTime/audioPlayer!.duration), animated: false)
    }
    

    @IBAction func stopButton(_ sender: Any)
    {
        audioPlayer?.stop()
        audioPlayer?.currentTime = 0
        isPlaying = false
           
    }
    
}

