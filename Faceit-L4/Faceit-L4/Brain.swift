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
	static var dimSize: Int = 4
	static let last: Int = Brain.dimSize * Brain.dimSize
	static let dist: CGFloat = 10.0
	static var step: CGFloat = -1
	static let origin: CGPoint = CGPoint(x: 10, y: 30)
	static var side: CGFloat = 80
	
	var wasChanged: Bool = false
	
	var iEmpty: Int = -1
	var jEmpty: Int = -1
	
	var iActive: Int = -1
	var jActive: Int = -1
	
	var arr = Array2D<Cell>(columns: dimSize, rows: dimSize, defaultValue: Cell())
	
//	call only one time
	init(dim: Int, superViewSize: CGSize) {
		Brain.step = (superViewSize.width - 40) / 4
		Brain.dimSize = dim
		Brain.side = Brain.step - Brain.dist
		setBrain(superViewSize: superViewSize, isPortrait: true)
		
		setLastAsEmpty()
		shuffle()
		while (!checkSolving()) {
			shuffle()
			print("MSD checkSolving = ", checkSolving())
		}
	}
	
	func setBrain(superViewSize: CGSize, isPortrait: Bool) {
		let width = min(superViewSize.width, superViewSize.height)
		let height = max(superViewSize.width, superViewSize.height)
		print("MSD origin \(width), \(height)")
		// let - is right but it can be corrected later
		var or: CGPoint = Brain.origin
		
//		if isPortrait {
//			or = CGPoint(x: superViewSize.width / 2, y: superViewSize.height / 2 )
//		} else {
//			or = CGPoint(x: superViewSize.height / 2, y: superViewSize.width / 2)
//		}
		
		var number = 1
		for i in 0..<Brain.dimSize {
			for j in 0..<Brain.dimSize {
				var x: CGFloat = CGFloat()
				var y: CGFloat = CGFloat()
				if isPortrait {
					x = or.x + CGFloat(j) * Brain.step
					y = or.y + CGFloat(i) * Brain.step
				} else {
					x = or.x + CGFloat(j) * Brain.step
					y = or.y + CGFloat(i) * Brain.step
				}
				
				let rect: CGRect = CGRect(x: x, y: y, width: Brain.side, height: Brain.side)
				let cell = Cell(rect: rect, active: false, name: String(number), number: number, empty: false)
				arr[i, j] = cell
				number += 1
			}
		}
	}
	
//	should be deprecated code
	func reSetBrain(superViewSize: CGSize, isPortrait: Bool) {
		let width = min(superViewSize.width, superViewSize.height)
		let height = max(superViewSize.width, superViewSize.height)
		print("MSD origin \(width), \(height)")
		var or: CGPoint = Brain.origin
		
		if isPortrait {
			or = CGPoint(x: superViewSize.width / 2, y: superViewSize.height / 2 )
		} else {
			or = CGPoint(x: superViewSize.height / 2, y: superViewSize.width / 2)
		}
		
		var number = 1
		for i in 0..<Brain.dimSize {
			for j in 0..<Brain.dimSize {
				var x: CGFloat = CGFloat()
				var y: CGFloat = CGFloat()
				if isPortrait {
					x = or.x + CGFloat(j) * Brain.step
					y = or.y + CGFloat(i) * Brain.step
				} else {
					x = or.x + CGFloat(j) * Brain.step
					y = or.y + CGFloat(i) * Brain.step
				}
				
				let rect: CGRect = CGRect(x: x, y: y, width: Brain.side, height: Brain.side)
				let temp_cell = arr[i, j]
				let cell = Cell(rect: rect, active: temp_cell.active, name: temp_cell.name, number: temp_cell.number, empty: temp_cell.empty)
				arr[i, j] = cell
				number += 1
				print(arr[i, j])
			}
		}
	}

	
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
	
	func finished() -> Bool {
		var k: Int = 0
		for i in 0..<Brain.dimSize {
			for j in 0..<Brain.dimSize {
				if arr[i, j].name != String(k+1) {
					return false
				}
				k += 1
			}
		}
		return true
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
		setEmpty(i: Brain.dimSize-1, j: Brain.dimSize-1)
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
	
	private func shuffle() -> Void {
		let max: UInt32 = UInt32(Brain.last-1)
		var k: UInt32 = 0
		while(k != max) {
			let randomNum: UInt32 = arc4random_uniform(max-k) + k
			Swift.swap(&arr[Int(k)].name, &arr[Int(randomNum)].name)
			k += 1
		}
	}
	
	private func checkSolving() -> Bool {
		var N: Int = 0;
		for i in 0..<Brain.last {
			for j in i+1..<Brain.last {
				if Int(arr[i].name)! > Int(arr[j].name)!{
					
					N += 1
				}
			}
		}
		return (N + iEmpty + 1) % 2 == 0
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


