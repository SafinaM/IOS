//
//  GraphView.swift
//  DrinkWater
//
//  Created by LinuxPlus on 2/12/18.
//  Copyright © 2018 Stanford Uneversity. All rights reserved.
//

import UIKit

@IBDesignable class GraphView: UIView {

	@IBInspectable var startColor: UIColor = .red
	@IBInspectable var endColor: UIColor = .green
	
	override func draw(_ rect: CGRect) {
		
        let context = UIGraphicsGetCurrentContext()!
		let colors = [startColor.cgColor, endColor.cgColor]
		
		let colorSpace = CGColorSpaceCreateDeviceRGB()
		let colorLocations: [CGFloat] = [0.0, 1.0]
		
		let gradient = CGGradient(colorsSpace: colorSpace,
		                          colors: colors as CFArray,
		                          locations: colorLocations)!
		
		let startPoint = CGPoint.zero
		let endPoint = CGPoint(x: 0, y: bounds.height)
		context.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: [])
    }
	

}
