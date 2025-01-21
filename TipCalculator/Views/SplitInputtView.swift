//
//  SplitInputtView.swift
//  TipCalculator
//
//  Created by Zhanerke Ussen on 18/01/2025.
//

import Combine
import CombineCocoa
import UIKit

class SplitInputtView: UIView {
    private let titleView: TitleView = {
        let title = TitleView()
        title.configure(topText: "Split", bottomText: "the total")
        return title
    }()
    
    private lazy var decrementButton: UIButton = {
        let button = buildButton(text: "-", corners: [.layerMinXMaxYCorner, .layerMinXMinYCorner])
        button.tapPublisher.flatMap({ [unowned self] _ in
            Just(splitValueSubject.value == 1 ? 1 : splitValueSubject.value - 1)
        }).assign(to: \.value, on: splitValueSubject)
        .store(in: &cancellables)
        return button
    }()
    
    private lazy var incrementButton: UIButton = {
        let button = buildButton(text: "+", corners: [.layerMaxXMinYCorner, .layerMaxXMaxYCorner])
        button.tapPublisher.flatMap { [unowned self] _ in
            Just(splitValueSubject.value + 1)
        }.assign(to: \.value, on: splitValueSubject)
        .store(in: &cancellables)
        return button
    }()
    
    private let quantityLabel: UILabel = {
        let label = LabelFactory.build(
            text: "1", font: ThemeFont.bold(ofSize: 20), backgroundColor: .white
        )
        return label
    }()
    
    private lazy var stepperStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [decrementButton, quantityLabel, incrementButton])
        stackView.axis = .horizontal
        stackView.spacing = 0
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    private var peopleCount = 1
    
    private var cancellables = Set<AnyCancellable>()
    private var splitValueSubject = CurrentValueSubject<Int, Never>(1)
    var splitValuePublisher: AnyPublisher<Int, Never> {
        return splitValueSubject.removeDuplicates().eraseToAnyPublisher()
    }
    
    init() {
        super.init(frame: .zero)
        layout()
        observe()
    }
    
    private func observe() {
        splitValueSubject.sink { [unowned self] count in
            quantityLabel.text = count.stringValue
        }.store(in: &cancellables)
        
    }
    
    private func layout() {
        [titleView, stepperStackView].forEach { addSubview($0) }
        
        titleView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalTo(stepperStackView.snp.centerY)
            make.trailing.equalTo(stepperStackView.snp.leading).offset(-24)
            make.width.equalTo(68)
        }
        
        stepperStackView.snp.makeConstraints { make in
            make.top.trailing.bottom.equalToSuperview()
        }
        
        [incrementButton, decrementButton].forEach { button in
            button.snp.makeConstraints { make in
                make.width.equalTo(button.snp.height).multipliedBy(1.1)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildButton(text: String, corners: CACornerMask) -> UIButton {
        let button = UIButton()
        button.backgroundColor = ThemeColor.primaryColor
        button.setTitle(text, for: .normal)
        button.titleLabel?.font = ThemeFont.bold(ofSize: 20)
        button.addRounderCorners(corners: corners, radius: 8)
        return button
    }
}
