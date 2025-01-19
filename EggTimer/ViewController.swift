//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var eggProgress: UIProgressView!
    
    var player: AVAudioPlayer?
    
    let eggTimes = [
        "Soft": 3,
        "Medium": 5,
        "Hard": 7
    ]
    var totalTime: Int = 0
    var secondsElapsed: Int = 0
    var timer: Timer?

    @IBAction func onEggPressed(_ sender: UIButton) {
        let hardness = sender.currentTitle!
        
        secondsElapsed = 0
        eggProgress.progress = 0
        mainLabel.text = hardness
        timer?.invalidate()
        totalTime = eggTimes[hardness]!
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(countdown), userInfo: nil, repeats: true)
    }
    
    @objc
    func countdown() {
        if (secondsElapsed < totalTime) {
            let percentProgress = Float(secondsElapsed) / Float(totalTime)
            eggProgress.progress = percentProgress
            secondsElapsed += 1
        } else {
            playSound()
            eggProgress.progress = 1
            mainLabel.text = "Done"
            timer?.invalidate()
        }
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player!.play()
    }
    
}
