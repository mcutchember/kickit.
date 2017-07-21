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
import AVKit

class ViewController: UIViewController, GADInterstitialDelegate, GKGameCenterControllerDelegate {
	
	var interstitial: GADInterstitial!
    var player: AVAudioPlayer?
    
    
	override func viewDidLoad() {
		super.viewDidLoad()
        
        
        playSound()
        player?.prepareToPlay()
        player?.play()
		
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

		let gcVC = GKGameCenterViewController()
		gcVC.gameCenterDelegate = self
		gcVC.viewState = .leaderboards
		gcVC.leaderboardIdentifier = "002"
		present(gcVC, animated: true, completion: nil)

	}
	
	
	@IBAction func shareToTwitter(_ sender: Any) {
		
		if let vc = SLComposeViewController(forServiceType:SLServiceTypeTwitter){
			vc.add(#imageLiteral(resourceName: "appicon"))
			vc.add(URL(string: "https://appsto.re/us/ulMYkb.i"))
			vc.setInitialText("I'm about to Kickit! Try to beat me, it's free! Download now on the App Store! https://appsto.re/us/ulMYkb.i")
			self.present(vc, animated: true, completion: nil)
		}
	}
	
	@IBAction func shareToFacebook(_ sender: Any) {
		
		if let vc = SLComposeViewController(forServiceType:SLServiceTypeFacebook){
			vc.add(#imageLiteral(resourceName: "appicon"))
			vc.add(URL(string: "https://appsto.re/us/ulMYkb.i"))
			vc.setInitialText("I'm about to Kickit! Try to beat me, it's free! Download now on the App Store! https://appsto.re/us/ulMYkb.i")
			self.present(vc, animated: true, completion: nil)
		}
		
	}
    
    func playSound() {
        guard let url = Bundle.main.path(forResource: "KickIt", ofType: "mp3") else {
            print("error")
            return
        }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: url))
			player?.numberOfLoops = -1
            guard player != nil else { return }
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "game" {
            let destination = segue.destination as! GameViewController
            destination.holdPlayer = player
        }
    }
	
	// Delegate to dismiss the GC controller
	func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
		gameCenterViewController.dismiss(animated: true, completion: nil)
	}
    
}

