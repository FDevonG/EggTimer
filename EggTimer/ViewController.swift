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
        
    @IBOutlet weak var eggTextDisplay: UILabel!
    @IBOutlet weak var timerProgress: UIProgressView!
    
    let eggTimes = ["Soft": 10, "Medium": 420, "Hard": 720]
    var eggTime: Int = 0
    var hardness: String? = nil
    
    var audioPlayer: AVAudioPlayer?
    var eggTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timerProgress.progress = 1.0
    }
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        //stop the current timer
        eggTimer?.invalidate()
        
        //reset the progress view to 1
        timerProgress.progress = 1.0
        
        //here we get the title of the button we pressed and retrive the new hardness level of the egg
        hardness = sender.currentTitle!
        eggTime = eggTimes[hardness!]!
        
        eggTextDisplay.text = "\(eggTime) seconds to the end of the egg!"
        
        //start the new timer
        eggTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        //if the eggtime is above 0 then the timer is not complete
        if eggTime > 0 {
            print("\(eggTime) seconds to the end of the egg!")
            eggTime -= 1//countdown the timer by one
            eggTextDisplay.text = "\(eggTime) seconds to the end of the egg!"//update the text with the new time
            timerProgress.progress = Float(eggTime)/Float(eggTimes[hardness!]!) // update the progress view
        } else { //the timer has completeed
            eggTimer?.invalidate()// we invalidate the timer
            eggTextDisplay.text = "Done!"//update the text
            timerProgress.progress = 0//update the progress view
            playSound(soundToPLay: "alarm_sound", fileExtension: "mp3")//sound the alarm
        }
    }
    
    func playSound(soundToPLay: String, fileExtension: String) {
        if let url = Bundle.main.url(forResource: soundToPLay, withExtension: fileExtension){
            do {
                audioPlayer = try! AVAudioPlayer(contentsOf: url)
                audioPlayer?.play()
            }
        } else {
            print("error playing audio")
        }
    }
}
