//
//  Transformation.swift
//  KCDragonBall
//
//  Created by Rodrigo on 25-09-24.
//

import Foundation

struct Transformation: Codable, Hashable {
    let id: String
    let photo: String
    let name: String
    let description: String
}

extension Transformation {
    var imageURL: URL? {
        URL(string: photo)
    }
}
