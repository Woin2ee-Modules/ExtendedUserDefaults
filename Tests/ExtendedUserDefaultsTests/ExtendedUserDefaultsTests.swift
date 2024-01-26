import ExtendedUserDefaults
import XCTest

final class ExtendedUserDefaultsTests: XCTestCase {

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

    func testSetAndGetCodable() {
        // Given
        let testCodable: TestCodable = .init(name: "Test", data: .init(repeating: 8, count: 8))

        let setResult = sut.setCodable(testCodable, forKey: TestKey.test)

        // When
        let getResult = sut.object(TestCodable.self, forKey: TestKey.test)

        // Then
        XCTAssertNoThrow(try setResult.get())
        XCTAssertNoThrow(try getResult.get())
    }

    func testThrowErrorWhenGetCodableForNotSavedKey() {
        // When
        let getResult = sut.object(TestCodable.self, forKey: TestKey.test)

        // Then
        XCTAssertThrowsError(try getResult.get())
    }

    func testThrowWhenFailedEncode() {
        // Given
        let testCodable: TestCodable = .init(name: "Test", data: .init(), amount: .infinity)

        // When
        let result = sut.setCodable(testCodable, forKey: TestKey.test)

        // Then
        XCTAssertThrowsError(try result.get())
    }

    func testRemoveObject() {
        // Given
        let testCodable: TestCodable = .init(name: "Test", data: .init(repeating: 8, count: 8))

        let setResult = sut.setCodable(testCodable, forKey: TestKey.test)

        // When
        sut.removeObject(forKey: TestKey.test)

        // Then
        let getResult = sut.object(TestCodable.self, forKey: TestKey.test)

        XCTAssertNoThrow(try setResult.get())
        XCTAssertThrowsError(try getResult.get())
    }

    func testRetrieveExistentBooleanValue() {
        // Given
        sut.setValue(true, forKey: TestKey.test)

        // When
        let result = sut.bool(forKey: TestKey.test)

        // Then
        XCTAssertEqual(result, true)
    }

    func testRetrieveNonexistentBooleanValue() {
        // When
        let result = sut.bool(forKey: TestKey.test)

        // Then
        XCTAssertNil(result)
    }

}
