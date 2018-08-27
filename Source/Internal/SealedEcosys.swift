//**************************************************************
//
//  SealedEcosys
//
//  Created by Harish Kataria
//  Copyright © 2018 Harish Kataria. All rights reserved.
//
//**************************************************************

import Foundation

/**
 * Implementation of an immutable Ecosystem
 */
struct SealedEcosys: SealedEcosystem {
    /**
     * collection of replicators
     */
    private let replicators: [Replicable]
    /**
     * saved populations
     */
    private let populations: [Population]

    /**
     * Creates a new Ecosystem with a fixed of replicators and
     * save populations
     * - Note: only replicators without any population limits are
     *         allowed
     */
    init(replicators: [Replicable] = [], populations: [Population] = []) {
        self.replicators = replicators.filter { $0.populationThreshold == .unlimited }
        self.populations = populations
    }
}

extension SealedEcosys {
    /**
     * Creates an instance of the given entity kind
     */
    func createEntity<EntityType>() throws -> EntityType {
        return try SealedEcosys.createEntity(replicators: replicators,
                                             populations: populations)
    }

    /**
     * Creates an instance via Environment process
     */
    static func createEntity<EntityType>(replicators: [Replicable],
                                         populations: [Population]) throws -> EntityType {
        let generator = Generator(populations: populations, savesNewGenerations: false)
        return try Environment(replicators: replicators, generator: generator).produce()
    }
}
