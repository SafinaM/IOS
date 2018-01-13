//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by LinuxPlus on 11/17/17.
//  Copyright © 2017 MarinaS. All rights reserved.
//

import Foundation

let formatter:NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.maximumIntegerDigits = 6
    formatter.notANumberSymbol = "Error"
    formatter.groupingSeparator = " "
    formatter.locale = Locale.current
    return formatter
} ()


struct CalculatorBrain {
    

	private var accumulator: Double?
    private var descriptionAccumulator: String?
    
    private enum Operation {
		case nullaryOperation(() -> Double, String)
        case constant(Double)
        case unaryOperation((Double) -> Double, ((String) -> String)?)
        case binaryOperation((Double,Double) -> Double, ((String, String) -> String)?)
        case equals
    }
    
    private var operations: Dictionary<String,Operation> = [
		"R" : Operation.nullaryOperation({Double(arc4random())/Double(UInt32.max)}, "rand()"),
        "π" : Operation.constant(Double.pi),
        "e" : Operation.constant(M_E),
        "√" : Operation.unaryOperation(sqrt, nil),
        "tan" : Operation.unaryOperation(tan, nil),
        "sin" : Operation.unaryOperation(sin, nil),
        "cos" : Operation.unaryOperation(cos, nil),
        "acos" : Operation.unaryOperation(acos, nil),
        "asin" : Operation.unaryOperation(asin, nil),
        "atan" : Operation.unaryOperation(atan, nil),
        "1/x" : Operation.unaryOperation({ 1 / $0 }, {"1/(" + $0 + ")"}),
        "x^2" : Operation.unaryOperation({ $0*$0 }, {"(" + $0 + ")^2"}),
        "±" : Operation.unaryOperation({ -$0 }, nil),
        "x^y" : Operation.binaryOperation(pow, {"(" + $0 + ")" + "^" + $1}),
        "*" : Operation.binaryOperation({ $0 * $1 }, {"(" + $0 + ")" + "*" + $1}),
        "/" : Operation.binaryOperation({ $0 / $1 }, {"(" + $0 + ")" + "/" + $1}),
        "+" : Operation.binaryOperation({ $0 + $1 }, nil),
        "-" : Operation.binaryOperation({ $0 - $1 }, nil),
        "=" : Operation.equals
    ]
    
    var description: String? {
        get {
            if pendingBinaryOperation == nil {
                return descriptionAccumulator
            }
            else {
                return pendingBinaryOperation!.descriptionFunction(
					pendingBinaryOperation!.descriptionOperand, descriptionAccumulator ?? "")
            }
        }
    }
    
    var result: Double? {
        return accumulator
    }
    
    private struct PendingBinaryOperation {
        let function: (Double, Double) -> Double
        let firstOperand: Double
        var descriptionFunction: (String, String) -> String
        var descriptionOperand: String
        
        func perform(with secondOperand: Double) -> Double {
            return function(firstOperand, secondOperand)
        }
        
        func performDescription (with secondOperand: String) -> String {
            return descriptionFunction(descriptionOperand, secondOperand)
        }
    }
    
    private var pendingBinaryOperation: PendingBinaryOperation?
    
    mutating func performOperation(_ symbol: String) {
        
        if let operation = operations[symbol] {
            switch operation {
			case .nullaryOperation(let function, let descriptionValue):
				accumulator = function()
				descriptionAccumulator = descriptionValue
            case .constant(let value):
                accumulator = value
				descriptionAccumulator = symbol

            case .unaryOperation(let function, var descriptionFunction):
                if accumulator != nil {
                    accumulator = function(accumulator!)
                }
				if descriptionFunction == nil {
					descriptionFunction = {symbol + "(" + $0 + ")"}
				}
                descriptionAccumulator = descriptionFunction!(descriptionAccumulator!)
            case .binaryOperation(let function, var descriptionFunction):
                if accumulator != nil {
                    if descriptionFunction == nil {
                        descriptionFunction = {$0 + " " + symbol + " " + $1}
                    }
                    pendingBinaryOperation = PendingBinaryOperation(function: function,
                                                                    firstOperand: accumulator!,
                                                                    descriptionFunction: descriptionFunction!,
                                                                    descriptionOperand: descriptionAccumulator!)
                    accumulator = nil
                    descriptionAccumulator = nil
                }
                
            case .equals:
                performPendingBinaryOperation()

            }
        }
    }
	
	
    private mutating func performPendingBinaryOperation() {
        if pendingBinaryOperation != nil && accumulator != nil {
            accumulator = pendingBinaryOperation!.perform(with: accumulator!)
            
            descriptionAccumulator =
				pendingBinaryOperation!.performDescription(with: descriptionAccumulator!)
            
            pendingBinaryOperation = nil
        }
        
    }
    mutating func setOperand(_ operand: Double) {
        accumulator = operand
        if let value = accumulator {
            descriptionAccumulator = formatter.string(from: NSNumber(value:value)) ?? ""
        }
    }
	
	var resultIsPending: Bool {
		get {
			return pendingBinaryOperation != nil
		}
	}
	
	mutating func clear() {
		accumulator = nil
		pendingBinaryOperation = nil
		descriptionAccumulator = " "
	}

}
