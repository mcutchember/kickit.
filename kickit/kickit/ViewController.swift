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
import Pastel
import GoogleMobileAds

class ViewController: UIViewController, GADInterstitialDelegate {
	
	var interstitial: GADInterstitial!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let pastelView = PastelView(frame: view.bounds)
		
		// Custom Direction
		pastelView.startPastelPoint = .bottomLeft
		pastelView.endPastelPoint = .topRight
		
		// Custom Duration
		pastelView.animationDuration = 3.0
		
		// Custom Color
		pastelView.setColors([UIColor(red: 156/255, green: 39/255, blue: 176/255, alpha: 1.0),
		                      UIColor(red: 255/255, green: 64/255, blue: 129/255, alpha: 1.0),
		                      UIColor(red: 123/255, green: 31/255, blue: 162/255, alpha: 1.0),
		                      UIColor(red: 32/255, green: 76/255, blue: 255/255, alpha: 1.0),
		                      UIColor(red: 32/255, green: 158/255, blue: 255/255, alpha: 1.0),
		                      UIColor(red: 90/255, green: 120/255, blue: 127/255, alpha: 1.0),
		                      UIColor(red: 58/255, green: 255/255, blue: 217/255, alpha: 1.0)])
		
		pastelView.startAnimation()
		view.insertSubview(pastelView, at: 0)
		
		HighScoreManager.sharedInstance.authenticateLocalPlayer(view: self.view)
		HighScoreManager.sharedInstance.loadAcheivementPercentages()
		
	}
	
	
	@IBAction func highscoreButton(_ sender: Any) {

		let vc: UIViewController = self.view!.window!.rootViewController!
		vc.present(HighScoreManager.sharedInstance.declareGameCenterController(), animated: true, completion: nil)

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

