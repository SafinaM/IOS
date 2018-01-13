//
//  ViewController.swift
//  Calculator
//
//  Created by LinuxPlus on 11/15/17.
//  Copyright © 2017 MarinaS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	
	@IBOutlet weak var display: UILabel!
	@IBOutlet var history: UILabel!
	
	var userIsInTheMiddleOfTyping = false
	var inTheMiddleOperationSequence = true
	
	@IBAction func touchDigit(_ sender: UIButton) {
		let digit = sender.currentTitle!
		let pointPressed = (display.text?.contains("."))!
		if pointPressed && digit == "." {
			return
		}
		if digit == "⌫" && !display.text!.isEmpty {
			display.text = String(display.text!.characters.dropLast())
			if display.text!.isEmpty{
				displayValue = 0
				userIsInTheMiddleOfTyping = false
			}
			return
		}
		
		
		if userIsInTheMiddleOfTyping {
			let textCurrentlyDisplay = display.text!
			display.text = textCurrentlyDisplay + digit
		} else {
			display.text = digit
			userIsInTheMiddleOfTyping = true
		}
		
	}
	
	var displayValue: Double {
		get {
			return Double(display.text!)!
		}
		set {
			display.text = formatter.string(from: NSNumber(value:newValue))
		}
	}
	
	private var brain: CalculatorBrain = CalculatorBrain()
	
	@IBAction func performOperation(_ sender: UIButton) {
		if userIsInTheMiddleOfTyping {
			brain.setOperand(displayValue)
			userIsInTheMiddleOfTyping = false
		}
		
		if let mathematicalSymbol = sender.currentTitle {
		
			if mathematicalSymbol == "=" {
				inTheMiddleOperationSequence = false
			}
			else {
				inTheMiddleOperationSequence = true
			}
			if inTheMiddleOperationSequence {
				brain.performOperation("=")
			}
			
			brain.performOperation(mathematicalSymbol)
			
		}
		displayResult()
		
	}
	
	private func displayResult() {
		if let result = brain.result {
			displayValue = result
		}
		if let description = brain.description {
			history.text = description + ( brain.resultIsPending ? " ..." : " =")
			
		}
	}
	
	
	@IBAction func clear_all(_ sender: UIButton) {
		brain.clear()
		displayValue = 0
		history.text = " "
		userIsInTheMiddleOfTyping = false
	}

}

