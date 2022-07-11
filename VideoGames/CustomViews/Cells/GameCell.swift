//
//  GameCell.swift
//  VideoGames
//
//  Created by Cumali Han Ünlü on 7.07.2022.
//

import UIKit

class GameCell: UICollectionViewCell {
    static let reuseID = "GameCell"
    
    let gameImageView = GameImageView(frame: .zero)
    let gameNameLabel = TitleLabel(textAlignment: .left, fontSize: 22)
    let releasedLabel = SecondaryLabel()
    let ratingsLabel = SecondaryLabel()
    let ratingsImageView = UIImageView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(game: ResultGame) {
        gameNameLabel.text = game.name
        releasedLabel.text = game.released.convertToDisplayFormat()
        ratingsLabel.text = String("★ \(game.rating)")

        NetworkManager.shared.downloadImage(from: game.backgroundImage) { [weak self] image in
            guard let self = self else {return}
            
            DispatchQueue.main.async {
                self.gameImageView.image = image
            }
        }
    }
    
    
    private func configure() {
        addSubview(gameImageView)
        addSubview(gameNameLabel)
        addSubview(releasedLabel)
        addSubview(ratingsLabel)
        addSubview(ratingsImageView)
        
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            gameImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            gameImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            gameImageView.heightAnchor.constraint(equalToConstant: 80),
            gameImageView.widthAnchor.constraint(equalToConstant: 80),
            
            gameNameLabel.topAnchor.constraint(equalTo: self.gameImageView.topAnchor),
            gameNameLabel.leadingAnchor.constraint(equalTo: gameImageView.trailingAnchor, constant: 24),
            gameNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            gameNameLabel.heightAnchor.constraint(equalToConstant: 36),
            
            
            releasedLabel.topAnchor.constraint(equalTo: self.gameNameLabel.bottomAnchor, constant: 2),
            releasedLabel.leadingAnchor.constraint(equalTo: gameImageView.trailingAnchor, constant: 24),
            releasedLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            releasedLabel.heightAnchor.constraint(equalToConstant: 20),
            
            
            ratingsLabel.topAnchor.constraint(equalTo: self.releasedLabel.bottomAnchor, constant: 2),
            ratingsLabel.leadingAnchor.constraint(equalTo: gameImageView.trailingAnchor, constant: 24),
            ratingsLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            ratingsLabel.heightAnchor.constraint(equalToConstant: 20),
            
         
            
            
        ])
    }
    
}

