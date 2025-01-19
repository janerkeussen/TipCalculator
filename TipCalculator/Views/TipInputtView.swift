//
//  TipInputtView.swift
//  TipCalculator
//
//  Created by Zhanerke Ussen on 18/01/2025.
//

import UIKit

class TipInputtView: UIView {
    private let titleView: TitleView = {
        let title = TitleView()
        title.configure(topText: "Choose", bottomText: "your tip")
        return title
    }()
    
    private lazy var tenPercentTipButton: UIButton = {
        let button = self.buildTipButton(tip: .tenPercent)
        
        return button
    }()
    
    private lazy var fifteenPercentTipButton: UIButton = {
        let button = self.buildTipButton(tip: .fifteenPercent)
        
        return button
    }()
    
    private lazy var twentyPercentTipButton: UIButton = {
        let button = self.buildTipButton(tip: .twentyPercent)
        
        return button
    }()
    
    private lazy var customTipButton: UIButton = {
        let button = UIButton()
        button.setTitle("Custom tip", for: .normal)
        button.titleLabel?.font = ThemeFont.bold(of: 20)
        button.backgroundColor = ThemeColor.primaryColor
        button.tintColor = .white
        button.addCornerRadius(radius: 8.0)
        return button
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [tenPercentTipButton, fifteenPercentTipButton, twentyPercentTipButton])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var stackViewV: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [buttonStackView, customTipButton])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    init() {
        super.init(frame: .zero)
        layout()
    }
    
    
    private func layout() {
        [titleView, stackViewV].forEach {
            addSubview($0)
        }
        
        stackViewV.snp.makeConstraints { make in
            make.top.trailing.bottom.equalToSuperview()
        }
        
        titleView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalTo(stackViewV.snp.leading).offset(-24)
            make.centerY.equalTo(buttonStackView.snp.centerY)
            make.width.equalTo(68)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildTipButton(tip: Tip) -> UIButton {
        let button = UIButton()
        button.backgroundColor = ThemeColor.primaryColor
        button.addCornerRadius(radius: 8)
        let text = NSMutableAttributedString(string: tip.stringValue, attributes: [
            .font: ThemeFont.bold(of: 20),
            .foregroundColor: UIColor.white
        ])
        text.addAttributes([.font: ThemeFont.demiBold(of: 14)], range: NSMakeRange(2, 1))
        button.setAttributedTitle(text, for: .normal)
        return button
    }
}
