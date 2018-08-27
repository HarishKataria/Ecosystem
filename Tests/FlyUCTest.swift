//**************************************************************
//
//  FlyUCTest
//
//  Created by Harish Kataria
//  Copyright © 2018 Harish Kataria. All rights reserved.
//
//**************************************************************

import XCTest
import Ecosystem

final class FlyUCTest: XCTestCase {
    func testNormalSetup() {
        var ecosystem = Composer.ecosystem()
        ecosystem.add(Replicator(combiningThree: Plane.init(leftWing:rightWing:fuselage:)))
        ecosystem.add(Replicator(combiningTwo: Wing.init(engine:landingGear:)))
        ecosystem.add(Replicator(combiningFour: Fuselage.init(economy:business:pilot:landingGear:)))
        ecosystem.add(Replicator(combining: Cabin.init(seats:)))
        ecosystem.add(Replicator(LandingGear.init))
        ecosystem.add(Replicator(Seats.init))
        ecosystem.add(Replicator({ () -> EngineType in Engine() }))

        do {
            let sealedEco = try ecosystem.sealed()

            let plane1: Plane = try sealedEco.createEntity()
            let plane2: Plane = try sealedEco.createEntity()

            XCTAssert(plane1 !== plane2)
            XCTAssert(plane1.rightWing.landingGear != nil)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }

    func testCircularDependencies() {
        var ecosystem = Composer.ecosystem()
        ecosystem.add(Replicator(combiningThree: Plane.init(leftWing:rightWing:fuselage:)))
        ecosystem.add(Replicator(combiningTwo: Wing.init(engine:landingGear:)))
        ecosystem.add(Replicator(combiningFour: Fuselage.init(economy:business:pilot:landingGear:)))
        ecosystem.add(Replicator(combining: Cabin.init(seats:)))
        ecosystem.add(Replicator(LandingGear.init))
        ecosystem.add(Replicator(Seats.init))
        ecosystem.add(Replicator(combining: { (plane: Plane) -> EngineType in BadEngine.init(plane: plane) }))

        do {
            let sealed = try ecosystem.sealed()
            let plane: Plane = try sealed.createEntity()

            XCTFail("\(plane) should have raised EcosystemError")
        } catch let error as EcosystemError {
            XCTAssertTrue(true, error.localizedDescription)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
}

final class Plane {
    let leftWing: Wing
    let rightWing: Wing
    let fuselage: Fuselage

    init(leftWing: Wing, rightWing: Wing, fuselage: Fuselage) {
        self.leftWing = leftWing
        self.rightWing = rightWing
        self.fuselage = fuselage
    }
}

struct Fuselage {
    let economy: Cabin
    let business: Cabin
    let pilot: Cabin
    let landingGear: LandingGear
}

struct Wing {
    let engine: EngineType
    let landingGear: LandingGear?
}

struct Cabin {
    let seats: Seats
}

protocol EngineType {}
struct Engine: EngineType {}

struct BadEngine: EngineType {
    let plane: Plane
}

struct Seats {}
struct LandingGear {}
