//
//  ViewController.swift
//  TipCalculator
//
//  Created by Zhanerke Ussen on 18/01/2025.
//

import Combine
import SnapKit
import UIKit

class CalculatorViewController: UIViewController {
    ///Instance views
    private let logoView = LogoView()
    private let resultView = ResultView()
    private let billInputtView = BillInputView()
    private let tipInputtView = TipInputtView()
    private let splitInputtView = SplitInputtView()
   
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            logoView,
            resultView,
            billInputtView,
            tipInputtView,
            splitInputtView,
            UIView()
        ])
        
        stackView.axis = .vertical
        stackView.spacing = 36
        
        return stackView
    }()
    
    private let viewModel = CalculatorViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    private lazy var viewTapPublisher: AnyPublisher<Void, Never> = {
        let tapGesture = UITapGestureRecognizer(target: self, action: nil) //#selector(logoTapped)
        view.addGestureRecognizer(tapGesture)
        return tapGesture.tapPublisher.flatMap { _ in
            Just(Void())
        }.eraseToAnyPublisher()
    }()
    
    private lazy var logoViewTapPublisher: AnyPublisher<Void, Never> = { [weak self] in
        let tapGesture = UITapGestureRecognizer(target: self, action: nil)
        tapGesture.numberOfTapsRequired = 2
        self?.logoView.addGestureRecognizer(tapGesture)
        return tapGesture.tapPublisher.flatMap { _ in
            Just(Void())
        }.eraseToAnyPublisher()
    }()
    
    @objc func logoTapped() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViewsLayout()
        bind()
        observe()
    }
    
    private func bind() {
        let input = CalculatorViewModel.Input(
            billPublisher: billInputtView.billValuePublsiher,
            tipPublisher: tipInputtView.tipValuePublisher,
            splitPublisher: splitInputtView.splitValuePublisher,
            logoViewPublisher: logoViewTapPublisher
        )
        
        let output = viewModel.transform(input: input)
        
        output.updatingViewPublisher.sink { [weak self] result in
            self?.resultView.configure(result: result)
        }.store(in: &cancellables)
        
        output.resetCalculatorPublisher.sink { [weak self] _ in
            self?.billInputtView.reset()
            self?.tipInputtView.reset()
            self?.splitInputtView.reset()
            
            UIView.animate(
                withDuration: 0.15,
                delay: 0,
                usingSpringWithDamping: 5.0,
                initialSpringVelocity: 0.5,
                options: .curveEaseInOut) {
                    self?.logoView.transform = .init(scaleX: 1.25, y: 1.25)
                } completion: { _ in
                    UIView.animate(withDuration: 0.1) {
                        self?.logoView.transform = .identity
                    }
                }
        }.store(in: &cancellables)
    }
    
    private func observe() {
        viewTapPublisher.sink { [weak self] _ in
            self?.view.endEditing(true)
        }.store(in: &cancellables)
    }
    
    private func setupViewsLayout() {
        view.backgroundColor = ThemeColor.background
        view.addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.leading.equalTo(view.snp.leadingMargin).offset(16)
            $0.trailing.equalTo(view.snp.trailingMargin).offset(-16)
            $0.top.equalTo(view.snp.topMargin).offset(16)
            $0.bottom.equalTo(view.snp.bottomMargin).offset(-16)
        }
        
        logoView.snp.makeConstraints {
            $0.height.equalTo(48)
        }
        
        resultView.snp.makeConstraints {
            $0.height.equalTo(224)
        }
        
        billInputtView.snp.makeConstraints {
            $0.height.equalTo(56)
        }
        
        tipInputtView.snp.makeConstraints {
            $0.height.equalTo(56+56+16)
        }
        
        splitInputtView.snp.makeConstraints {
            $0.height.equalTo(56)
        }
    }
}

