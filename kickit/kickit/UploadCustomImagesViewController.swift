//
//  UploadCustomImagesViewController.swift
//  kickit
//
//  Created by Chris T Stuart on 6/22/17.
//  Copyright © 2017 Myle$. All rights reserved.
//

import UIKit

class UploadCustomImagesViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	
	let picker = UIImagePickerController()
	var typeForImage = ""
	
	var enemyImage: UIImage?
	var playerImage: UIImage?
	
	var defaults = UserDefaults.standard
	
	@IBOutlet weak var enemyButton: UIButton!
	@IBOutlet weak var playerButton: UIButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		picker.delegate = self
		
		if let enemyImage = defaults.data(forKey: "enemyImage") {
			enemyButton.setImage(UIImage(data: enemyImage), for: .normal)
		}
		
		if let playerImage = defaults.data(forKey: "playerImage") {
			playerButton.setImage(UIImage(data: playerImage), for: .normal)
		}
		
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	@IBAction func enemyAction(_ sender: UIButton)
	{
		openPicker(type: "Enemy")
	}
	
	@IBAction func playerAction(_ sender: UIButton)
	{
		openPicker(type: "Player")
	}
	
	func openPicker(type: String) {
		typeForImage = type
		picker.allowsEditing = false
		picker.sourceType = .photoLibrary
		picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
		present(picker, animated: true, completion: nil)
	}
	
	@IBAction func okAction(_ sender: UIButton) {
		dismiss(animated: true, completion: nil)
	}
    
    
    @IBAction func resetButton(_ sender: Any) {
        
        let domain = Bundle.main.bundleIdentifier!
        defaults.removePersistentDomain(forName: domain)
       // UserDefaults.standard.synchronize()
        
        // set enemy back
        enemyButton.setImage(#imageLiteral(resourceName: "enemy"), for: .normal)
        playerButton.setImage(#imageLiteral(resourceName: "ball"), for: .normal)
    }
    
    
	
 //MARK: - Delegates
	
	func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
		dismiss(animated: true, completion: nil)
	}
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
		print(info.debugDescription)
		
	 if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
		
		let pngImageData = UIImagePNGRepresentation(image)
		
		switch self.typeForImage {
		case "Enemy":
			self.defaults.set(pngImageData, forKey: "enemyImage")
            enemyButton.setImage(image, for: .normal)
			print("Enemy image saved!")
			break
		case "Player":
			self.defaults.set(pngImageData, forKey: "playerImage")
			print("Player image saved!")
            playerButton.setImage(image, for: .normal)
            playerButton.makeCircular()
			break
		default:
			break
		}
		
	} else {
		print("Something went wrong")
	 }
		
		dismiss(animated: true, completion: nil)
	}
	
}



