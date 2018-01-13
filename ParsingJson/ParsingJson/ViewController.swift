//
//  ViewController.swift
//  ParsingJson
//
//  Created by LinuxPlus on 1/11/18.
//  Copyright © 2018 MarinaS. All rights reserved.
//

import UIKit

struct WebsiteDescription {
	let name: String
	let description: String
	let courses: [Course]
}

struct Course {
	let id: Int
	let name: String
	let link: String
	let imageUrl: String
	
	init(json: [String: Any]) {
		id = json["id"] as? Int ?? -1
		name = json["name"] as? String ?? ""
		link = json["link"] as? String ?? ""
		imageUrl = json["imageUrl"] as? String ?? ""

	}
}

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		let jsonUrlString = "https://api.letsbuildthatapp.com/jsondecodable/website_description"
		
		guard let url = URL(string: jsonUrlString) else {return}
		
		
		URLSession.shared.dataTask(with: url) {
			(data, response, err) in
			guard let data = data else { return }
			
//			let dataAsString = String(data: data, encoding: .utf8)
//			print(dataAsString)
			
			do {
				
//				Swift 2/3/ObjC
				guard let json = try JSONSerialization.jsonObject(with: data,
								options: .mutableContainers) as? [String: Any] else {return}
				let course = Course(json: json)
				print("name = ", course.name)
			}  catch let jsonErr {
				print("Error serialization json: ", jsonErr)
			}
		}.resume()
			
			
			
			
//		let myCourse = Course(id: 1, name: "my course", link: "some link", imageUrl: "some image url")
//		
//		print(myCourse)
	}
	


}

