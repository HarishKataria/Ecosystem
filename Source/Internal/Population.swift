//**************************************************************
//
//  Population
//
//  Created by Harish Kataria
//  Copyright © 2018 Harish Kataria. All rights reserved.
//
//**************************************************************

import Foundation

/**
 * Stores a replicator and its generated individuals
 */
struct Population {
    /**
     * instances created by the replicator
     */
    let individuals: [Any]
    /**
     * the replicator that generated the population
     */
    let replicator: Replicable
}

extension Population {
    /**
     * gets an instance from the population pool if it matches the requested
     * kind and replicator criteria
     */
    func availableMember(ofKind kind: Kind) -> Any? {
        guard CompareUtil.canAssign(replicator.kindProduced, to: kind) else {
            return nil
        }

        switch replicator.populationThreshold {
        case .unlimited:
            return nil
        case .one:
            return individuals.count < 1 ? nil : individuals.first
        case .fixedPool(let count, let selector):
            return individuals.count < count ? nil : individuals[selector(count)]
        }
    }
}
