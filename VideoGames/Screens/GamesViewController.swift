//
//  GamesViewController.swift
//  VideoGames
//
//  Created by Cumali Han Ünlü on 7.07.2022.
//

import UIKit

protocol GameInfoVCDelegate: class {
    func didRequestGame(for game: String)
}


class GamesViewController: UIViewController {

    enum Section {
        case main
    }

    var games: [ResultGame] = []
    var filteredGames: [ResultGame] = []
    var isSearching = false
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, ResultGame>!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureViewController()
        configureSearchController()
        configureCollectionView()
        configureDataSource()
        getGames()
        
    }
    
    func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search Games"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFloweLayout(in: view))
        collectionView.delegate = self
        collectionView.register(GameCell.self, forCellWithReuseIdentifier: GameCell.reuseID)
        view.addSubview(collectionView)

    }
    
    func getGames() {
        NetworkManager.shared.getGames() { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let games):
                self.games = games.results
                self.updateData(on: self.games)
               
            case .failure(let error):
                print(error)
                break
                
            }
        }
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, ResultGame>(collectionView: collectionView, cellProvider: { collectionView, indexPath, game -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameCell.reuseID, for: indexPath)
             as! GameCell
            cell.set(game: game)
            return cell
            
        })
    }
    
    func updateData(on games: [ResultGame]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, ResultGame>()
        snapshot.appendSections([.main])
        snapshot.appendItems(games)
        
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
        
    }

}

extension GamesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray = isSearching ? filteredGames : games
        let game = activeArray[indexPath.item]
        
        let destVC = GameInfoViewController()
        destVC.name = game.name
        destVC.id = game.id
        
        let navController = UINavigationController(rootViewController: destVC)
        navigationController?.pushViewController(destVC, animated: true)
    }
  
}


extension GamesViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
        isSearching = true
        filteredGames = games.filter { $0.name.lowercased().contains(filter.lowercased())}
        
        if (self.filteredGames.count == 0) {
            self.collectionView.setEmptyMessage("Sorry, we couldn't find\n \(searchController.searchBar.text ?? "")")
        } else {
            self.collectionView.restore()
        }
        updateData(on: filteredGames)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        self.collectionView.restore()
        updateData(on: games)
    }
}


