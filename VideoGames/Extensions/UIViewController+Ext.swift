//
//  UIViewController+Ext.swift
//  VideoGames
//
//  Created by Cumali Han Ünlü on 10.07.2022.
//

import UIKit


fileprivate var containerView: UIView!

extension UIViewController {
    
   func presentAlertOnMainThread(title: String, message: String, buttonTitle: String) {
       DispatchQueue.main.async {
           let alertVC = AlertViewController(title: title, message: message, buttonTitle: buttonTitle)
           alertVC.modalPresentationStyle = .overFullScreen
           alertVC.modalTransitionStyle = .crossDissolve
           self.present(alertVC, animated: true)
       }
    }
    
    func showEmptyStateView(with message: String, in view: UIView) {
        let emptyStateView = EmptyStateView(message: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
        
    }
}

