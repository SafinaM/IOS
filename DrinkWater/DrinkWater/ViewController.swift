//
//  ViewController.swift
//  DrinkWater
//
//  Created by LinuxPlus on 2/8/18.
//  Copyright © 2018 Stanford Uneversity. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


	
	@IBOutlet weak var counterView: CounterView!
	@IBOutlet weak var counterLabel: UILabel!
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	@IBAction func pushButtonPressed(_ button: PushButton) {
		if button.isAddButton {
			counterView.counter += 1
		} else {
			if counterView.counter > 0 {
				counterView.counter -= 1
			}
		}
		counterLabel.text = String(counterView.counter)
	}
}

