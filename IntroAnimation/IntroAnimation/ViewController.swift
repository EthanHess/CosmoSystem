//
//  ViewController.swift
//  IntroAnimation
//
//  Created by Ethan Hess on 2/5/17.
//  Copyright © 2017 EthanHess. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //var spaceImageNames = ["","","",""]
    
    var spaceImageNames = [UIColor.blue, UIColor.black, UIColor.brown, UIColor.darkGray]
    
    var timer = Timer()
    
    var currentImageIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.animateBackground), userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func animateBackground() {
        
        currentImageIndex += 1
        
        if currentImageIndex < spaceImageNames.count {
            
            UIView.animate(withDuration: 1, animations: { 
                
                self.view.backgroundColor = self.spaceImageNames[self.currentImageIndex]
            })
        }
        
        else {
            
            currentImageIndex = 0
            
            UIView.animate(withDuration: 1, animations: {
            
                self.view.backgroundColor = self.spaceImageNames[self.currentImageIndex]
            })
        }
        
        
    }
    
    @IBAction func imageViewTapped(_ sender: Any) {
        
        let planetPicker = AnimationViewController.newFromStoryboard()
        planetPicker.isPresenting = true
        planetPicker.selectedCenter = (sender as AnyObject).center
        
        self.present(planetPicker, animated: true, completion: nil)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        timer.invalidate()
    }
}

