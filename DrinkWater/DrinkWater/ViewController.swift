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
	
	@IBOutlet weak var medalView: MedalView!
	
	var isGraphViewShowing = false
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		checkTotal()
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
		checkTotal()
	}
	@IBAction func counterViewTap(_ gesture: UITapGestureRecognizer?) {
		if (isGraphViewShowing) {
			UIView.transition(from: graphView, to: counterView,
			                  duration: 1.0,
			                  options:[.transitionFlipFromLeft, .showHideTransitionViews],
			                  completion: nil)
		} else {
			UIView.transition(from: counterView, to: graphView, duration: 1.0, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
			
			setupGraphDisplay()
		}
		isGraphViewShowing = !isGraphViewShowing
	}
	
	func setupGraphDisplay() {
		
//		1 - replace last day with today's actual data
		let maxDayIndex = stackView.arrangedSubviews.count - 1
		graphView.graphPoints[graphView.graphPoints.count-1] = counterView.counter
		
//		2 - indacates that graph needs to be redrawn
		graphView.setNeedsDisplay()
		maxLabel.text = "\(graphView.graphPoints.max()!)"
		
//		3 - calculate average from graphPoints
		let average = graphView.graphPoints.reduce(0, +) / graphView.graphPoints.count
		averageWaterDrunk.text = "\(average)"
		
//		4 - setup date formatter and calendar
		let today = Date()
		let calendar = Calendar.current
		
		let formatter = DateFormatter()
		formatter.setLocalizedDateFormatFromTemplate("EEEEE")
		
//		5  - setup the day name labels with correct days
		for i in 0...maxDayIndex {
			if let date = calendar.date(byAdding: .day, value: -i, to: today),
				let label = stackView.arrangedSubviews[maxDayIndex - i] as? UILabel {
				label.text = formatter.string(from: date)
			}
		}
	}
	
	func checkTotal() {
		if counterView.counter >= 8 {
			medalView.showMedal(show: true)
		} else {
			medalView.showMedal(show: false)
		}
	}
}

