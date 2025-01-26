//
//  ResultView.swift
//  TipCalculator
//
//  Created by Zhanerke Ussen on 18/01/2025.
//
import UIKit

class ResultView: UIView {
    private let topHeaderLabel: UILabel = {
        return LabelFactory.build(text: "Total per person",
                                  font: ThemeFont.demiBold(of: 18)
        )
    }()
    
    private let amountPerPersonLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        let text = NSMutableAttributedString(string: "$0", attributes: [
            .font: ThemeFont.demiBold(of: 48)
        ])
        text.addAttributes([.font: ThemeFont.bold(ofSize: 24)], range: NSMakeRange(0, 1))
        label.attributedText = text
        label.accessibilityIdentifier = ScreenIdentifier.ResultView.totalAmountPerPersonValueLabel.rawValue
        return label
        
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = ThemeColor.separator
        return view
    }()
    
    
    private let totalAmountView: AmountView = {
        let view = AmountView(title: "Total bill", alignment: .left, amountLabelIdentifier: ScreenIdentifier.ResultView.totalBillValueLabel.rawValue)
        return view
    }()
    
    private let tipAmountView: AmountView = {
        let view = AmountView(title: "Total tip", alignment: .right, amountLabelIdentifier: ScreenIdentifier.ResultView.totalTipValueLabel.rawValue)
        return view
    }()
    
    private lazy var stackViewV: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            topHeaderLabel,
            amountPerPersonLabel,
            separatorView,
            createSpacerView(height: 0),
            stackViewH])
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var stackViewH: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [totalAmountView, UIView(), tipAmountView])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    init() {
        super.init(frame: .zero)
        layout()
    }
    
    func configure(result: Result) {
        let totalPerPersonText = NSMutableAttributedString(string: result.amountPerPerson.currencyFormatted, attributes: [
            .font: ThemeFont.bold(ofSize: 48)
        ])
        totalPerPersonText.addAttributes([
            .font: ThemeFont.bold(ofSize: 24)
        ], range: NSMakeRange(0, 1))
        amountPerPersonLabel.attributedText = totalPerPersonText
        
        totalAmountView.configure(with: result.totalBill.currencyFormatted)
        tipAmountView.configure(with: result.totalTip.currencyFormatted)
    }
    
    private func layout() {
        backgroundColor = ThemeColor.background
        
        addSubview(stackViewV)
        stackViewV.snp.makeConstraints {
            $0.top.equalTo(self.snp.top).offset(24)
            $0.leading.equalTo(self.snp.leading).offset(24)
            $0.trailing.equalTo(self.snp.trailing).offset(-24)
            $0.bottom.equalTo(self.snp.bottom).offset(-24)
        }
        
        separatorView.snp.makeConstraints {
            $0.height.equalTo(2)
        }
        
        addShadow(offset: CGSize(width: 0, height: 3), color: .black, radius: 12.0, opacity:  0.1)
    }
    
    private func createSpacerView(height: CGFloat) -> UIView {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: height).isActive = true
        return view
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
