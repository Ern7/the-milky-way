//
//  ItemViewModelTests.swift
//  TheMilkyWayTests
//
//  Created by Ernest Nyumbu on 2021/11/26.
//

import XCTest
import Combine
@testable import TheMilkyWay

class ItemViewModelTests: XCTestCase {
    
    var sut: ItemViewModel!
    var cancellable: AnyCancellable?
    
    override func setUp() {
        super.setUp()
        
        
        var data = [Datum]()
        data.append(Datum(center: Center.arc, title: "ARC-2002-ACD02-0056-22", photographer: "Tom Trower", keywords: ["VSHAIP", "V-22"], nasaID: "ARC-2002-ACD02-0056-22", mediaType: MediaType.image, dateCreated: "2002-03-20T00:00:00Z", datumDescription: "VSHAIP test in 7x10ft#1 W.T. (multiple model configruations) V-22 helicopter shipboard aerodynamic interaction program: L-R seated Allen Wadcox, (standind) Mark Betzina, seated in front of computer Gloria Yamauchi, in background Kurt Long.", description508: nil, secondaryCreator: nil, location: nil, album: nil))
        
        var itemLinks = [ItemLink]()
        itemLinks.append(ItemLink(href: "https://images-assets.nasa.gov/image/ARC-2002-ACD02-0056-22/ARC-2002-ACD02-0056-22~thumb.jpg", rel: Rel.preview, render: MediaType.image))
        
        var item = Item(href: "https://images-assets.nasa.gov/image/ARC-2002-ACD02-0056-22/collection.json", data: data, links: itemLinks)
        sut = ItemViewModel(item: item)
    }
    
    override func tearDown() {
        sut = nil
        cancellable = nil
        super.tearDown()
    }

    func testTitle() {
        
        //Assert
        XCTAssertNotNil(sut.title)
        
        //Assert
        XCTAssertEqual(sut.title, sut.item.data[0].title)
    }
    
    func testSubtitle() {
        
        //Assert
        XCTAssertNotNil(sut.subtitle)
    }
    
    func testPhoto() {
        
        //Assert
        XCTAssertNotNil(sut.photo)
    }

    func testLoadImage() {
        
        let expectation = self.expectation(description: "fetch image.")
        
        cancellable = sut.loadImage(for: sut.photo).sink { [unowned self] image in
            //Assert
            XCTAssertNotNil(image)
            
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 5.0, handler: nil)
        
    }
    

}
    
    



