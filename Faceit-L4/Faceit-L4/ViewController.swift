//
//  ViewController.swift
//  Faceit-L4
//
//  Created by MarinaS on 1/26/18.
//  Copyright © 2018 MarinaS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	var movement: Movement.Direction = .left
	var touchPoint: CGPoint = CGPoint()
	
	
	@IBOutlet weak var fifteenView: FifteenView!
	{
		didSet {
			let handler = #selector(FifteenView.changeScale(byReactingTo:))
			let pinchRecognizer = UIPinchGestureRecognizer(target: FifteenView.self, action: handler)
			fifteenView.addGestureRecognizer(pinchRecognizer)
			let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.moveCell(byReactingTo:)))
			tapRecognizer.numberOfTapsRequired = 1
			fifteenView.addGestureRecognizer(tapRecognizer)
			updateUI()
		}
	}
	
	func moveCell(byReactingTo tapRecognizer: UITapGestureRecognizer)
	{
		
			if tapRecognizer.state == .ended {
				fifteenView.direction = (movement == .right) ? .left: .right
				movement = (fifteenView.direction != .right) ? .left: .right
				touchPoint = tapRecognizer.location(in: fifteenView)
				fifteenView.touchPoint = touchPoint
				print(touchPoint)
		}
		
	}
	
	var game = GameEnum(games: .restart) {
		didSet {
			updateUI()
		}
	}
	
	private func updateUI()
	{
		print("MSD game = ", game.games)
		switch game.games {
		case .restart:
			FifteenView.restartGame = true
			FifteenView.savedGame = false
		case .saved:
			FifteenView.restartGame = false
			FifteenView.savedGame = true
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


}

