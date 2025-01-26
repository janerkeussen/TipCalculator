//
//  BillInputView.swift
//  TipCalculator
//
//  Created by Zhanerke Ussen on 18/01/2025.
//

import Combine
import CombineCocoa
import UIKit

class BillInputView: UIView {
    private let titleView: TitleView = {
        let title = TitleView()
        title.configure(topText: "Enter", bottomText: "your bill")
        return title
    }()
    
    private let textFieldContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.addCornerRadius(radius: 8.0)
        return view
    }()
    
    private let currencyLabel: UILabel = {
        let label = LabelFactory.build(
            text: "$", font: ThemeFont.bold(ofSize: 24)
        )
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    private lazy var textField: UITextField = {
        let textfield = UITextField()
        textfield.borderStyle = .none
        textfield.font = ThemeFont.demiBold(of: 28)
        textfield.keyboardType = .decimalPad
        textfield.setContentHuggingPriority(.defaultLow, for: .horizontal)
        textfield.tintColor = ThemeColor.text
        textfield.textColor = ThemeColor.text
        //Add toolbar
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        toolbar.barStyle = .default
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonTapped))
        toolbar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            doneButton
        ]
        toolbar.isUserInteractionEnabled = true
        textfield.inputAccessoryView = toolbar
        textfield.accessibilityIdentifier = ScreenIdentifier.BillInputView.textField.rawValue
        return textfield
    }()
    
    private var cancellables = Set<AnyCancellable>()
    private let billSubject: PassthroughSubject<Double, Never> = .init()
    var billValuePublsiher: AnyPublisher<Double, Never> {
        return billSubject.eraseToAnyPublisher()
    }
    
    init() {
        super.init(frame: .zero)
        layout()
        observe()
    }

    private func observe() {
        textField.textPublisher.sink { [unowned self] text in
            self.billSubject.send(text?.doubleValue ?? 0)
        }
        .store(in: &cancellables)
    }
    
    func reset() {
        textField.text = nil
        billSubject.send(0)
    }
    
    @objc private func doneButtonTapped() {
        textField.endEditing(true)
    }
    
    private func layout() {
        [titleView, textFieldContainerView].forEach { addSubview($0) }
        titleView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalTo(textFieldContainerView.snp.centerY)
            $0.width.equalTo(68)
            $0.trailing.equalTo(textFieldContainerView.snp.leading).offset(-24)
        }
        
        textFieldContainerView.snp.makeConstraints {
            $0.top.trailing.bottom.equalToSuperview()
        }
        
        [currencyLabel, textField].forEach { textFieldContainerView.addSubview($0) }
        
        currencyLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(textFieldContainerView.snp.leading).offset(16)
            
        }
        
        textField.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(currencyLabel.snp.trailing).offset(16)
            make.trailing.equalTo(textFieldContainerView.snp.trailing).offset(16)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
