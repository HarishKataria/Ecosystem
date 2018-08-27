//**************************************************************
//
//  Generator
//
//  Created by Harish Kataria
//  Copyright © 2018 Harish Kataria. All rights reserved.
//
//**************************************************************

import Foundation

/**
 * Generator manages the creation of new individuals in
 * related populations of involved replicators
 */
final class Generator {
    /**
     * populations mapped by type name
     */
    private var populations: [String: Population]
    /**
     * if saving is allowed
     */
    private let savesNewGenerations: Bool

    /**
     * creates a Generator with the given starting population
     * growth criteria
     */
    init(populations: [Population] = [], savesNewGenerations: Bool = true) {
        self.savesNewGenerations = savesNewGenerations

        var store: [String: Population] = [:]
        populations.forEach { store[String(describing: $0.replicator.kindProduced)] = $0 }
        self.populations = store
    }
}

extension Generator {
    /**
     * collective populations thus far generated
     */
    var produced: [Population] {
        return populations.map { $0.value }
    }

    /**
     * initiates the creating of a replicator's (and thereby the interconnected
     * replicators') population in the given environment
     */
    func generate(replicator: Replicable, in environment: ReplicationEnvironment) throws -> Any {
        if replicator.populationThreshold != .unlimited && !savesNewGenerations {
            throw EcosystemError.incompatibleWithPopulationThreshold(ofKind: replicator.kindProduced)
        }

        let key = String(describing: replicator.kindProduced)
        let previous = populations[key]

        if let entity = previous?.availableMember(ofKind: replicator.kindProduced) {
            return entity
        }

        let entity = try replicator.generate(in: environment)
        guard replicator.populationThreshold != .unlimited else {
            return entity
        }

        var individuals = [entity]
        if let existing = previous?.individuals {
            individuals.append(contentsOf: existing)
            while individuals.count > replicator.populationThreshold.retainSize {
                individuals.removeLast()
            }
        }

        populations[key] = Population(individuals: individuals, replicator: replicator)
        return entity
    }
}
