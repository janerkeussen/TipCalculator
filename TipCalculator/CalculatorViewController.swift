//
//  ViewController.swift
//  TipCalculator
//
//  Created by Zhanerke Ussen on 18/01/2025.
//
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViewsLayout()
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

