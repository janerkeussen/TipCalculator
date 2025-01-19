//
//  AmountView.swift
//  TipCalculator
//
//  Created by Zhanerke Ussen on 18/01/2025.
//
import UIKit

class AmountView: UIView {
    private let title: String
    private let textAlignment: NSTextAlignment
    
    private lazy var titleLabel: UILabel = {
        LabelFactory.build(text: title, font: ThemeFont.regular(of: 18), textColor: ThemeColor.text, textAlignment: textAlignment)
    }()
    
    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = textAlignment
        label.textColor = ThemeColor.primaryColor
        let text = NSMutableAttributedString(string: "$0", attributes: [
            .font: ThemeFont.bold(ofSize: 24)
        ])
        text.addAttributes([.font: ThemeFont.bold(ofSize: 16)], range: NSMakeRange(0, 1))
        label.attributedText = text
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel,
            amountLabel
        ])
        stackView.axis = .vertical
        return stackView
    }()
    
    init(title: String, alignment: NSTextAlignment) {
        self.title = title
        self.textAlignment = alignment
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview().offset(2)
        }
    }
}
