//
//  TipInputtView.swift
//  TipCalculator
//
//  Created by Zhanerke Ussen on 18/01/2025.
//
import Combine
import CombineCocoa
import UIKit

class TipInputtView: UIView {
    private let titleView: TitleView = {
        let title = TitleView()
        title.configure(topText: "Choose", bottomText: "your tip")
        return title
    }()
    
    private lazy var tenPercentTipButton: UIButton = {
        let button = self.buildTipButton(tip: .tenPercent)
        button.tapPublisher.flatMap { [weak self] in
            Just(Tip.tenPercent)
        }.assign(to: \.value, on: tipSubject)
            .store(in: &cancellables)
        
        return button
    }()
    
    private lazy var fifteenPercentTipButton: UIButton = {
        let button = self.buildTipButton(tip: .fifteenPercent)
        button.tapPublisher.flatMap {
            Just(Tip.fifteenPercent)
        }.assign(to: \.value, on: tipSubject)
            .store(in: &cancellables)
        return button
    }()
    
    private lazy var twentyPercentTipButton: UIButton = {
        let button = self.buildTipButton(tip: .twentyPercent)
        button.tapPublisher.flatMap { [weak self] in
            Just(Tip.twentyPercent)
        }.assign(to: \.value, on: tipSubject)
            .store(in: &cancellables)
        return button
    }()
    
    private lazy var customTipButton: UIButton = {
        let button = UIButton()
        button.setTitle("Custom amount", for: .normal)
        button.titleLabel?.font = ThemeFont.bold(ofSize: 20)
        button.backgroundColor = ThemeColor.primaryColor
        button.tintColor = .white
        button.addCornerRadius(radius: 8.0)
        button.tapPublisher.sink { [weak self] _ in
            self?.handleCustomTipButtonTap()
        }.store(in: &cancellables)
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
    
    private var cancellables = Set<AnyCancellable>()
    private var tipSubject = CurrentValueSubject<Tip, Never>(.none)
    var tipValuePublisher: AnyPublisher<Tip, Never> {
        return tipSubject.eraseToAnyPublisher()
    }
    
    init() {
        super.init(frame: .zero)
        layout()
        observe()
    }
    
    private func handleCustomTipButtonTap() {
        let alert: UIAlertController = {
            let alert = UIAlertController(
                title: "Enter tip amount",
                message: nil,
                preferredStyle: .alert)
            alert.addTextField { textield in
                textield.placeholder = "Add your tip amount"
                textield.keyboardType = .numberPad
                textield.autocorrectionType = .no
            }
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel)
            let ok = UIAlertAction(title: "Ok", style: .default) { [weak self] _ in
                
                guard let text = alert.textFields?.first?.text, let value = Int(text) else {
                    return
                }
                self?.tipSubject.send(.custom(value: value))
            }
            
            alert.addAction(cancel)
            alert.addAction(ok)
            
            return alert
        }()
        parentViewController?.present(alert, animated: true)
    }
    
    private func resetView() {
        [tenPercentTipButton, fifteenPercentTipButton, twentyPercentTipButton, customTipButton].forEach { button in
            button.backgroundColor = ThemeColor.primaryColor
        }
        let text = NSMutableAttributedString(string: "Custom amount", attributes: [
            .font: ThemeFont.bold(ofSize: 20)
        ])
        customTipButton.setAttributedTitle(text, for: .normal)
    }
    
    private func observe() {
        tipSubject.sink { [weak self] tip in
            self?.resetView()
            
            switch tip {
            case .tenPercent:
                self?.tenPercentTipButton.backgroundColor = ThemeColor.secondaryColor
            case .fifteenPercent:
                self?.fifteenPercentTipButton.backgroundColor = ThemeColor.secondaryColor
            case .twentyPercent:
                self?.twentyPercentTipButton.backgroundColor = ThemeColor.secondaryColor
            case .custom(let value):
                let text = NSMutableAttributedString(
                    string: "$\(value)", attributes: [
                    .font: ThemeFont.bold(ofSize: 20)
                ])
                text.addAttributes([.font: ThemeFont.bold(ofSize: 14)], range: NSMakeRange(0, 1))
                self?.customTipButton.setAttributedTitle(text, for: .normal)
                self?.customTipButton.backgroundColor = ThemeColor.secondaryColor
            default:
                break
            }
        }
        .store(in: &cancellables)
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
            .font: ThemeFont.bold(ofSize: 20),
            .foregroundColor: UIColor.white
        ])
        text.addAttributes([.font: ThemeFont.demiBold(of: 14)], range: NSMakeRange(2, 1))
        button.setAttributedTitle(text, for: .normal)
        return button
    }
}
