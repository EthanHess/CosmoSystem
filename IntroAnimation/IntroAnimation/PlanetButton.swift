//
//  PlanetButton.swift
//  IntroAnimation
//
//  Created by Ethan Hess on 2/26/17.
//  Copyright © 2017 EthanHess. All rights reserved.
//

import UIKit

class PlanetButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.frame.size.width / 2
    }
    
    func addBackground(imageName : String) {
        
        self.setBackgroundImage(UIImage(named: imageName), for: .normal)
    }

}
