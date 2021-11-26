//
//  WebServiceTests.swift
//  TheMilkyWayTests
//
//  Created by Ernest Nyumbu on 2021/11/26.
//


import XCTest
@testable import TheMilkyWay

class WebServiceTests: XCTestCase {
    
    var sut: WebService!
    
    override func setUp() {
        super.setUp()
        sut = WebService.shared
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testLoadNasaData() {
        
        let expectation = self.expectation(description: "fetch nasa data.")
        
        sut.load(resource: NasaResponse.all) { [weak self] result in
            switch result {
            case .success(let nasaResponse):
                XCTAssertNotNil(nasaResponse)
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 5.0, handler: nil)
        
    }
    
    func testLoadNasaDataFailed() {
        
        let incorrectUrlResource: Resource<NasaResponse> = {
            //intentionally using wrong URL
            guard let url = URL(string: "https://images-api.nasa.gov123456/") else {
                fatalError("URL is incorrect!")
            }
            
            return Resource<NasaResponse>(url: url)
        }()
        
        let expectation = self.expectation(description: "fetch nasa data failed.")
        
        sut.load(resource: incorrectUrlResource) { [weak self] result in
            switch result {
            case .success(let nasaResponse):
                XCTAssertNotNil(nasaResponse)
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 5.0, handler: nil)
        
    }

}

