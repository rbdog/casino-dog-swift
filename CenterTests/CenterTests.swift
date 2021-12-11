//
//
//

import XCTest
import Center

class CenterTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testLooping() {
     let original = ["A", "B", "C", "D", "E"]
        let new0 = original.broughtToTail(prefix: 0)
        let new1 = original.broughtToTail(prefix: 1)
        let new2 = original.broughtToTail(prefix: 2)
        let new3 = original.broughtToTail(prefix: 3)
        let new4 = original.broughtToTail(prefix: 4)
        print(new0)
        print(new1)
        print(new2)
        print(new3)
        print(new4)
    }

    func testSwiftCasinoPlusCity() {
    }

    func testReceptionist() {

    }

    func testWheel() {

    }

    func testSplit() {

    }

    func testTranspose() {

    }

    func testAsciiTable() {

    }
}
