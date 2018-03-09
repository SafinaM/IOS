//
//  menuViewController.swift
//  Faceit-L4
//
//  Created by LinuxPlus on 3/9/18.
//  Copyright © 2018 Stanford Uneversity. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		let destinationViewController = segue.destination
		if let fifteenViewController = destinationViewController as? ViewController,
			let identifier = segue.identifier,
			let comb = combinations[identifier] {
			
//			fifteenViewController.fifteenView =
	}
}

	private let combinations: Dictionary<String, String> = [
		"game" : "new game",
		"continue" : "cont",
		"score" : "score"
	]
}
