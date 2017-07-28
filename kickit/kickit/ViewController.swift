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

class ViewController: UIViewController, GADInterstitialDelegate, GKGameCenterControllerDelegate, GADBannerViewDelegate {
	
	var interstitial: GADInterstitial!
	var player: AVAudioPlayer?
	let ADMOB_BANNER_UNIT_ID = "ca-app-pub-7367066270682286/5248259152"
	var adMobBannerView = GADBannerView()
	
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
	
	override func viewDidAppear(_ animated: Bool) {
		// Init AdMob banner
		initAdMobBanner()
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
	
	// MARK: Banner Delegates
	
	// MARK: -  ADMOB BANNER
	func initAdMobBanner() {
		
		if UIDevice.current.userInterfaceIdiom == .phone {
			// iPhone
			adMobBannerView.adSize =  GADAdSizeFromCGSize(CGSize(width: 320, height: 50))
			adMobBannerView.frame = CGRect(x: 0, y: view.frame.size.height, width: 320, height: 50)
		} else  {
			// iPad
			adMobBannerView.adSize =  GADAdSizeFromCGSize(CGSize(width: 468, height: 60))
			adMobBannerView.frame = CGRect(x: 0, y: view.frame.size.height, width: 468, height: 60)
		}
		
		adMobBannerView.adSize = kGADAdSizeSmartBannerPortrait
		adMobBannerView.adUnitID = ADMOB_BANNER_UNIT_ID
		adMobBannerView.rootViewController = self
		adMobBannerView.delegate = self
		view.addSubview(adMobBannerView)
		
		let request = GADRequest()
		request.testDevices = [ kGADSimulatorID, "B270CD6C-F126-4C2D-937D-3B5D67056257" ];
		adMobBannerView.load(request)
	}
	
	
	// Hide the banner
	func hideBanner(_ banner: UIView) {
		UIView.beginAnimations("hideBanner", context: nil)
		banner.frame = CGRect(x: view.frame.size.width/2 - banner.frame.size.width/2, y: view.frame.size.height - banner.frame.size.height, width: banner.frame.size.width, height: banner.frame.size.height)
		UIView.commitAnimations()
		banner.isHidden = true
	}
	
	// Show the banner
	func showBanner(_ banner: UIView) {
		UIView.beginAnimations("showBanner", context: nil)
		banner.frame = CGRect(x: view.frame.size.width/2 - banner.frame.size.width/2, y: view.frame.size.height - banner.frame.size.height, width: banner.frame.size.width, height: banner.frame.size.height)
		UIView.commitAnimations()
		banner.isHidden = false
	}
	
	// AdMob banner available
	func adViewDidReceiveAd(_ view: GADBannerView) {
		showBanner(adMobBannerView)
	}
	
	// NO AdMob banner available
	func adView(_ view: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
		hideBanner(adMobBannerView)
	}
	
}

