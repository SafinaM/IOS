//
//  File.swift
//  Faceit-L4
//
//  Created by LinuxPlus on 1/28/18.
//  Copyright © 2018 Stanford Uneversity. All rights reserved.
//

import Foundation
import UIKit

struct Cell
{
	var rect: CGRect = CGRect()
	var active: Bool = false
	var name: String = ""
	var number: Int = 0
	var empty: Bool = true
	func getRect() -> CGRect { return rect }
	
	func contains(point: CGPoint) -> Bool {
		return rect.contains(point)
	}
	
	mutating func setActive() -> Void {
		active = true
	}
}

class Brain
{
	static let size: Int = 4
	static let side: CGFloat = 40.0
	static let step: CGFloat = 50
	static let origin: CGPoint = CGPoint(x: 200, y: 200)
	
	var arr = Array2D<Cell>(columns: size, rows: size, defaultValue: Cell())
	
	init(dim: Int) {
		var number = 1
		for i in 0..<dim {
			for j in 0..<dim {
				let x: CGFloat = Brain.origin.x + CGFloat(j) * Brain.step
				let y: CGFloat = Brain.origin.y + CGFloat(i) * Brain.step
				let rect: CGRect = CGRect(x: x, y: y, width: Brain.side, height: Brain.side)
				let cell = Cell(rect: rect, active: false, name: String(number), number: number, empty: false)
				arr[i, j] = cell
				number += 1
			}
		}
	}
	
	func getCell(i: Int, j: Int) -> Cell {
		
		return arr[i,j]
	}
	
	
}


class Array2D<T> {
	
	var columns: Int
	var rows: Int
	var matrix: [T]
	
	init(columns: Int, rows: Int, defaultValue: T) {
		self.columns = columns
		self.rows = rows
		matrix = Array(repeating: defaultValue, count: columns * rows)
	}
	
	subscript(column: Int, row: Int) -> T {
		get {
			return matrix[columns * row + column]
		}
		set {
			matrix[columns * row + column] = newValue
		}
	}
	
	func columnCount() -> Int {
		return self.columns
	}
	
	func rowCount() -> Int {
		return self.rows
	}
}
