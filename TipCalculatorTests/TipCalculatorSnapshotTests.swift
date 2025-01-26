//
//  TipCalculatorSnapshotTests.swift
//  TipCalculatorTests
//
//  Created by Zhanerke Ussen on 25/01/2025.
//

import Foundation
import XCTest
import SnapshotTesting
@testable import TipCalculator

final class TipCalculatorSnapshotTests: XCTestCase {
    private var screenWidth: CGFloat {
        return UIScreen.main.bounds.size.width
    }
    
    func testLogoView() {
        //Given
        let size = CGSize(width: screenWidth, height: 48)
        
        //when
        let view = LogoView()
        
        //then
        assertSnapshot(matching: view, as: .image(size: size))
    }
    
    func testInitialResultView() {
        //Given
        let size = CGSize(width: screenWidth, height: 224)
        
        //when
        let view = ResultView()
        
        //then
        assertSnapshot(matching: view, as: .image(size: size))
    }
    
    func testResultViewWithValues() {
        //Given
        let size = CGSize(width: screenWidth, height: 224)
        
        //when
        let view = ResultView()
        let result = Result(amountPerPerson: 27.50, totalBill: 55, totalTip: 5)
        view.configure(result: result)
        
        //then
        assertSnapshot(matching: view, as: .image(size: size))
    }
    
    func testInitialBillInputView() {
        //Given
        let size = CGSize(width: screenWidth, height: 56)
        
        //when
        let view = BillInputView()
        
        assertSnapshot(matching: view, as: .image(size: size))
    }
    
    func testBillInputViewWithValues() {
        //Given
        let size = CGSize(width: screenWidth, height: 56)
        
        //when
        let view = BillInputView()
        let textField = view.allSubViewsOf(type: UITextField.self).first
        textField?.text = "500"
        
        //then
        assertSnapshot(matching: view, as: .image(size: size))
    }
    
    func testInitialTipInputView() {
        //Given
        let size = CGSize(width: screenWidth, height: 56+56+16)
        
        //when
        let view = TipInputtView()
        
        //then
        assertSnapshot(matching: view, as: .image(size: size))
    }
    
    func testTipInputViewWithSeclection() {
        //Given
        let size = CGSize(width: screenWidth, height: 56+56+16)
        
        //when
        let view = TipInputtView()
        let button = view.allSubViewsOf(type: UIButton.self).first
        button?.sendActions(for: .touchUpInside)
        
        //then
        assertSnapshot(matching: view, as: .image(size: size))
    }
    
    func testInitialSplitInputView() {
        //Given
        let size = CGSize(width: screenWidth, height: 56)
        
        //when
        let view = SplitInputtView()
        
        //then
        assertSnapshot(matching: view, as: .image(size: size))
    }
    
    func testSplitInputViewWithSelection() {
        //Given
        let size = CGSize(width: screenWidth, height: 56)
        
        //when
        let view = SplitInputtView()
        let button = view.allSubViewsOf(type: UIButton.self).last
        button?.sendActions(for: .touchUpInside)
    
        
        //then
        assertSnapshot(matching: view, as: .image(size: size))
    }
}

extension UIView {
    //https://stackoverflow.com/a/45297466/6181721
    func allSubViewsOf<T : UIView>(type : T.Type) -> [T] {
        var all = [T]()
        func getSubview(view: UIView) {
            if let aView = view as? T{
                all.append(aView)
            }
            guard view.subviews.count>0 else { return }
            view.subviews.forEach{ getSubview(view: $0) }
        }
        getSubview(view: self)
        return all
    }
}

