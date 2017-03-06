//
//  AnimationViewController.swift
//  IntroAnimation
//
//  Created by Ethan Hess on 2/5/17.
//  Copyright © 2017 EthanHess. All rights reserved.
//

import UIKit

class AnimationViewController: UIViewController {
    
    @IBOutlet var planetButtonCollection: [PlanetButton]!
    @IBOutlet var labelCollection : [UILabel]!
    @IBOutlet weak var cancelButton: UIButton!
    
    var isPresenting: Bool = true
    var selectedCenter: CGPoint!
    var selectedPlanet: ((_ planetImage: UIImage)->Void)!
    var planetNumber: Int!
    
    var localPlanetArray : [Planet] = []
    
    class func newFromStoryboard()-> AnimationViewController {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        return sb.instantiateViewController(withIdentifier: "AMViewController") as! AnimationViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        modalPresentationStyle = UIModalPresentationStyle.custom
        transitioningDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getPlanetDataFromServer()
        
        customizeButtons()
        customizeLabels()
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func getPlanetDataFromServer() {
        
        NetworkController.sharedManager.getPlanets { (planetArray) in
            
            if (planetArray != nil) {
                
                self.localPlanetArray = planetArray!
                
                self.configureLabels()
            }
        }
    }

    
    func colorsArray() -> [UIColor] {
        
        return [UIColor.red, UIColor.blue, UIColor.black, UIColor.green, UIColor.purple, UIColor.yellow, UIColor.cyan, UIColor.darkGray, UIColor.brown]
    }
    
    func customizeButtons() {
            
        for i in 0 ..< planetButtonCollection.count {
                
            let button = planetButtonCollection[i]
            
            button.backgroundColor = colorsArray()[i] //images eventually
            
            button.addBackground(imageName: "Mercury")
        }
    }
    
    func customizeLabels() {
        
        for i in 0 ..< labelCollection.count {
            
            let label = labelCollection[i]
            
            label.textColor = colorsArray()[i]
        }
    }
    
    func configureLabels() {
        
        for i in 0..<localPlanetArray.count {
            
            let planet = localPlanetArray[i]
            let label = labelCollection[i]
            
            animateLabelWithPlanet(planet: planet, label: label, duration: Int16(label.tag))
        }
    }
    
    func animateLabelWithPlanet(planet: Planet, label: UILabel, duration: Int16) {
        
        print("DURATION \(duration)")
        
        UIView.animate(withDuration: TimeInterval(duration)) {
            
            DispatchQueue.main.async {
                
                label.text = planet.name!
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonTapped(_ sender: AnyObject) {
        
        for button in self.planetButtonCollection {
            let randomNum = Double(arc4random_uniform(4) + 1)
            UIView.animate(withDuration: randomNum * 0.1, animations: {
                button.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
            }, completion: nil)
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func planetButtonTapped(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "checkOutPlanet", sender: sender.tag)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "checkOutPlanet" {
            
            let navigationVC = segue.destination as! UINavigationController
            let theVC = navigationVC.topViewController as! TabBarController
            theVC.planet = self.localPlanetArray[sender as! Int]
            
        }
    }

}

extension AnimationViewController: UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
    
        if (isPresenting) {
            
            for button in self.planetButtonCollection {
                
                button.transform = CGAffineTransform(scaleX: 0, y: 0)
                let randomNum = Double(arc4random_uniform(200) + 100)
                
                UIView.animate(withDuration: 0.8, delay: (randomNum * 0.001), usingSpringWithDamping: 0.5, initialSpringVelocity: 0.9, options: UIViewAnimationOptions(), animations: {
                    button.transform = CGAffineTransform(scaleX: 1, y: 1)
                }, completion: nil)
            }
            
            containerView.addSubview(toViewController.view)
            toViewController.view.alpha = 0
            UIView.animate(withDuration: 0.4, animations: { () -> Void in
                toViewController.view.alpha = 1
                
            }, completion: { (finished: Bool) -> Void in
                transitionContext.completeTransition(true)
            })
            
        } else {
            UIView.animate(withDuration: 0.4, animations: { () -> Void in
                fromViewController.view.alpha = 0
            }, completion: { (finished: Bool) -> Void in
                transitionContext.completeTransition(true)
                fromViewController.view.removeFromSuperview()
            })
        }
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        
        return 0.5
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        isPresenting = false
        return self
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        isPresenting = true
        return self
    }
}
