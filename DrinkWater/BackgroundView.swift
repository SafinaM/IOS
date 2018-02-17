//
//  BackgroundView.swift
//  DrinkWater
//
//  Created by LinuxPlus on 2/17/18.
//  Copyright © 2018 Stanford Uneversity. All rights reserved.
//

import UIKit

@IBDesignable
class BackgroundView: UIView {

	@IBInspectable var lightColor: UIColor = UIColor.orange
	@IBInspectable var darkColor: UIColor  = UIColor.yellow
	@IBInspectable var patternSize: CGFloat = 200
	
    override func draw(_ rect: CGRect) {
		
		let context = UIGraphicsGetCurrentContext()!
		context.setFillColor(darkColor.cgColor)
		context.fill(rect)
		
		let drawSize = CGSize(width: patternSize, height: patternSize)
		
		UIGraphicsBeginImageContextWithOptions(drawSize, true, 0.0)
		let drawingContext = UIGraphicsGetCurrentContext()!
		darkColor.setFill()
		drawingContext.fill(CGRect(x: 0, y: 0, width: drawSize.width, height: drawSize.height))
		
		let trianglePath = UIBezierPath()
		// 1
		trianglePath.move(to: CGPoint(x: drawSize.width/2, y: 0))
		// 2
		trianglePath.addLine(to: CGPoint(x: 0, y: drawSize.height / 2))
		// 3
		trianglePath.addLine(to: CGPoint(x: drawSize.width, y: drawSize.height / 2))
		// 4
		trianglePath.move(to: CGPoint(x: 0, y: drawSize.height / 2))
		// 5
		trianglePath.addLine(to: CGPoint(x: drawSize.width / 2, y: drawSize.height))
		// 6
		trianglePath.addLine(to: CGPoint(x: 0, y: drawSize.height))
		// 7
		trianglePath.move(to: CGPoint(x: drawSize.width, y: drawSize.height/2))
		// 8
		trianglePath.addLine(to: CGPoint(x: drawSize.width / 2, y: drawSize.height))
		// 9
		trianglePath.addLine(to: CGPoint(x: drawSize.width, y: drawSize.height))
		
		lightColor.setFill()
		trianglePath.fill()
		
		let image = UIGraphicsGetImageFromCurrentImageContext()!
		UIGraphicsEndImageContext()
		
		UIColor(patternImage: image).setFill()
		context.fill(rect)
    }
	
	
}

