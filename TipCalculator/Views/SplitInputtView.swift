//
//  SplitInputtView.swift
//  TipCalculator
//
//  Created by Zhanerke Ussen on 18/01/2025.
//

import UIKit

class SplitInputtView: UIView {
    
    init() {
        super.init(frame: .zero)
        layout()
    }
    
    
    private func layout() {
        backgroundColor = .green
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
