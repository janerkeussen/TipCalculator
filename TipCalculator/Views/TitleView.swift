//
//  TitleView.swift
//  TipCalculator
//
//  Created by Zhanerke Ussen on 18/01/2025.
//

import UIKit

class TitleView: UIView {
    private let topLabel: UILabel = {
        let label = LabelFactory.build(text: "Top",
                                       font: ThemeFont.bold(of: 18),
                                       textAlignment: .left)
        return label
    }()
    
    private let bottomLabel: UILabel = {
        
        let label = LabelFactory.build(text: "Bottom",
                                       font: ThemeFont.regular(of: 16),
                                       textAlignment: .left)
        
        return label
    }()
    
    private let topSpacerView = UIView()
    private let bottomSpacerView = UIView()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            topSpacerView,
            topLabel,
            bottomLabel,
            bottomSpacerView
        ])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = -4
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func layout() {
        addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        topSpacerView.snp.makeConstraints { make in
            make.height.equalTo(bottomSpacerView.snp.height)
        }
    }
    
    func configure(topText: String, bottomText: String) {
        topLabel.text = topText
        bottomLabel.text = bottomText
    }
}
