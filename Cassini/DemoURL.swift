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
			"Cassini" : "https://www.space.irfu.se/cassini/cassini.gif",
			"Earth" : "https://media-exp2.licdn.com/mpr/mpr/shrinknp_674_240/p/8/005/06f/25d/1d60a51.jpg",
			"Saturn" : "https://i.ytimg.com/vi/LJktwIxAW2I/hqdefault.jpg"
		]
		var urls = Dictionary<String,URL>()
		for (key, value) in NASAURLStrings {
			urls[key] = URL(string: value)
		}
		return urls
	}()
}
