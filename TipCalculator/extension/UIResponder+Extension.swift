//
//  UIResponder+Extension.swift
//  TipCalculator
//
//  Created by Zhanerke Ussen on 20/01/2025.
//

import UIKit

extension UIResponder {
    var parentViewController: UIViewController? {
        return next as? UIViewController ?? next?.parentViewController
    }
}
