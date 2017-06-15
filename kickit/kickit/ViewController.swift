//
//  ViewController.swift
//  kickit
//
//  Created by Myle$ on 6/14/17.
//  Copyright © 2017 Myle$. All rights reserved.
//

import UIKit
import GameKit

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
    
    

}

