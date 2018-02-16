//
//  ViewController.swift
//  DrinkWater
//
//  Created by LinuxPlus on 2/8/18.
//  Copyright © 2018 Stanford Uneversity. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var averageWaterDrunk: UILabel!
	@IBOutlet weak var maxLabel: UILabel!
	@IBOutlet weak var stackView: UIStackView!
	
	@IBOutlet weak var containterView: UIView!
	@IBOutlet weak var graphView: GraphView!
	
	@IBOutlet weak var counterView: CounterView!
	@IBOutlet weak var counterLabel: UILabel!
	
	var isGraphViewShowing = false
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
		if isGraphViewShowing {
			counterViewTap(nil)
		}
	}
	@IBAction func counterViewTap(_ gesture: UITapGestureRecognizer?) {
		if (isGraphViewShowing) {
			UIView.transition(from: graphView, to: counterView,
			                  duration: 1.0,
			                  options:[.transitionFlipFromLeft, .showHideTransitionViews],
			                  completion: nil)
		} else {
			UIView.transition(from: counterView, to: graphView, duration: 1.0, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
		}
		isGraphViewShowing = !isGraphViewShowing
	}
	
	func setupGraphDisplay() {
		let maxDayIndex = stackView.arrangedSubviews.count - 1
		graphView.graphPoints[graphView.graphPoints.count-1] = counterView.counter
		graphView.setNeedsDisplay()
		maxLabel.text = "\(graphView.graphPoints.max()!)"
		
	}
}

