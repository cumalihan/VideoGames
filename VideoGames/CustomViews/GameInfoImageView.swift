//
//  GameInfoImageView.swift
//  VideoGames
//
//  Created by Cumali Han Ünlü on 9.07.2022.
//

import UIKit


class GameInfoImageView: UIImageView {
    
    let placeholderImage = UIImage(named: "placeholder")!

   
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 5
        clipsToBounds = true
        contentMode = .scaleAspectFill
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
        
    }

}
