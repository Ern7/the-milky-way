//
//  ItemListViewModel.swift
//  TheMilkyWayTests
//
//  Created by Ernest Nyumbu on 2021/11/26.
//

import XCTest
@testable import TheMilkyWay

class ItemListViewModelTests: XCTestCase {
    
    var sut: ItemListViewModel!
    
    override func setUp() {
        super.setUp()
        sut = ItemListViewModel()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testReceiveData() {
        let expectation = self.expectation(description: "fetch nasa data failed.")
        
        WebService.shared.load(resource: NasaResponse.all) { [weak self] result in
            switch result {
            case .success(let nasaResponse):
                self?.sut.itemsViewModel = nasaResponse.collection.items.map(ItemViewModel.init)
                
                XCTAssertEqual(self?.sut.itemsViewModel.count, nasaResponse.collection.items.count)
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            expectation.fulfill()
        }
        
        
        self.waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testItemViewModelAtExtensionMethod(){
        let expectation = self.expectation(description: "fetch nasa data failed.")
        
        WebService.shared.load(resource: NasaResponse.all) { [weak self] result in
            switch result {
            case .success(let nasaResponse):
                self?.sut.itemsViewModel = nasaResponse.collection.items.map(ItemViewModel.init)
                
                let position = 3
                let itemViewModel = self?.sut.itemViewModel(at: position)
                
                XCTAssertNotNil(itemViewModel)
                
                XCTAssertEqual(itemViewModel?.title, nasaResponse.collection.items[position].data[0].title)
                
           case .failure(let error):
                XCTAssertNotNil(error)
            }
            expectation.fulfill()
        }
        
        
        self.waitForExpectations(timeout: 5.0, handler: nil)
    }
}
  
