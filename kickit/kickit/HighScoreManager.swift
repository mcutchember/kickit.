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
	var gameCenterAchievements  = [String: GKAchievement]()
	static let sharedInstance = HighScoreManager()
	
	override init() {
		
	}
	
	func declareGameCenterController() -> GKGameCenterViewController {
		self.gameCenterViewController.gameCenterDelegate = self
		return self.gameCenterViewController
	}
	
	func authenticateLocalPlayer(view: UIView){
		let localPlayer = GKLocalPlayer.localPlayer()
		
		
		localPlayer.authenticateHandler = { (viewController, error ) -> Void in
			
			if (viewController != nil) {
				
				let authController = AuthController(authController: viewController!)
				authController.viewWillDisappearHandler = { (animated: Bool) -> () in
					print("viewController is disappearing")
				}
				
				let vc: UIViewController = view.window!.rootViewController!
				vc.present(authController, animated: true, completion: nil)
				
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
				print("Game center did not load achievements, the error is \(String(describing: error))")
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
	
	func saveHighScore(highscore: Int) {
		
		if GKLocalPlayer.localPlayer().isAuthenticated {
			let gkScore = GKScore(leaderboardIdentifier: "kickit_scores")
			gkScore.value = Int64(highscore)
			GKScore.report([gkScore], withCompletionHandler: { (error) in
				if (error != nil) {
					// handle error
					print("Error: " + (error?.localizedDescription)!);
				} else {
					print("Score reported: \(gkScore.value)")
				}
			})
		}
	}
	
}


class AuthController: UINavigationController {
	
	var viewWillDisappearHandler: ((Bool) -> ())?
	
	convenience init(authController: UIViewController) {
		self.init(rootViewController: authController)
		
		self.isModalInPopover = true
		self.modalPresentationStyle = UIModalPresentationStyle.formSheet
		self.isNavigationBarHidden = true
		self.preferredContentSize = authController.preferredContentSize
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		viewWillDisappearHandler?(animated)
	}
}
