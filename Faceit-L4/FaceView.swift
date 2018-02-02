//
//  FaceView.swift
//  Faceit-L4
//
//  Created by LinuxPlus on 1/26/18.
//  Copyright © 2018 Stanford Uneversity. All rights reserved.
//

import UIKit

@IBDesignable
class FaceView: UIView {
	
	@IBInspectable
	var scale: CGFloat = 0.5 {didSet { setNeedsDisplay() } }
	
	@IBInspectable
	var skullRadius: CGFloat {
		return min(bounds.size.width, bounds.size.height) / 8 * scale
	}
	
	
	@IBInspectable
	var skullCenter: CGPoint {
		return CGPoint(x: bounds.midX, y: bounds.midY)
	}
	
	@IBInspectable
	var lineWidth: CGFloat = 5.0 {didSet { setNeedsDisplay() } }
	
	@IBInspectable
	var color: UIColor = .green {didSet { setNeedsDisplay() } }
	
	@IBInspectable
	var direction: Movement.Direction = .left {didSet { setNeedsDisplay() } }
	
	var touchPoint: CGPoint = CGPoint()
	
	private var delta: CGFloat = 0
	
	var rects: [UIBezierPath] = [UIBezierPath]()
	
	func changeScale(byReactingTo pinchRecognezer: UIPinchGestureRecognizer)
	{

		switch pinchRecognezer.state {
		case .changed, .ended:
			scale *= pinchRecognezer.scale
			pinchRecognezer.scale = 1
			print("scale = \(scale)")
		default:
			break
		}
	}

	func drawMyText(myText:String, textColor: UIColor, FontName: String, FontSize: CGFloat, inRect: CGRect){
		
		let textFont = UIFont(name: FontName, size: FontSize)!
		let textFontAttributes = [
			NSFontAttributeName: textFont,
			NSForegroundColorAttributeName: textColor,
			] as [String : Any]
		
		myText.draw(in: inRect, withAttributes: textFontAttributes)
	}
	
	private func pathForSkull(cell: Cell) -> UIBezierPath
	{
		let rect = cell.rect
		let path = UIBezierPath(rect: cell.rect)
		drawMyText(myText: cell.name, textColor: color, FontName: "Helvetica", FontSize: rect.height * 0.7 , inRect: rect)
		path.lineWidth = lineWidth
		return path
	}
	
	
    override func draw(_ rect: CGRect) {
		color.set()
		delta = (direction == .left) ? -skullRadius: skullRadius
		let brain: Brain = Brain(dim: 4)
		for index in 0...2 {
//			let number = index + 1
//			let x: CGFloat = skullCenter.x + CGFloat(index * 50)
//			var rect = CGRect(x: x, y: skullCenter.y, width: skullRadius, height: skullRadius)
//			var cell = Cell(rect: rect, active: false, name: String(number), number: number, empty: false)
//			if cell.contains(point: touchPoint) {
//				touchPoint = CGPoint()
//				cell.setActive()
//				rect = CGRect(x: x + delta, y: skullCenter.y, width: skullRadius, height: skullRadius)
//				cell = Cell(rect: rect, active: false, name: String(number), number: number, empty: false)
//			}
			
//			pathForSkull(cell: cell).stroke()
		}
		for i in 0..<4 {
			for j in 0..<4 {
				let cell: Cell = brain.getCell(i: i, j: j)
				pathForSkull(cell: cell).stroke()
			}
		}
    }
	
}
