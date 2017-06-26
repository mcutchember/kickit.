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
