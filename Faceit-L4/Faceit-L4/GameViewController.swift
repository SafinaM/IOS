//
//  GameViewController.swift
//  Faceit-L4
//
//  Created by LinuxPlus on 2/5/18.
//  Copyright © 2018 Stanford Uneversity. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

	
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		let destinationViewController = segue.destination
		if let faceViewController = destinationViewController as? ViewController {
			if let identifier = segue.identifier {
				
			}
		}
    }
    

}
