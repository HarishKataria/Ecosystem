//**************************************************************
//
//  BillingUCTest
//
//  Created by Harish Kataria
//  Copyright © 2018 Harish Kataria. All rights reserved.
//
//**************************************************************

import XCTest
import Ecosystem

final class BillingUCTest: XCTestCase {
    func testEcosystem() throws {
        var ecosystem = Composer.ecosystem()
        ecosystem.add(Replicator(CreditCardProcessor.init))
        ecosystem.add(Replicator(TransactionLog.init, populationThreshold: .one))
        ecosystem.add(Replicator(PizzaOrder.init, populationThreshold: .fixedPool(ofSize: PizzaOrder.maxCount, withPicker: { Int(arc4random_uniform(UInt32($0))) })))
        ecosystem.add(Replicator(CreditCard.init))
        ecosystem.add(Replicator(combiningTwo: { (a: CreditCardProcessor, b: TransactionLog) -> BillingService in
            RealBillingService(processor: a, transactionLog: b)
        }))

        let billingService: BillingService = try ecosystem.createEntity()
        let rep = try billingService.charge(order: ecosystem.createEntity(), withCreditCard: ecosystem.createEntity())
        XCTAssertEqual(rep.name, Constants.markerLabel)

        let log1: TransactionLog = try ecosystem.createEntity()
        let log2: TransactionLog = try ecosystem.createEntity()
        XCTAssertTrue(log1 === log2)

        var orders: [PizzaOrder] = []
        try (0..<PizzaOrder.maxCount).forEach { _ in
            try orders.append(ecosystem.createEntity())
        }
        let testOrder: PizzaOrder = try ecosystem.createEntity()
        XCTAssertTrue(orders.contains(testOrder))
    }
}

final class Constants {
    static let markerLabel = "FromRealBillingService"
}

protocol BillingService {
    func charge(order: PizzaOrder, withCreditCard: CreditCard) -> Receipt
}

struct RealBillingService: BillingService {
    let processor: CreditCardProcessor
    let transactionLog: TransactionLog

    func charge(order: PizzaOrder, withCreditCard: CreditCard) -> Receipt {
        return Receipt(name: Constants.markerLabel)
    }
}

class TransactionLog {}
struct CreditCardProcessor {}
struct CreditCard {}

struct PizzaOrder: Equatable {
    static let maxCount = 5
}
struct Receipt {
    let name: String
}
