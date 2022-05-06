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
    
    weak var timer: Timer?
    var number = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSlider()
        configureUI()
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        number = Int(sender.value)
        mainLabel.text = "\(number) 초"
    }
    @IBAction func startButtonTapped(_ sender: UIButton) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { [self] _ in
            if number > 0 {
                number -= 1
                slider.value = Float(number)
                mainLabel.text = "\(number) 초"
            } else {
                timer?.invalidate()
                number = 0
                AudioServicesPlayAlertSound(1322)
                configureUI()
            }
        })
    }
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        configureUI()
    }
    
    private func configureSlider() {
        slider.minimumValue = 0.0
        slider.maximumValue = 60.0
    }
    
    private func configureUI() {
        mainLabel.text = "초를 선택하세요"
        slider.setValue(30.0, animated: true)
        number = 0
        timer = nil
    }
}
