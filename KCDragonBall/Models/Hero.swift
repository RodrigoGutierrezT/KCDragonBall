//
//  Hero.swift
//  KCDragonBall
//
//  Created by Rodrigo on 24-09-24.
//

import Foundation

struct Hero: Codable, Hashable {
    let description: String
    let name: String
    let favorite: Bool
    let photo: String
    let id: String
}

extension Hero {
    var imageURL: URL? {
        URL(string: photo)
    }
}
