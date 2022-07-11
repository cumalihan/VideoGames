//
//  ScrollView.swift
//  VideoGames
//
//  Created by Cumali Han Ünlü on 11.07.2022.
//

import UIKit

class CustomScrollView: UIScrollView {

  
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .systemBackground
        translatesAutoresizingMaskIntoConstraints = false
        
    }


}
