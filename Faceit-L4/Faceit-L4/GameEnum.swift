//
//  File.swift
//  Faceit-L4
//
//  Created by MarinaS on 03/03/18.
//  Copyright © 2018 MarinaS. All rights reserved.
//

import Foundation

struct GameEnum {
	enum Games: Int {
		case restart
		case saved
	}
	
	var game: GameEnum {
		return GameEnum(games: self.games)
	}
	
	let games: Games
	
	
	
}
