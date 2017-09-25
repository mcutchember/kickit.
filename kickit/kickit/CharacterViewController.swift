//
//  CharacterViewController.swift
//  kickit
//
//  Created by Myle$ on 7/26/17.
//  Copyright © 2017 Myle$. All rights reserved.
//
import UIKit

class CharacterViewController: UIViewController
{
	
	var enemyImage: UIImage?
	var playerImage: UIImage?
	
	var defaults = UserDefaults.standard
	var characterNum = 0
	
	
	@IBOutlet weak var collectionView: UICollectionView!
	
	var character = Characters.fetchInterests()
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
	}
	
	@IBAction func okAction(_ sender: UIButton) {
		dismiss(animated: true, completion: nil)
		
		
	}
	
	
	@IBAction func resetButton(_ sender: Any) {
		
		let domain = Bundle.main.bundleIdentifier!
		defaults.removePersistentDomain(forName: domain)
		// UserDefaults.standard.synchronize()
		
		// set enemy back
		//enemyButton.setImage(#imageLiteral(resourceName: "enemy"), for: .normal)
		//playerButton.setImage(#imageLiteral(resourceName: "ball"), for: .normal)
	}
}

extension CharacterViewController : UICollectionViewDataSource
{
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return character.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
	{
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCell", for: indexPath) as! CharacterViewCell
		
		cell.interest = character[indexPath.item]
		
		return cell
	}
}

extension CharacterViewController : UIScrollViewDelegate, UICollectionViewDelegate
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
			//self.defaults.set(UIImagePNGRepresentation(#imageLiteral(resourceName: "fire")), forKey: "enemyImage")
			self.defaults.set(UIImagePNGRepresentation(#imageLiteral(resourceName: "earth")), forKey: "playerImage")
			print("Enemy image saved!")
			print("Player image saved!")
			break
		case 1:
			//self.defaults.set(UIImagePNGRepresentation(#imageLiteral(resourceName: "ghost")), forKey: "enemyImage")
			self.defaults.set(UIImagePNGRepresentation(#imageLiteral(resourceName: "girl")), forKey: "playerImage")
			print("Enemy image saved!")
			print("Player image saved!")
			break
		case 2:
			//self.defaults.set(UIImagePNGRepresentation(#imageLiteral(resourceName: "devil")), forKey: "enemyImage")
			self.defaults.set(UIImagePNGRepresentation(#imageLiteral(resourceName: "angel")), forKey: "playerImage")
			print("Enemy image saved!")
			print("Player image saved!")
			break
		case 3:
			//self.defaults.set(UIImagePNGRepresentation(#imageLiteral(resourceName: "cat")), forKey: "enemyImage")
			self.defaults.set(UIImagePNGRepresentation(#imageLiteral(resourceName: "mouse")), forKey: "playerImage")
			print("Enemy image saved!")
			print("Player image saved!")
			break
		case 4:
			//self.defaults.set(UIImagePNGRepresentation(#imageLiteral(resourceName: "plate")), forKey: "enemyImage")
			self.defaults.set(UIImagePNGRepresentation(#imageLiteral(resourceName: "eat")), forKey: "playerImage")
			print("Enemy image saved!")
			print("Player image saved!")
			break
		case 5:
			//self.defaults.set(UIImagePNGRepresentation(#imageLiteral(resourceName: "mink2")), forKey: "enemyImage")
			self.defaults.set(UIImagePNGRepresentation(#imageLiteral(resourceName: "mink")), forKey: "playerImage")
			print("Enemy image saved!")
			print("Player image saved!")
			break
		case 6:
			//self.defaults.set(UIImagePNGRepresentation(#imageLiteral(resourceName: "lyle2")), forKey: "enemyImage")
			self.defaults.set(UIImagePNGRepresentation(#imageLiteral(resourceName: "julian1")), forKey: "playerImage")
			print("Enemy image saved!")
			print("Player image saved!")
			break
		case 7:
			//self.defaults.set(UIImagePNGRepresentation(#imageLiteral(resourceName: "lyle")), forKey: "enemyImage")
			self.defaults.set(UIImagePNGRepresentation(#imageLiteral(resourceName: "julian")), forKey: "playerImage")
			print("Enemy image saved!")
			print("Player image saved!")
			break
		default:
			break
		}
	}
	
	func setSelection(index: IndexPath) {
		
		for i in 0...7 {
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


