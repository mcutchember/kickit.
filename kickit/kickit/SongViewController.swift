//
//  CharacterViewController.swift
//  kickit
//
//  Created by Myle$ on 7/26/17.
//  Copyright © 2017 Myle$. All rights reserved.
//
import UIKit
import AVFoundation

class SongViewController: UIViewController
{
    
    var holdPlayer: AVAudioPlayer?

    
   
    
    
    
    var enemyImage: UIImage?
    var playerImage: UIImage?
    
    var defaults = UserDefaults.standard
    var characterNum = 0
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var song = Songs.fetchInterests()
    let cellScaling: CGFloat = 0.6
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let screenSize = UIScreen.main.bounds.size
        let cellWidth = floor(screenSize.width * cellScaling)
        let cellHeight = floor(screenSize.height * cellScaling)
        
        let insetX = (view.bounds.width - cellWidth) / 2.0
        let insetY = (view.bounds.height - cellHeight) / 2.0
        
        let layout = collectionView!.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        collectionView?.contentInset = UIEdgeInsets(top: insetY, left: insetX, bottom: insetY, right: insetX)
        
        collectionView?.dataSource = self
        collectionView?.delegate = self
        holdPlayer?.pause()
        
    }
    
    @IBAction func okAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        
        
    }
    
    
   
    
    @IBAction func resetButton(_ sender: Any) {
        
        let domain = Bundle.main.bundleIdentifier!
        defaults.removePersistentDomain(forName: domain)
        // UserDefaults.standard.synchronize()
        
        // set enemy back
    }
    
    
    func playSound(sound: String) {
        guard let url = Bundle.main.url(forResource: sound, withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            holdPlayer = try AVAudioPlayer(contentsOf: url)
            guard let player = holdPlayer else { return }
            
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
}

extension SongViewController : UICollectionViewDataSource
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return song.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SongCell", for: indexPath) as! SongViewCell
        
        cell.interest = song[indexPath.item]
        
        return cell
    }
}

extension SongViewController : UIScrollViewDelegate, UICollectionViewDelegate
{
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)
    {
        let layout = self.collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        let roundedIndex = round(index)
        
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
        targetContentOffset.pointee = offset
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var visibleRect = CGRect()
        
        visibleRect.origin = collectionView.contentOffset
        visibleRect.size = collectionView.bounds.size
        
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        
        let visibleIndexPath: IndexPath = collectionView.indexPathForItem(at: visiblePoint)!
        
        print("\(visibleIndexPath.row) YAHHH")
        characterNum = visibleIndexPath.row
        
        setSelection(index: visibleIndexPath)
        
        switch characterNum {
        case 0:
            playSound(sound: song[0].title)
            self.defaults.set(song[0].title, forKey: "songSelect")
            print("Sound saved!")
            
            break
        case 1:
            playSound(sound: song[1].title)
            self.defaults.set(song[1].title, forKey: "songSelect")
            print("Sound saved!")

            break
        case 2:
            playSound(sound: song[2].title)
            self.defaults.set(song[2].title, forKey: "songSelect")
            print("Sound saved!")

            break
        case 3:
            playSound(sound: song[3].title)
            self.defaults.set(song[3].title, forKey: "songSelect")
            print("Sound saved!")

            break
        case 4:
            playSound(sound: song[4].title)
            self.defaults.set(song[4].title, forKey: "songSelect")
            print("Sound saved!")

            break
                default:
            break
        }
    }
    
    func setSelection(index: IndexPath) {
        
        for i in 0...5 {
            if i == index.row {
                let cell = collectionView.cellForItem(at: index)
                cell?.layer.borderColor = UIColor.green.cgColor
                cell?.layer.borderWidth = 1
            } else {
                let cell = collectionView.cellForItem(at: IndexPath(row: i, section: 0))
                cell?.layer.borderColor = UIColor.clear.cgColor
                cell?.layer.borderWidth = 1
            }
            
        }
        
        
    }
    
    
    
}


