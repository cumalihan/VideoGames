//
//  UICollectionView+Ext.swift
//  VideoGames
//
//  Created by Cumali Han Ünlü on 12.07.2022.
//

import UIKit

extension UICollectionView {

    func setEmptyMessage(_ message: String) {
        let messageLabel = MessageLabel(fontSize: 25)
        messageLabel.text = message
        self.backgroundView = messageLabel;
    }

    func restore() {
        self.backgroundView = nil
    }
}




