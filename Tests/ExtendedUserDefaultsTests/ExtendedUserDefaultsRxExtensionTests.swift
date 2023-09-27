//
//  ExtendedUserDefaultsRxExtensionTests.swift
//
//
//  Created by Jaewon Yun on 2023/09/27.
//

import ExtendedUserDefaults
import ExtendedUserDefaultsRxExtension
import RxBlocking
import XCTest

final class ExtendedUserDefaultsRxExtensionTests: XCTestCase {

    var sut: ExtendedUserDefaults!
    
    override func setUp() {
        super.setUp()
        
        sut = .standard
        sut.removeAllObject(forKeyType: TestKey.self)
    }
    
    override func tearDown() {
        super.tearDown()
        
        sut = nil
    }
    
    func testSetAndGetCodable() throws {
        // Given
        let testCodable: TestCodable = .init(name: "Test", data: .init(repeating: 8, count: 8))

        try sut.rx.setCodable(testCodable, forKey: TestKey.test)
            .toBlocking()
            .single()
        
        // When
        let object = try sut.rx.object(TestCodable.self, forKey: TestKey.test)
            .toBlocking()
            .single()

        // Then
        XCTAssertEqual(testCodable, object)
    }

    func testThrowErrorWhenGetCodableForNotSavedKey() {
        // When
        let sequence = sut.rx.object(TestCodable.self, forKey: TestKey.test)
            .toBlocking()

        // Then
        XCTAssertThrowsError(try sequence.single())
    }

    func testThrowWhenFailedEncode() {
        // Given
        let testCodable: TestCodable = .init(name: "Test", data: .init(), amount: .infinity)

        // When
        let sequence = sut.rx.setCodable(testCodable, forKey: TestKey.test)
            .toBlocking()

        // Then
        XCTAssertThrowsError(try sequence.single())
    }

}
