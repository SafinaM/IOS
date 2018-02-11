//
//  ViewController.swift
//  Faceit-L4
//
//  Created by LinuxPlus on 1/26/18.
//  Copyright © 2018 Stanford Uneversity. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	var movement: Movement.Direction = .left
	var touchPoint: CGPoint = CGPoint()
	
	@IBOutlet weak var faceView: FaceView!
	{
		didSet {
			let handler = #selector(FaceView.changeScale(byReactingTo:))
			let pinchRecognizer = UIPinchGestureRecognizer(target: faceView, action: handler)
			faceView.addGestureRecognizer(pinchRecognizer)
			faceView.screenSize = UIScreen.main.bounds.size
			let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.moveCell(byReactingTo:)))
			tapRecognizer.numberOfTapsRequired = 1
			faceView.addGestureRecognizer(tapRecognizer)
			updateUI()
		}
	}
	
	func moveCell(byReactingTo tapRecognizer: UITapGestureRecognizer)
	{
		
			if tapRecognizer.state == .ended {
				faceView.direction = (movement == .right) ? .left: .right
				movement = (faceView.direction != .right) ? .left: .right
				touchPoint = tapRecognizer.location(in: faceView)
				faceView.touchPoint = touchPoint
				print(touchPoint)
		}
		
	}
	
	private func updateUI()
	{

	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

