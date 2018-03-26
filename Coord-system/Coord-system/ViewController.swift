//
//  ViewController.swift
//  Coord-system
//
//  Created by LinuxPlus on 3/25/18.
//  Copyright © 2018 Stanford Uneversity. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	@IBOutlet weak var coordinateSystemView: CoordinateSystem! {
		didSet {
			let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.changeAngle(byReactingTo:)))
			tapRecognizer.numberOfTapsRequired = 1
			coordinateSystemView.addGestureRecognizer(tapRecognizer)
			updateUI()
		}
	}
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	var touchPoint: CGPoint = CGPoint()
	
	func changeAngle(byReactingTo tapRecognizer: UITapGestureRecognizer)
	{
		CoordinateSystem.Constants.pitch += 0.07
		CoordinateSystem.Constants.yaw += 0.05
		CoordinateSystem.Constants.roll += 0.06
		if tapRecognizer.state == .ended {
			touchPoint = tapRecognizer.location(in: coordinateSystemView)
			coordinateSystemView.touchPoint = touchPoint
			print(CoordinateSystem.Constants.pitch)
			print(touchPoint)
		}
		
	}
	
	private func updateUI() {
		print("updateUI() ")
	}
}

