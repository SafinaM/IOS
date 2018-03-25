//
//  CoordinateSystem.swift
//  Coord-system
//
//  Created by LinuxPlus on 3/25/18.
//  Copyright © 2018 Stanford Uneversity. All rights reserved.
//

import UIKit
@IBDesignable
class CoordinateSystem: UIView {

	
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
		let path = UIBezierPath(ovalIn: rect)
		path.move(to: CGPoint(x: 240, y: 240))
//		path.addArc(withCenter: CGPoint(x: 200, y: 200) , radius: 40, startAngle: 0, endAngle: 360, clockwise: true)
		path.stroke()
    }
}
