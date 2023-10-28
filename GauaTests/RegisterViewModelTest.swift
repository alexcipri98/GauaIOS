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
        let expectation = self.expectation(description: "Verification completed")
        
        viewModel.prefix = "+34"
        viewModel.phoneNumber = "666666666"
        
        viewModel.registerStepOne()
        
        let observation = viewModel.$goVerification.sink { newValue in
            if newValue {
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("waitForExpectations errored: \(error)")
            }
            observation.cancel()
            XCTAssertTrue(self.viewModel.goVerification)
        }
    }

    
    func testRegisterStepTwo_Failure() {
          let expectation = self.expectation(description: "Verification completed for testRegisterStepTwo_Failure")
          
          viewModel.prefix = ""
          viewModel.phoneNumber = "error"
          
          viewModel.registerStepTwo()
          
          DispatchQueue.main.async {
              expectation.fulfill()
          }
          
          waitForExpectations(timeout: 5) { error in
              if let error = error {
                  XCTFail("waitForExpectations errored: \(error)")
              }
              XCTAssertTrue(NavigationServiceViewModel.shared.router.showAlert)
              XCTAssertFalse(self.viewModel.goName)
              XCTAssertFalse(NavigationServiceViewModel.shared.router.currentDestination == .main)
          }
      }
      
      func testLoadImageAndRegister_Success() {
          let expectation = self.expectation(description: "Verification completed for testLoadImageAndRegister_Success")
          
          viewModel.prefix = ""
          viewModel.phoneNumber = "existing"
          viewModel.recortedImage = UIImage(named: "GauaLogo")
          
          viewModel.loadImageAndRegister()
          
          DispatchQueue.main.async {
              expectation.fulfill()
          }
          
          waitForExpectations(timeout: 5) { error in
              if let error = error {
                  XCTFail("waitForExpectations errored: \(error)")
              }
              XCTAssertFalse(NavigationServiceViewModel.shared.router.showAlert)
              XCTAssertTrue(NavigationServiceViewModel.shared.router.currentDestination == .main)
          }
      }
      
      func testLoadImageAndRegister_Failure() {
          let expectation = self.expectation(description: "Verification completed for testLoadImageAndRegister_Failure")
          
          viewModel.prefix = ""
          viewModel.phoneNumber = "error"
          
          viewModel.loadImageAndRegister()
          
          DispatchQueue.main.async {
              expectation.fulfill()
          }
          
          waitForExpectations(timeout: 5) { error in
              if let error = error {
                  XCTFail("waitForExpectations errored: \(error)")
              }
              XCTAssertTrue(NavigationServiceViewModel.shared.router.showAlert)
              XCTAssertFalse(NavigationServiceViewModel.shared.router.currentDestination == .main)
          }
      }
  }
