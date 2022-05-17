//
//  Alertable.swift
//  Zemoga
//
//  Created by darius vallejo on 5/16/22.
//

import Foundation
import UIKit

protocol Alertable {
    func confirmAlert(title: String, message: String, confirmHandler: ((UIAlertAction) -> Void)?)
}

extension Alertable where Self: UIViewController {
    func confirmAlert(title: String, message: String, confirmHandler: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Confirm", style: .destructive) { [weak self] action in
            confirmHandler?(action)
            self?.navigationController?.popViewController(animated: true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            alert.dismiss(animated: true)
        }
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
}
