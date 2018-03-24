//
//  ExpressionEditorViewController.swift
//  Faceit
//
//  Created by LinuxPlus on 3/24/18.
//  Copyright © 2018 MarinaS. All rights reserved.
//

import UIKit

class ExpressionEditorViewController: UITableViewController, UITextFieldDelegate
{
	var name: String {
		return nameTextField?.text ?? ""
	}
	
	@IBAction func updateMouth(_ sender: Any) {
		print("MSD, mouth", faceViewController?.expression.mouth ?? "", expression.mouth)
	}
	@IBAction func updateFace() {
		print("\(name) = \(expression)")
		faceViewController?.expression = expression
	}
	private let eyeChoices = [FacialExpression.Eyes.open, .closed, .squinting]
	private let mouthChoices = [FacialExpression.Mouth.frown, .smirk, .neutral, .grin, .smile]
	
	var expression: FacialExpression {
		return FacialExpression (
			eyes: eyeChoices[eyeControl?.selectedSegmentIndex ?? 0],
			mouth: mouthChoices[mouthControl?.selectedSegmentIndex ?? 0]
		)
	}
	
	@IBOutlet weak var nameTextField: UITextField!
	@IBOutlet weak var eyeControl: UISegmentedControl!
	@IBOutlet weak var mouthControl: UISegmentedControl!
	
	private var faceViewController: BlinkingFaceViewController?
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "Embed Face" {
			faceViewController = segue.destination as? BlinkingFaceViewController
			faceViewController?.expression = expression
		}
	}
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		if indexPath.row == 1 {
			return tableView.bounds.size.width
		} else {
			return super.tableView(tableView, heightForRowAt: indexPath)
		}
	}
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
	}
	
	@IBAction func cancel(_ sender: UIBarButtonItem) {
		presentingViewController?.dismiss(animated: true)
	}
}
