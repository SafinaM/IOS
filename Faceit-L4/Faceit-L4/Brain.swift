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
	static var size = 4
	var arr = Array2D<Cell>(columns: size, rows: size, defaultValue: Cell())
	
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
