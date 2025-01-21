//
//  CalculatorViewModel.swift
//  TipCalculator
//
//  Created by Zhanerke Ussen on 20/01/2025.
//
import Foundation
import Combine

class CalculatorViewModel {
    
    private var cancellables = Set<AnyCancellable>()
    
    struct Input {
        let billPublisher: AnyPublisher<Double, Never>
        let tipPublisher: AnyPublisher<Tip, Never>
        let splitPublisher: AnyPublisher<Int, Never>
    }
    
    struct Output {
        let updatingViewPublisher: AnyPublisher<Result, Never>
    }
    
    func transform(input: Input) -> Output {
        
        let updateViewPublisher = Publishers.CombineLatest3(
            input.billPublisher,
            input.tipPublisher,
            input.splitPublisher)
            .flatMap { [unowned self ] (bill, tip, split) in
                let result = calculateResult(bill: bill, tip: tip, split: split)
                return Just(result)
            }.eraseToAnyPublisher()
        
        return Output(updatingViewPublisher: updateViewPublisher)
    }
    
    private func calculateResult(bill: Double, tip: Tip, split: Int) -> Result {
        let tipAmount = calculateTipAmount(bill: bill, tip: tip)
        
        let totalBill = bill + tipAmount
        let amountPerPerson = totalBill / Double(split)
        
        return Result(amountPerPerson: amountPerPerson, totalBill: totalBill, totalTip: tipAmount)
    }
    
    private func calculateTipAmount(bill: Double, tip: Tip) -> Double {
        var tipAmount = 0.0
        
        switch tip {
        case .tenPercent:
            tipAmount = bill * 0.1
        case .fifteenPercent:
            tipAmount = bill * 0.15
        case .twentyPercent:
            tipAmount = bill * 0.2
        case .custom(let value):
            return Double(value)
        default:
            return tipAmount
        }
        
        return tipAmount
    }
}
