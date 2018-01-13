//
//  EmotionsViewController.swift
//  Faceit
//
//  Created by LinuxPlus on 12/5/17.
//  Copyright © 2017 MarinaS. All rights reserved.
//

import UIKit

class EmotionsViewController: VCLLoggingViewController {

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		var destinantionViewContrller = segue.destination
		if let navigationController = destinantionViewContrller as? UINavigationController {
			destinantionViewContrller = navigationController.visibleViewController ?? destinantionViewContrller
		}
		if let faceViewController = destinantionViewContrller as? FaceViewController,
			let identifier = segue.identifier,
			let expression = emotionalFaces[identifier] {
				faceViewController.expression = expression
			faceViewController.navigationItem.title = (sender as? UIButton)?.currentTitle
		}
    }
	
	private let emotionalFaces: Dictionary<String,FacialExpression> = [
		"sad" : FacialExpression(eyes: .closed, mouth: .frown),
		"happy" : FacialExpression(eyes: .open, mouth: .smile),
		"worried" : FacialExpression(eyes: .open,  mouth: .smirk)
	]

	

}
