//**************************************************************
//
//  UtilTest
//
//  Created by Harish Kataria
//  Copyright © 2018 Harish Kataria. All rights reserved.
//
//**************************************************************

import XCTest
@testable import Ecosystem

final class UtilTest: XCTestCase {
    func testCompare() {
        let type1: Kind = Cat.self
        let type2: Kind = Cat?.self
        let type3: Kind = Dog.self

        XCTAssertFalse(type1 == type2)
        XCTAssertTrue(CompareUtil.canAssign(type1, to: type2))
        XCTAssertFalse(CompareUtil.canAssign(type2, to: type1))
        XCTAssertFalse(CompareUtil.canAssign(type1, to: type3))
        XCTAssertFalse(CompareUtil.canAssign(type3, to: type2))
        XCTAssertFalse(CompareUtil.canAssign(type3, to: type1))
    }
}

protocol Cat {}
protocol Dog {}
