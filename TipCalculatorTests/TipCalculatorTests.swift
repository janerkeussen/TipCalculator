//
//  TipCalculatorTests.swift
//  TipCalculatorTests
//
//  Created by Zhanerke Ussen on 18/01/2025.
//

import XCTest
import Combine
@testable import TipCalculator

final class TipCalculatorTests: XCTestCase  {
    
    //sut
    private var sut: CalculatorViewModel!
    private var cancellables: Set<AnyCancellable>!
    private var logoViewTapSubject = PassthroughSubject<Void, Never>()
    
    override func setUp() {
        sut = CalculatorViewModel()
        cancellables = .init()
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        cancellables = nil
    }
    
    func testResultWithoutTipForOnePerson() {
        //Given
        let bill: Double = 100
        let tip: Tip = .none
        let split: Int = 1
        
        //When
        let input = buildInput(bill: bill, tip: tip, split: split)
        
        //Then
        sut.transform(input: input).updatingViewPublisher.sink { result in
            XCTAssertEqual(result.totalBill, 100.0)
            XCTAssertTrue(result.totalTip == 0.0)
            XCTAssertEqual(result.amountPerPerson, 100)
        }.store(in: &cancellables)
    }
    
    private func buildInput(bill: Double, tip: Tip, split: Int) -> CalculatorViewModel.Input {
        .init(
            billPublisher: Just(bill).eraseToAnyPublisher(),
            tipPublisher: Just(tip).eraseToAnyPublisher(),
            splitPublisher: Just(split).eraseToAnyPublisher(),
            logoViewPublisher: logoViewTapSubject.eraseToAnyPublisher()
        )
    }
}
