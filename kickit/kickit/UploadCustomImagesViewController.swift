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
	
	@IBOutlet weak var enemyButton: UIButton!
	@IBOutlet weak var playerButton: UIButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		picker.delegate = self
		
		// Do any additional setup after loading the view.
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
	
 //MARK: - Delegates
	@nonobjc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject])
	{
		let _ = info[UIImagePickerControllerOriginalImage] as! UIImage 
		dismiss(animated: true, completion: nil)
	}
	@nonobjc func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
		dismiss(animated: true, completion: nil)
	}
	
}
