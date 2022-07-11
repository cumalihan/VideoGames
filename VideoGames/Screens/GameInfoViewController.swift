//
//  GameInfoViewController.swift
//  VideoGames
//
//  Created by Cumali Han Ünlü on 9.07.2022.
//

import UIKit

class GameInfoViewController: UIViewController, UIScrollViewDelegate {
    
    var name: String!
    var id: Int!
    
    let scrollView = CustomScrollView()
    let contentView = ContainerView()
    let gameNameLabel = TitleLabel(textAlignment: .left, fontSize: 24)
    let imageView = GameInfoImageView(frame: .zero)
    let descriptionLabel = DescriptionLabel(fontSize: 18)
    let metacriticLabel = SecondaryLabel(fontSize: 22)
    let releasedLabel = SecondaryLabel(fontSize: 22)
    
    var gameInfo = GameInfo()
    weak var delegate: GameInfoVCDelegate!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getGameInfo()
        configureViewController()
        getUI()
    }
    
    
    func getGameInfo() {
        NetworkManager.shared.getGameInfo(for: id) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let game):
                DispatchQueue.main.async {
                    self.configureUIElements(with: game)
                }
              
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func configureViewController(){
        let addFavorite = UIBarButtonItem(image: UIImage(systemName: SFSymbols.like),style: .plain, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addFavorite
        view.backgroundColor = .systemBackground
        
    }
    func configureUIElements(with game: GameInfo) {
        
        self.gameNameLabel.text = game.name
        self.descriptionLabel.text = game.description?.trimHTMLTags()
        self.releasedLabel.text = game.released!.convertToDisplayFormat()
        self.metacriticLabel.text = "Metacritic: \(String(describing: game.metacritic ?? 0))"
        
        NetworkManager.shared.downloadImage(from: game.backgroundImage ?? "placeholder") { [weak self] image in
            guard let self = self else {return}
            
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
    }
    
    func getUI() {
        view.addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        contentView.addSubview(imageView)
        contentView.addSubview(gameNameLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(releasedLabel)
        contentView.addSubview(metacriticLabel)

 
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            imageView.heightAnchor.constraint(equalToConstant: 300),
            
            
            gameNameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            gameNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            gameNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            gameNameLabel.heightAnchor.constraint(equalToConstant: 28),
            
            releasedLabel.topAnchor.constraint(equalTo: gameNameLabel.bottomAnchor , constant: 2),
            releasedLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            releasedLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            releasedLabel.heightAnchor.constraint(equalToConstant: 25),
            
            metacriticLabel.topAnchor.constraint(equalTo: releasedLabel.bottomAnchor , constant: 2),
            metacriticLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            metacriticLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            metacriticLabel.heightAnchor.constraint(equalToConstant: 25),
            
            descriptionLabel.topAnchor.constraint(equalTo: metacriticLabel.bottomAnchor, constant: 5),
            descriptionLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            descriptionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            
            
        ])
        
    }
    @objc func addButtonTapped() {
        
        NetworkManager.shared.getGameInfo(for: id) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let game):
                let favorite = ResultGame(id: game.id!, name: game.name!, released: game.released!, backgroundImage: game.backgroundImage!, rating: game.rating!)
                
                PersistenceMangaer.updateWith(favorite: favorite, actionType: .add) { [weak self] error in
                    guard let self = self else { return }

                    guard let error = error else {
                        self.presentAlertOnMainThread(title: "Succes!", message: "You have succesfully favorited this game.", buttonTitle:"Ok")
                        return
                    }

                    self.presentAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
                }
            case .failure(let error):
                self.presentAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }

}
