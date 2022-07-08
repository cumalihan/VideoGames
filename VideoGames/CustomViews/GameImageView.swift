//
//  GameImageView.swift
//  VideoGames
//
//  Created by Cumali Han Ünlü on 7.07.2022.
//

import UIKit

class GameImageView: UIImageView {
    
    let placeholderImage = UIImage(named: "placeholder")!

   
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
        
    }

}
