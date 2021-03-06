//
//  ViewController.swift
//  FirstNewApp
//
//  Created by Eunsoo KIM on 2022/04/12.
//

import UIKit
import AVFoundation

final class TimerViewController: UIViewController {
    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var timerButton: UIButton!
    
    weak var timer: Timer?
    var timeRemaining = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSlider()
        initialezeUI()
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        timeRemaining = Int(sender.value)
        mainLabel.text = "\(timeRemaining) 초"
    }
    
    @IBAction func timerButtonTapped(_ sender: UIButton) {
        guard checkUserInput() else {
            alertWarning()
            return
        }
        
        guard let buttonTitle = sender.currentTitle else {
            return
        }
        if buttonTitle == K.ButtonTitle.start ||
            buttonTitle == K.ButtonTitle.restart {
            intializeTimer()
        } else {
            stopTimer()
        }
        
        toggleTimerButtonTitle(buttonTitle: buttonTitle)
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        initialezeUI()
    }
    
    private func configureSlider() {
        slider.minimumValue = 0.0
        slider.maximumValue = 60.0
    }
    
    private func initialezeUI() {
        stopTimer()
        mainLabel.text = "초를 선택하세요"
        timerButton.setTitle(K.ButtonTitle.start, for: .normal)
        slider.setValue(30.0, animated: true)
        timeRemaining = 0
    }
    
    private func toggleTimerButtonTitle(buttonTitle: String) {
        if buttonTitle == K.ButtonTitle.start ||
            buttonTitle == K.ButtonTitle.restart {
            timerButton.setTitle(K.ButtonTitle.pause, for: .normal)
        } else {
            timerButton.setTitle(K.ButtonTitle.restart, for: .normal)
        }
    }
    
    private func intializeTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { [self] _ in
            startTimer()
        })
    }
    
    private func startTimer() {
        if timeRemaining > 0 {
            timeRemaining -= 1
            slider.value = Float(timeRemaining)
            mainLabel.text = "\(timeRemaining) 초"
        } else {
            timer?.invalidate()
            timeRemaining = 0
            AudioServicesPlayAlertSound(1322)
            initialezeUI()
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func checkUserInput() -> Bool {
        timeRemaining == 0 ? false : true
    }
    
    private func alertWarning() {
        let alert = UIAlertController(title: "경고", message: "초를 선택해주세요", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }
}
