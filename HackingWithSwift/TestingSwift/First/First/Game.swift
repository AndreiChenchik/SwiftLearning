//
//  Game.swift
//  First
//
//  Created by Andrei Chenchik on 16/6/21.
//

import Foundation

enum GameError: LocalizedError {
    case notPurchased
    case notInstalled
    case parentalControlsDisallowed
}

extension LocalizedError {
    var errorDescription: String? {
        return "\(self)"
    }
}

struct Game {
    let name: String

    func play() throws {
        if name == "BioBlitz" {
            throw GameError.notPurchased
        } else if name == "Blastazap" {
            throw GameError.notInstalled
        } else if name == "Dead Storm Rising" {
            throw GameError.parentalControlsDisallowed
        } else {
            print("\(name) is OK to play!")
        }
    }
}
