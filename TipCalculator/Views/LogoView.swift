//
//  LogoView.swift
//  TipCalculator
//
//  Created by Zhanerke Ussen on 18/01/2025.
//

import UIKit

class LogoView: UIView {
    private let imageView: UIImageView = {
        let imageView = UIImageView(image: .init(named: "icCalculatorBW"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let topLabel: UILabel = {
        let label = UILabel()
        let text = NSMutableAttributedString(string: "Mr TIP", attributes: [
            .font: ThemeFont.demiBold(of: 16)
        ])
        text.setAttributes([.font: ThemeFont.bold(ofSize: 24)], range: NSMakeRange(3, 3))
        label.attributedText = text
        return label
    }()
    
    private let bottomLabel: UILabel = {
        let label = LabelFactory.build(text: "Calculator",
                                       font: ThemeFont.demiBold(of: 20),
                                       textAlignment: .left)
        
        return label
    }()
    
    private lazy var stackViewH: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imageView, stackViewV])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var stackViewV: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [topLabel, bottomLabel])
        stackView.axis = .vertical
        stackView.spacing = -4
        return stackView
    }()
    
    init() {
        super.init(frame: .zero)
        accessibilityIdentifier = ScreenIdentifier.LogoView.logoView.rawValue
        layout()
    }
    
    
    private func layout() {
        addSubview(stackViewH)
        stackViewH.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        imageView.snp.makeConstraints {
            $0.height.equalTo(imageView.snp.width)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
