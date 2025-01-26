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
    
    func testResultWithoutTipFor2Person() {
        //Given
        let bill: Double = 100
        let tip: Tip = .none
        let split: Int = 2
        
        //When
        let input = buildInput(bill: bill, tip: tip, split: split)
        
        //Then
        sut.transform(input: input).updatingViewPublisher.sink { result in
            XCTAssertEqual(result.totalBill, 100.0)
            XCTAssertTrue(result.totalTip == 0.0)
            XCTAssertEqual(result.amountPerPerson, 50)
        }.store(in: &cancellables)
    }
    
    func testResultWith10PercentTipFor2Person() {
        //Given
        let bill: Double = 100
        let tip: Tip = .tenPercent
        let split: Int = 2
        
        //When
        let input = buildInput(bill: bill, tip: tip, split: split)
        
        //Then
        sut.transform(input: input).updatingViewPublisher.sink { result in
            XCTAssertEqual(result.totalBill, 110.0)
            XCTAssertTrue(result.totalTip == 10)
            XCTAssertEqual(result.amountPerPerson, 55)
        }.store(in: &cancellables)
    }
    
    func testResultWithCustomTipFor4Person() {
        //Given
        let bill: Double = 200
        let tip: Tip = .custom(value: 15)
        let split: Int = 4
        
        //When
        let input = buildInput(bill: bill, tip: tip, split: split)
        
        //Then
        sut.transform(input: input).updatingViewPublisher.sink { result in
            XCTAssertEqual(result.totalBill, 215.0)
            XCTAssertTrue(result.totalTip == 15)
            XCTAssertEqual(result.amountPerPerson, (result.totalBill/Double(split)))
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
