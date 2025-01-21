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
    
    
    let result = Result(amountPerPerson: 20, totalBill: 40, totalTip: 5)
    
    func transform(input: Input) -> Output {
        
        input.tipPublisher.sink { Tip in
            print("percent tipped", Tip)
        }.store(in: &cancellables)
        
        return Output(updatingViewPublisher: Just(result).eraseToAnyPublisher())
    }
    
    private func calculatePerPersonAmount() {
        
    }
    
}
