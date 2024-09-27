//
//  TransformationTableViewCell.swift
//  KCDragonBall
//
//  Created by Rodrigo on 27-09-24.
//

import UIKit

class TransformationTableViewCell: UITableViewCell {

    // MARK: - Identifier
    static let identifier = String(describing: TransformationTableViewCell.self)
    
    // MARK: - Outlets
    @IBOutlet weak var transformationImageView: UIImageView!
    @IBOutlet weak var transformationLabel: UILabel!
    
    // MARK: - Configuration
    func configure(with transformation: Transformation) {
        transformationLabel.text = transformation.name
        
        guard let imageURL = transformation.imageURL else {
            return
        }
        transformationImageView.setImage(url: imageURL)
    }
    
}
