//
//  ViewController.swift
//  kickit
//
//  Created by Myle$ on 6/14/17.
//  Copyright © 2017 Myle$. All rights reserved.
//

import UIKit
import GameKit
import Social

class ViewController: UIViewController {
    


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        HighScoreManager().authenticateLocalPlayer(view: self.view)
        HighScoreManager().loadAcheivementPercentages()
    }


    @IBAction func highscoreButton(_ sender: Any) {
        
        HighScoreManager().declareGameCenterController()
        let vc: UIViewController = self.view!.window!.rootViewController!
        vc.present(HighScoreManager().gameCenterViewController, animated: true, completion: nil)
    }
    
    
    @IBAction func shareToTwitter(_ sender: Any) {
        
        if let vc = SLComposeViewController(forServiceType:SLServiceTypeTwitter){
        //vc.add(imageView.image!)
        vc.add(URL(string: "http://www.example.com/"))
        vc.setInitialText("I'm playing my new favorite game, Kickit. Bet you can't beat my score!")
        self.present(vc, animated: true, completion: nil)
        
        }
    }
    
    @IBAction func shareToFacebook(_ sender: Any) {
        
        if let vc = SLComposeViewController(forServiceType:SLServiceTypeFacebook){
        //vc.add(imageView.image!)
        vc.add(URL(string: "http://www.example.com/"))
        vc.setInitialText("I'm playing my new favorite game, Kickit. Bet you can't beat my score!")
        self.present(vc, animated: true, completion: nil)
        }
        
    }
}

