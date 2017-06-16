//
//  GameViewController.swift
//  kickit
//
//  Created by Myle$ on 6/16/17.
//  Copyright © 2017 Myle$. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
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
    fileprivate let playerVIew = UIView(frame: .zero)
    fileprivate let playerAnimator: UIViewPropertyAnimator?
    
    fileprivate var enemyViews = [UIView]()
    fileprivate var enemyAnimators = [UIViewPropertyAnimator]()
    fileprivate var enemyTimer: Timer?
    
    fileprivate var displayLink: CADisplayLink?
    fileprivate var beginTimestamp: TimeInterval = 0
    fileprivate var elapsedTime: TimeInterval = 0
    
    fileprivate var gameState = GameState.ready
    
    // IBOutlet
    
    @IBOutlet var startLabel: UILabel!
    @IBOutlet var clockLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupPlayerView()
        prepareGame()
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        // First touch to begin the game 
//        if GameState = .ready {
//            startGame()
//        }
//        
//        if let touchLocation = event?.allTouches?.first?.location(in: view){
//            // Move player to new postion 
//            movePlayer(to: touchLocation)
//            
//            // Move enimies to the new postion to trace the player
//            moveEnimies(to: touchLocation)
//        }
//    }
   
}

fileprivate extension GameViewController {
    
}
