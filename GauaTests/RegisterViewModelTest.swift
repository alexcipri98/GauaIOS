//
//  RegisterViewModelTest.swift
//  GauaTests
//
//  Created by Alex Ciprián López on 23/10/23.
//

@testable import GauaMock
import XCTest

class RegisterViewModelTests: XCTestCase {
    
    var viewModel: RegisterViewModel!
    
    override func setUpWithError() throws {
        viewModel = RegisterViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testValidPhoneNumberWithSuccessfulServiceCall() throws {
        viewModel.prefix = "+34"
        viewModel.phoneNumber = "666666666"
        
        
        viewModel.registerStepOne()
        
        XCTAssertFalse(viewModel.showFirstStepError)
        XCTAssertTrue(viewModel.goVerification)
    }
}
