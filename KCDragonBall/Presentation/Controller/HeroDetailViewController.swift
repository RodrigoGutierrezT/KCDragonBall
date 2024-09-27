//
//  HeroDetailViewController.swift
//  KCDragonBall
//
//  Created by Rodrigo on 27-09-24.
//

import UIKit

class HeroDetailViewController: UIViewController {
    
    @IBOutlet weak var heroImageView: UIImageView!
    @IBOutlet weak var heroNameLabel: UILabel!
    @IBOutlet weak var heroTextView: UITextView!
    
    private let hero: Hero
    
    init(hero: Hero) {
        self.hero = hero
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    @IBAction func didTapButton(_ sender: UIButton) {
        navigationController?.show(TransformationListViewController(hero: hero), sender: nil)
    }
}

private extension HeroDetailViewController {
    func configureView() {
        heroNameLabel.text = hero.name
        heroTextView.text = hero.description
        
        guard let imgURL = hero.imageURL else {
            return
        }
        
        heroImageView.setImage(url: imgURL)
    }
}
