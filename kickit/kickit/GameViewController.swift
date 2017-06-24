//
//  GameViewController.swift
//  kickit
//
//  Created by Myle$ on 6/16/17.
//  Copyright © 2017 Myle$. All rights reserved.
//

import UIKit
import GoogleMobileAds

class GameViewController: UIViewController, GADInterstitialDelegate {
	
	// enums
	fileprivate enum ScreenEdge: Int{
		case top = 0
		case right = 1
		case bottom = 2
		case left = 3
	}
	
	
	fileprivate enum GameState {
		case ready
		case playing
		case gameOver
	}
	
	// constants
	fileprivate let radius: CGFloat = 10
	fileprivate let playerAnimationDuration = 5.0
	fileprivate let enemySpeed: CGFloat = 50 // points per second
	fileprivate let colors = [#colorLiteral(red: 0.8723958333, green: 0.4548068576, blue: 0.8566080729, alpha: 1), #colorLiteral(red: 0.07058823529, green: 0.5725490196, blue: 0.4470588235, alpha: 1), #colorLiteral(red: 0.9333333333, green: 0.7333333333, blue: 0, alpha: 1), #colorLiteral(red: 0.9411764706, green: 0.5450980392, blue: 0, alpha: 1), #colorLiteral(red: 0.1411764706, green: 0.7803921569, blue: 0.3529411765, alpha: 1), #colorLiteral(red: 0.1176470588, green: 0.6431372549, blue: 0.2941176471, alpha: 1), #colorLiteral(red: 0.8784313725, green: 0.4156862745, blue: 0.03921568627, alpha: 1), #colorLiteral(red: 0.7882352941, green: 0.2470588235, blue: 0, alpha: 1), #colorLiteral(red: 0.1490196078, green: 0.5098039216, blue: 0.8352941176, alpha: 1), #colorLiteral(red: 0.1137254902, green: 0.4156862745, blue: 0.6784313725, alpha: 1), #colorLiteral(red: 0.8823529412, green: 0.2, blue: 0.1607843137, alpha: 1), #colorLiteral(red: 0.7019607843, green: 0.1411764706, blue: 0.1098039216, alpha: 1), #colorLiteral(red: 0.537254902, green: 0.2352941176, blue: 0.662745098, alpha: 1), #colorLiteral(red: 0.4823529412, green: 0.1490196078, blue: 0.6235294118, alpha: 1), #colorLiteral(red: 0.6862745098, green: 0.7137254902, blue: 0.7333333333, alpha: 1), #colorLiteral(red: 0.7726779514, green: 0.8463270399, blue: 0.8538411458, alpha: 1), #colorLiteral(red: 0.9995340705, green: 0.1800175467, blue: 0.3211466681, alpha: 1), #colorLiteral(red: 0.6707899306, green: 0.2103407118, blue: 0.09564887153, alpha: 1), #colorLiteral(red: 0.9962293837, green: 0.9022081163, blue: 0.4596625434, alpha: 1)]
	
	// file privates
	fileprivate let playerView = UIView(frame: .zero)
	fileprivate var playerAnimator: UIViewPropertyAnimator?
	
	fileprivate var enemyViews = [UIView]()
	fileprivate var enemyAnimators = [UIViewPropertyAnimator]()
	fileprivate var enemyTimer: Timer?
	
	fileprivate var displayLink: CADisplayLink?
	fileprivate var beginTimestamp: TimeInterval = 0
	fileprivate var elapsedTime: TimeInterval = 0
	
	fileprivate var gameState = GameState.ready
	
	fileprivate var interstitial: GADInterstitial!
	
	// IBOutlet
	
	@IBOutlet var startLabel: UILabel!
	@IBOutlet var clockLabel: UILabel!
	
	
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
	
    
    
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Do any additional setup after loading the view.
		setupPlayerView()
		prepareGame()
		interstitial = createAndLoadInterstitial()
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		// First touch to begin the game
		if gameState == .ready {
			startGame()
		}
		
		if let touchLocation = event?.allTouches?.first?.location(in: view){
			// Move player to new postion
			movePlayer(to: touchLocation)
			
			// Move enimies to the new postion to trace the player
			moveEnemies(to: touchLocation)
		}
	}
	
	// Selectors
	func generateEnemy(timer: Timer) {
		// Generate an enemy with random position
		let screenEdge = ScreenEdge.init(rawValue: Int(arc4random_uniform(4)))
		let screenBounds = UIScreen.main.bounds
		var position: CGFloat = 0
		
		switch screenEdge! {
		case .left, .right:
			position = CGFloat(arc4random_uniform(UInt32(screenBounds.height)))
		case .top, .bottom:
			position = CGFloat(arc4random_uniform(UInt32(screenBounds.width)))
		}
		
		// Add the new enemy to the view
		let enemyView = UIView(frame: .zero)
		enemyView.bounds.size = CGSize(width: radius, height: radius)
		enemyView.backgroundColor = getRandomColor()
		
		switch screenEdge! {
		case .left:
			enemyView.center = CGPoint(x: 0, y: position)
		case .right:
			enemyView.center = CGPoint(x: screenBounds.width, y: position)
		case .top:
			enemyView.center = CGPoint(x: position, y: screenBounds.height)
		case .bottom:
			enemyView.center = CGPoint(x: position, y: 0)
		}
		
		view.addSubview(enemyView)
		
		// Start animation
		let duration = getEnemyDuration(enemyView: enemyView)
		let enemyAnimator = UIViewPropertyAnimator(duration: duration,
		                                           curve: .linear,
		                                           animations: { [weak self] in
													if let strongSelf = self {
														enemyView.center = strongSelf.playerView.center
													}
			}
		)
		enemyAnimator.startAnimation()
		enemyAnimators.append(enemyAnimator)
		enemyViews.append(enemyView)
	}
	
	func tick(sender: CADisplayLink) {
		updateCountUpTimer(timestamp: sender.timestamp)
		checkCollision()
	}
	
	// Load add from AddMob
	func createAndLoadInterstitial() -> GADInterstitial {
		interstitial = GADInterstitial(adUnitID: "ca-app-pub-7367066270682286/3663865657")
		interstitial.delegate = self
		let request = GADRequest()
		request.testDevices = [ kGADSimulatorID, "B270CD6C-F126-4C2D-937D-3B5D67056257" ];
		self.interstitial.load(request)
		return interstitial
	}
	
	func interstitialDidDismissScreen(_ ad: GADInterstitial) {
		showGameOverAlert()
		interstitial = createAndLoadInterstitial()
	}
	
}

fileprivate extension GameViewController {
	func setupPlayerView() {
		playerView.bounds.size = CGSize(width: radius * 2, height: radius * 2)
		playerView.layer.cornerRadius = radius
		playerView.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
		
		view.addSubview(playerView)
	}
	
	func startEnemyTimer() {
		enemyTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(generateEnemy(timer:)), userInfo: nil, repeats: true)
	}
	
	func stopEnemyTimer() {
		guard let enemyTimer = enemyTimer,
			enemyTimer.isValid else {
				return
		}
		enemyTimer.invalidate()
	}
	
	func startDisplayLink() {
		displayLink = CADisplayLink(target: self, selector: #selector(tick(sender:)))
		displayLink?.add(to: RunLoop.main, forMode: RunLoopMode.defaultRunLoopMode)
	}
	
	func stopDisplayLink() {
		displayLink?.isPaused = true
		displayLink?.remove(from: RunLoop.main, forMode: RunLoopMode.defaultRunLoopMode)
		displayLink = nil
	}
	
	func getRandomColor() -> UIColor {
		let index = arc4random_uniform(UInt32(colors.count))
		return colors[Int(index)]
	}
	
	func getEnemyDuration(enemyView: UIView) -> TimeInterval {
		let dx = playerView.center.x - enemyView.center.x
		let dy = playerView.center.y - enemyView.center.y
		return TimeInterval(sqrt(dx * dx + dy * dy) / enemySpeed)
	}
	
	func gameOver() {
		stopGame()
		displayGameOverAlert()
	}
	
	func stopGame() {
		stopEnemyTimer()
		stopDisplayLink()
		stopAnimators()
		gameState = .gameOver
	}
	
	func prepareGame() {
		removeEnemies()
		centerPlayerView()
		popPlayerView()
		startLabel.isHidden = false
		clockLabel.text = "00:00.000"
		gameState = .ready
	}
	
	func startGame() {
		startEnemyTimer()
		startDisplayLink()
		startLabel.isHidden = true
		beginTimestamp = 0
		gameState = .playing
	}
	
	func removeEnemies() {
		enemyViews.forEach {
			$0.removeFromSuperview()
		}
		enemyViews = []
	}
	
	func stopAnimators() {
		playerAnimator?.stopAnimation(true)
		playerAnimator = nil
		enemyAnimators.forEach {
			$0.stopAnimation(true)
		}
		enemyAnimators = []
	}
	
	func updateCountUpTimer(timestamp: TimeInterval) {
		if beginTimestamp == 0 {
			beginTimestamp = timestamp
		}
		elapsedTime = timestamp - beginTimestamp
		clockLabel.text = format(timeInterval: elapsedTime)
	}
	
	func format(timeInterval: TimeInterval) -> String {
		let interval = Int(timeInterval)
		let seconds = interval % 60
		let minutes = (interval / 60) % 60
		let milliseconds = Int(timeInterval * 1000) % 1000
		return String(format: "%02d:%02d.%03d", minutes, seconds, milliseconds)
	}
	
	func checkCollision() {
		enemyViews.forEach {
			guard let playerFrame = playerView.layer.presentation()?.frame,
				let enemyFrame = $0.layer.presentation()?.frame,
				playerFrame.intersects(enemyFrame) else {
					return
			}
			
			if enemyFrame.intersects(($0.layer.presentation()?.frame)!) {
				print("Yes")
			}
			
			gameOver()
		}
	}
	
	func movePlayer(to touchLocation: CGPoint) {
		playerAnimator = UIViewPropertyAnimator(duration: playerAnimationDuration,
		                                        dampingRatio: 0.5,
		                                        animations: { [weak self] in
													self?.playerView.center = touchLocation
		})
		playerAnimator?.startAnimation()
	}
	
	func moveEnemies(to touchLocation: CGPoint) {
		for (index, enemyView) in enemyViews.enumerated() {
			let duration = getEnemyDuration(enemyView: enemyView)
			enemyAnimators[index] = UIViewPropertyAnimator(duration: duration,
			                                               curve: .linear,
			                                               animations: {
															enemyView.center = touchLocation
			})
			enemyAnimators[index].startAnimation()
		}
	}
	
	func displayGameOverAlert() {
		
		if interstitial.isReady {
			interstitial.present(fromRootViewController: self)
		} else {
			print("Ad wasn't ready")
			showGameOverAlert()
		}
		
	}
	
	
	func showGameOverAlert() {
		let (title, message) = getGameOverTitleAndMessage()
		let alert = UIAlertController(title: "Game Over!", message: message, preferredStyle: .alert)
		let action = UIAlertAction(title: title, style: .default,
		                           handler: { _ in
									self.prepareGame()
		}
		)
		let action2 = UIAlertAction(title: "Share your score", style: .default,
		                           handler: { _ in
									//TODO: Add Share  
                                    self.dismiss(animated: true, completion: nil)
		}
		)
		alert.addAction(action)
		alert.addAction(action2)
		self.present(alert, animated: true, completion: nil)
	}
	
	func getGameOverTitleAndMessage() -> (String, String) {
		let elapsedSeconds = Int(elapsedTime) % 60
		switch elapsedSeconds {
		case 0..<10: return ("Try again 😂", "Seriously, you need more practice 😒")
		case 10..<30: return ("Another go 😉", "Not bad, you are getting there 😁")
		case 30..<60: return ("Play again 😉", "Very good 👍")
		default:
			return ("You're the GOAT 😚", "Legend, olympic player, go 🇧🇷")
		}
	}
	
	func centerPlayerView() {
		// Place the player in the center of the screen.
		playerView.center = view.center
	}
	
	// Copy from IBAnimatable
	func popPlayerView() {
		let animation = CAKeyframeAnimation(keyPath: "transform.scale")
		animation.values = [0, 0.2, -0.2, 0.2, 0]
		animation.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
		animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
		animation.duration = CFTimeInterval(0.7)
		animation.isAdditive = true
		animation.repeatCount = 1
		animation.beginTime = CACurrentMediaTime()
		playerView.layer.add(animation, forKey: "pop")
	}
	
	
	
}
