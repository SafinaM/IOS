//
//  CoordinateSystem.swift
//  Coord-system
//
//  Created by LinuxPlus on 3/25/18.
//  Copyright © 2018 Stanford Uneversity. All rights reserved.
//

import UIKit
@IBDesignable
class CoordinateSystem: UIView
{
	struct Constants
	{
		static let origin1 = CGPoint(x: 200, y: 200)
		static let origin2 = CGPoint(x: 200, y: 400)
		static let origin3 = CGPoint(x: 200, y: 600)
		static let pointArray: [Point] = [Point(0, -200, 0), Point(200, 0, 0), Point(0, 0, 200)]
	}
	
	struct Point {
		var x: CGFloat = 0
		var y: CGFloat = 0
		var z: CGFloat = 0
		
		init(_ x: CGFloat, _ y: CGFloat, _ z: CGFloat) {
			self.x = x
			self.y = y
			self.z = z
		}
		
		func getCGPoint() -> CGPoint {
			return CGPoint(x: x, y: y)
		}
	}
	private func moveToOrigin(point: CGPoint, origin: CGPoint) -> CGPoint {
		let newPoint: CGPoint = CGPoint(x: point.x + origin.x, y: point.y + origin.y)
		return newPoint
	}
	
	private func moveArrayToOrigin(points: [Point], origin: CGPoint) -> [CGPoint] {
		var arr = [CGPoint]()
		for point in points {
			let movedPoint = moveToOrigin(point: point.getCGPoint(), origin: origin)
			arr.append(movedPoint)
		}
		return arr
	}
	
	
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
		let path = UIBezierPath()
		let array = moveArrayToOrigin(points: Constants.pointArray, origin: Constants.origin3)
		for p in array {
			path.move(to: Constants.origin3)
			path.addLine(to: p)
		}
//		path.addArc(withCenter: CGPoint(x: 200, y: 200) , radius: 40, startAngle: 0, endAngle: 360, clockwise: true)
		UIColor.green.set()
		path.stroke()
    }
}
