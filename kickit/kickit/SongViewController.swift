//
//  SongViewController.swift
//  kickit
//
//  Created by Myle$ on 9/24/17.
//  Copyright © 2017 Myle$. All rights reserved.
//

import UIKit

class SongViewController: UIViewController {
    
    var songImage: UIImage?
    
    var defaults = UserDefaults.standard
    var characterNum = 0
    
    var songs = Songs.fetchInterests()
    let cellScaling: CGFloat = 0.6

    @IBOutlet var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
    @IBAction func okButton(_ sender: Any) {
    }

}
