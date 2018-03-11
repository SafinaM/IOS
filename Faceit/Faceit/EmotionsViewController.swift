//
//  EmotionsViewController.swift
//  Faceit
//
//  Created by LinuxPlus on 12/5/17.
//  Copyright © 2017 MarinaS. All rights reserved.
//

import UIKit

class EmotionsViewController: UITableViewController {
	
	// MARK: Model
	
	private var emotionalFaces: [(name: String, expression: FacialExpression)] = [
		("Sad", FacialExpression(eyes: .closed, mouth: .frown)),
		("Happy", FacialExpression(eyes: .open, mouth: .smile)),
		("Worried", FacialExpression(eyes: .open,  mouth: .smirk))
	]
	
	
	// MARK: UITableViewDataSource
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return emotionalFaces.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Emotion Cell", for: indexPath)
		cell.textLabel?.text = emotionalFaces[indexPath.row].name
		return cell 
	}
	
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		var destinantionViewContrller = segue.destination
		if let navigationController = destinantionViewContrller as? UINavigationController {
			destinantionViewContrller = navigationController.visibleViewController ?? destinantionViewContrller
		}
		if let faceViewController = destinantionViewContrller as? FaceViewController,
			let cell = sender as? UITableViewCell,
			let indexPath = tableView.indexPath(for: cell) {
			faceViewController.expression = emotionalFaces[indexPath.row].expression
			faceViewController.navigationItem.title = emotionalFaces[indexPath.row].name
		}
	}
	
	

}
