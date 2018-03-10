//
//  menuViewController.swift
//  Faceit-L4
//
//  Created by MarinaS on 3/9/18.
//  Copyright © 2018 Stanford University. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		var destinationViewController = segue.destination
		if let navigationController = destinationViewController as? UINavigationController {
			destinationViewController = navigationController.visibleViewController ?? destinationViewController
		}
		if let fifteenViewController = destinationViewController as? ViewController,
			let identifier = segue.identifier,
			let segueType = combinations[identifier] {
			
			fifteenViewController.game = segueType
	}
}

	private let combinations: Dictionary<String, GameEnum> = [
		"restart" : GameEnum(games: .restart),
		"saved" : GameEnum(games: .saved),
	]
}
