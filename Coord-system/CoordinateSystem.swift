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
	static var tapPressed = false
	var touchPoint: CGPoint = CGPoint() {didSet { setNeedsDisplay() } }
	struct Constants
	{
		static let origin1 = CGPoint(x: 200, y: 200)
		static let origin2 = CGPoint(x: 200, y: 400)
		static let origin3 = CGPoint(x: 200, y: 600)
		static let pointArray: [Point] = [Point(0, -200, 0), Point(200, 0, 0), Point(0, 0, 200)]
		static var pitch: CGFloat = 0.2
		static var yaw: CGFloat = -0.6
		static var roll: CGFloat = 0.1
	}
	
	struct Point {
		var x: CGFloat = 0
		var y: CGFloat = 0
		var z: CGFloat = 0
		
		init(_ x: CGFloat = 0, _ y: CGFloat = 0, _ z: CGFloat = 0) {
			self.x = x
			self.y = y
			self.z = z
		}
		
		func getCGPoint() -> CGPoint {
			return CGPoint(x: x, y: y)
		}
	}
	
	private func rotatePoint(point: Point, pitch: CGFloat, yaw: CGFloat, roll: CGFloat) -> Point {
		
		var pointRoll = Point()
		pointRoll.x = point.x * cos(roll) - point.y * sin(roll)
		pointRoll.y = point.x * sin(roll) + point.y * cos(roll)
		pointRoll.z = point.z
		
		var pointYaw = Point()
		pointYaw.x = pointRoll.x * cos(yaw) + pointRoll.z * sin(yaw)
		pointYaw.y = pointRoll.y
		pointYaw.z = -pointRoll.x * sin(yaw) + pointRoll.z * cos(yaw)
		
		var pointPitch = Point()
		pointPitch.x = pointYaw.x
		pointPitch.y = pointYaw.y * cos(pitch) - pointYaw.z * sin(pitch)
		pointPitch.z = pointYaw.y * sin(pitch) + pointYaw.z * cos(pitch)
		
		return pointPitch
	}
	
	private func rotatePointArray(points: [Point], pitch: CGFloat, yaw: CGFloat, roll: CGFloat) -> [Point] {
		var rotatedPoints = [Point]()
		for p in points {
			let rotatedPoint = rotatePoint(point: p, pitch: pitch, yaw: yaw, roll: roll)
			rotatedPoints.append(rotatedPoint)
		}
		return rotatedPoints
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
		let rotatedArray = rotatePointArray(points: Constants.pointArray, pitch: Constants.pitch, yaw: Constants.yaw, roll: Constants.roll)
		let array = moveArrayToOrigin(points: rotatedArray, origin: Constants.origin2)
		for p in array {
			path.move(to: Constants.origin2)
			path.addLine(to: p)
		}
		path.lineWidth = 3.0
		UIColor.black.set()
		path.stroke()
		if CoordinateSystem.tapPressed {
			self.draw(rect)
			CoordinateSystem.tapPressed = false
		}
    }
}
