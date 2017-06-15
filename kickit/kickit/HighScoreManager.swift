//
//  HighScoreManager.swift
//  kickit
//
//  Created by Myle$ on 6/15/17.
//  Copyright © 2017 Myle$. All rights reserved.
//

import Foundation
import GameKit


class HighScoreManager: NSObject, GKGameCenterControllerDelegate{
    
    let gameCenterViewController = GKGameCenterViewController()

    
    override init() {
        
    }

    
    
    var gameCenterAchievements  = [String: GKAchievement]()

    
    func declareGameCenterController() {
        self.gameCenterViewController.gameCenterDelegate = self
    }
    
    func authenticateLocalPlayer(view: UIView){
        let localPlayer = GKLocalPlayer.localPlayer()
        
        
        localPlayer.authenticateHandler = { (viewController, error ) -> Void in
            
            if (viewController != nil) {
                let vc: UIViewController = view.window!.rootViewController!
                vc.present(viewController!, animated: true, completion: nil)
            } else {
                print("Authentication is \(GKLocalPlayer.localPlayer().isAuthenticated)")
                // do something based on the player being logged in
                self.gameCenterAchievements.removeAll()
                self.loadAcheivementPercentages()
            }
        }
    }
    
    
    
    func loadAcheivementPercentages() {
        print("getting percentage of past achievements")
        
        GKAchievement.loadAchievements { (allAchievements, error) -> Void in
            if error != nil {
                print("Game center did not load achievements, the error is \(error)")
            } else {
                // this could be nil if there was no progress on any achievements thus far.
                if (allAchievements != nil) {
                    
                    for theAcheivements in allAchievements! {
                        if let singleAchievement: GKAchievement = theAcheivements{
                            self.gameCenterAchievements[singleAchievement.identifier!] = singleAchievement
                        }
                    }
                    
                    for (id, acheivement) in self.gameCenterAchievements {
                        print("\(id) - \(acheivement.percentComplete)")
                    }
                }
            }
        }
        
    }
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
        gameCenterAchievements.removeAll()
        loadAcheivementPercentages()
    }
    
}
