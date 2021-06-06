//
//  GenericComponent.swift
//  newsApp
//
//  Created by Alperen Kişi on 01/06/2021.
//

import UIKit

class GenericComponents {
    static let unknownImageUrlLink = "https://nebosan.com.tr/wp-content/uploads/2018/06/no-image.jpg"
}

extension FeedViewController {
    
    func showError(alertTitle: String, alertSubtitle: String, okButtonTitle: String) {
        let alert = UIAlertController(title: alertTitle, message: alertSubtitle, preferredStyle: .alert)
        let okButton = UIAlertAction(title: okButtonTitle, style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
    }
}
