//
// DemoURL.swift
//
// Created by CS193p Instructor.
// Copyright (c) 2017 Stanford University. All rights reserved.
//
import Foundation
struct DemoURL
{
	static let stanford = URL(string: "https://media-exp2.licdn.com/mpr/mpr/shrinknp_674_240/p/8/005/06f/25d/1d60a51.jpg")
	static var NASA: Dictionary<String, URL> = {
		let NASAURLStrings = [
			"Cassini" : "http://www.jpl.nasa.gov/images/cassini/20090202/pia03883-full.jpg",
			"Earth" : "https://media-exp2.licdn.com/mpr/mpr/shrinknp_674_240/p/8/005/06f/25d/1d60a51.jpg",
			"Saturn" : "http://www.nasa.gov/sites/default/files/saturn_collage.jpg"
		]
		var urls = Dictionary<String,URL>()
		for (key, value) in NASAURLStrings {
			urls[key] = URL(string: value)
		}
		return urls
	}()
}
