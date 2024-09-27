//
//  HeroTableViewCell.swift
//  KCDragonBall
//
//  Created by Rodrigo on 26-09-24.
//

import UIKit

final class HeroTableViewCell: UITableViewCell {
    
    // MARK: - Identifier
    static let identifier = String(describing: HeroTableViewCell.self)
    
    // MARK: - Outlets
    @IBOutlet weak var heroImageView: UIImageView!
    @IBOutlet weak var heroLabel: UILabel!
    
    // MARK: - Configuration
    func configure(with hero: Hero) {
        heroLabel.text = hero.name
        
        guard let imageURL = hero.imageURL else {
            return
        }
        heroImageView.setImage(url: imageURL)
    }
    
}
