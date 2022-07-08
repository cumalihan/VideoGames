//
//  GamesViewController.swift
//  VideoGames
//
//  Created by Cumali Han Ünlü on 7.07.2022.
//

import UIKit

class GamesViewController: UIViewController {
    
    enum Section {
        case main
    }
    
    
    var game: [ResultGame] = []
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
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFloweLayout(in: view))
        view.addSubview(collectionView)
        collectionView.register(GameCell.self, forCellWithReuseIdentifier: GameCell.reuseID)
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
    }
    
    func getGames() {
        NetworkManager.shared.getGames() { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let game):
                print(game)
                self.game = game.results
                self.updateData(on: self.game)
               
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
    
    func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search Games"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
    }
    

}

extension GamesViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
        isSearching = true
        filteredGames = game.filter { $0.name.lowercased().contains(filter.lowercased())}
        updateData(on: filteredGames)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
       isSearching = false
       updateData(on: game)
    }
}

