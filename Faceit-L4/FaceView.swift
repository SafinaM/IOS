//
//  FaceView.swift
//  Faceit-L4
//
//  Created by LinuxPlus on 1/26/18.
//  Copyright © 2018 Stanford Uneversity. All rights reserved.
//

import UIKit

@IBDesignable
class FaceView: UIView, BrainDelegate {
	
	override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	
	var screenSize: CGSize?
	let screenWidth = UIScreen.main.bounds.size.width
	let screenHeight = UIScreen.main.bounds.size.height
	
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
	
	static let nCells: Int = 4
	
	var touchPoint: CGPoint = CGPoint()
	
	private var delta: CGFloat = 0
	
	var rects: [UIBezierPath] = [UIBezierPath]()
	
	let brain: Brain = Brain(dim: 4)
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
	
	private func pathForCell(cell: Cell) -> UIBezierPath
	{
		let rect = cell.rect
		let path = UIBezierPath(rect: cell.rect)
		drawMyText(myText: cell.name, textColor: color, FontName: "Helvetica", FontSize: rect.height * 0.7 , inRect: rect)
		path.lineWidth = lineWidth
		return path
	}
	
	
    override func draw(_ rect: CGRect) {
		color.set()

		for i in 0..<FaceView.nCells {
			for j in 0..<FaceView.nCells {
				//				let cell: Cell = brain[i,j]
				if brain[i,j].contains(point: touchPoint) {
					print("MSD BEFOR brain[\(i), \(j)] contains point \(touchPoint)")
					touchPoint = CGPoint()
					print("MSD BEFOR brain[\(brain.iActive), \(brain.jActive)] is active")
					print("MSD brain[\(brain.iEmpty), \(brain.jEmpty)] is empty")
					brain.setActive(i: i, j: j)
					print("MSD AFTER brain[\(brain.iActive), \(brain.jActive)] is active")
					
					brain.swapActiveAndEmpty()
					
					print("MSD AFTER setting brain[\(brain.iEmpty), \(brain.jEmpty)] is empty")
				}
				
			}
		}
		for i in 0..<FaceView.nCells {
			for j in 0..<FaceView.nCells {
				if !brain[i,j].empty {
					pathForCell(cell:
						brain[i,j]).stroke()
				}
			}
		}
		if brain.finished() {
			print("MSD It is done!!!")
		}
	}
	
	func getCenter() -> CGPoint {
		return skullCenter
	}
	
}
