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
	
	mutating func setEmpty() -> Void {
		empty = true
	}
	
	mutating func resetActive() -> Void {
		active = false
	}
	
	mutating func resetEmpty() -> Void {
		empty = false
	}
}

class Brain
{
	static let size: Int = 4
	static let side: CGFloat = 40.0
	static let step: CGFloat = 50
	static let origin: CGPoint = CGPoint(x: 200, y: 200)
	
	var iEmpty: Int = -1
	var jEmpty: Int = -1
	
	var iActive: Int = -1
	var jActive: Int = -1
	
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
//		setActive(i: 2, j: 3)
		setLastAsEmpty()
		shuffle(n: 10)
	}
	
//	func getCell(i: Int, j: Int) -> Cell {
//		
//		return arr[i,j]
//	}
	
	func setActive(i: Int, j: Int) -> Void {

		if i == iEmpty, j == jEmpty {
			return
		}
		if verifyOfEmptyNeighbours(i: i, j: j) {
			setActiveIndecies(i: i, j: j)
			arr[i,j].setActive()
			arr[i,j].resetEmpty()
		}
		
	}
	
	private func verifyOfEmptyNeighbours(i: Int, j: Int) -> Bool {
		
		if i == iEmpty + 1, j == jEmpty {
			return true
		}
		else if i == iEmpty - 1, j == jEmpty {
			return true
		}
		else if i == iEmpty, j == jEmpty + 1 {
			return true
		}
		else if i == iEmpty, j == jEmpty - 1 {
			return true
		}
		return false
	}
	
	func setEmpty(i: Int, j: Int) -> Void {
	
		setEmptyIndecies(i: i, j: j)
		arr[i,j].setEmpty()
		arr[i,j].resetActive()
	}
	
	private func setActiveIndecies(i: Int, j: Int) -> Void {
		
		iActive = i
		jActive = j
	}
	
	private func resetActiveIndecies() -> Void {
		
		iActive = -1
		jActive = -1
	}
	
	private func setEmptyIndecies(i: Int, j: Int) -> Void {
		
		iEmpty = i
		jEmpty = j
	}
	
	private func setLastAsEmpty() -> Void {
		setEmpty(i: Brain.size-1, j: Brain.size-1)
	}
	
	
	func swapActiveAndEmpty() -> Void {
		
		if iActive != -1, jActive != -1, iEmpty != -1, jEmpty != -1 {
			Swift.swap(&arr[iActive, jActive].empty, &arr[iEmpty, jEmpty].empty)
			Swift.swap(&arr[iActive, jActive].name, &arr[iEmpty, jEmpty].name)
			setEmptyIndecies(i: iActive, j: jActive)
		}
	}
	
	subscript(i: Int, j: Int) -> Cell {
		get {
			return arr[i,j]
		}
		set {
			arr[i,j] = newValue
		}
	}
	
	private func shuffle(n: Int) -> Void {
//		var times: Int = n
		let max: UInt32 = UInt32(Brain.size * Brain.size)
		var k: UInt32 = 0
		while(k != max) {
			let randomNum:UInt32 = arc4random_uniform(max-k) + k;
			Swift.swap(&arr[Int(k)].name, &arr[Int(randomNum)].name)
			k += 1
		}
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
	
	subscript(index: Int) -> T {
		get {
			return matrix[index]
		}
		set {
			matrix[index] = newValue
		}
	}
	
	func columnCount() -> Int {
		return self.columns
	}
	
	func rowCount() -> Int {
		return self.rows
	}

}

