//**************************************************************
//
//  ReplicatorEcosystem
//
//  Created by Harish Kataria
//  Copyright © 2018 Harish Kataria. All rights reserved.
//
//**************************************************************

import Foundation

/**
 * Implmentation of the Ecosystem protocol
 */
struct ReplicatorEcosystem: Ecosystem {
    /**
     * collection of replicators operating in this ecosystem
     */
    private var replicators: [Replicable] = []
    /**
     * saved populations
     */
    private var populations: [Population] = []
    /**
     * count of all the generations created thus far
     */
    private(set) var entityCount: Int = 0

    /**
     * save a snapshot
     */
    mutating func sealed() throws -> SealedEcosystem {
        let replicators = self.replicators
        var populations = self.populations
        try replicators.forEach { replicator in
            let size = replicator.populationThreshold.retainSize
            guard size > 0 else {
                return
            }

            let generator = Generator(populations: populations)
            defer {
                populations = generator.produced
            }

            let environment = Environment(replicators: replicators, generator: generator)
            try (0..<size).forEach { _ in
                _ = try environment.produce(kind: replicator.kindProduced)
            }
        }
        self.populations = populations
        return SealedEcosys(replicators: replicators, populations: populations)
    }

    /**
     * adds the given replicator
     */
    mutating func add(_ replicator: Replicator) {
        let kind = replicator.kindProduced

        var array = replicators.filter { $0.kindProduced != kind }
        array.append(replicator)
        array.sort { left, right in left.depends(on: right) }

        replicators = array
        populations = populations.filter { $0.replicator.kindProduced != kind }
    }

    /**
     * Creates an instance of the given entity kind. Intermediate
     * instances, whose replicators have a limit propulation
     * threshold, are also created in this process.
     */
    mutating func createEntity<Entity>() throws -> Entity {
        let prev = populations
        let generator = Generator(populations: prev)
        defer {
            populations = generator.produced
            entityCount += max(1, populations.count - prev.count)
        }
        return try Environment(replicators: replicators, generator: generator).produce()
    }

}
