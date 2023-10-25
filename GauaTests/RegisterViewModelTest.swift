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

    func testValidRegisterStepOne() throws {
        viewModel.prefix = "+34"
        viewModel.phoneNumber = "666666666"
        
        
        viewModel.registerStepOne()
        
        XCTAssertFalse(viewModel.showFirstStepError)
        XCTAssertTrue(viewModel.goVerification)
    }
    
    func testRegisterStepTwo_Success_UserExists() {
        viewModel.prefix = ""
        viewModel.phoneNumber = "existing"
        viewModel.registerStepTwo()
        
        XCTAssertFalse(viewModel.showSecondStepError)
        XCTAssertFalse(viewModel.goName) //Si el usuario existe no debería ir al Name
        XCTAssertTrue(NavigationService.shared.router.currentDestination == .main)
    }

    func testRegisterStepTwo_Success_UserDoesNotExist() {
        viewModel.prefix = ""
        viewModel.phoneNumber = "noExisting"
        viewModel.registerStepTwo()
        
        XCTAssertFalse(viewModel.showSecondStepError)
        XCTAssertTrue(viewModel.goName) //Si el usuario no existe debería ir al Name
    }

    func testRegisterStepTwo_Failure() {
        viewModel.prefix = ""
        viewModel.phoneNumber = "Error"
        viewModel.registerStepTwo()
        
        XCTAssertTrue(viewModel.showSecondStepError)
        XCTAssertFalse(viewModel.goName)
    }
    
    func testLoadImageAndRegister_Success() {
        viewModel.prefix = ""
        viewModel.phoneNumber = "existing"
        viewModel.recortedImage = UIImage(named: "GauaLogo")
        viewModel.loadImageAndRegister()
        
        XCTAssertFalse(viewModel.showLastStepError)
    }
    
    func testLoadImageAndRegister_Failure() {
        viewModel.prefix = ""
        viewModel.phoneNumber = "error"
        viewModel.loadImageAndRegister()

        XCTAssertTrue(viewModel.showLastStepError)
        XCTAssertFalse(NavigationService.shared.router.currentDestination == .main)
    }
}
