//**************************************************************
//
//  Replicator
//
//  Created by Harish Kataria
//  Copyright © 2018 Harish Kataria. All rights reserved.
//
//**************************************************************

import Foundation

/**
 * An object that can create an instance of a particular kind
 */
public struct Replicator {
    let gene: Gene
    /**
     * population limits on the replicator
     */
    public let populationThreshold: PopulationThreshold
}

public extension Replicator {
    /**
     * Creates an independent replicator with the given generator function
     * and population threshold
     */
    init<Entity>(_ generator: @escaping () throws -> Entity,
                 populationThreshold: PopulationThreshold = .unlimited) {
        self.init(gene: Gene5D<Entity, Any, Any, Any, Any, Any>.independent(generator),
                  populationThreshold: populationThreshold)
    }

    /**
     * Creates a replicator of one dependency with the given generator function
     * and population threshold
     */
    init<Entity, A>(combining generator: @escaping (A) throws -> Entity,
                    populationThreshold: PopulationThreshold = .unlimited) {
        self.init(gene: Gene5D<Entity, A, Any, Any, Any, Any>.oneInfluencer(generator),
                  populationThreshold: populationThreshold)
    }

    /**
     * Creates a replicator of two dependencies with the given generator function
     * and population threshold
     */
    init<Entity, A, B>(combiningTwo generator: @escaping (A, B) throws -> Entity,
                       populationThreshold: PopulationThreshold = .unlimited) {
        self.init(gene: Gene5D<Entity, A, B, Any, Any, Any>.twoInfluencers(generator),
                  populationThreshold: populationThreshold)
    }

    /**
     * Creates a replicator of three dependencies with the given generator function
     * and population threshold
     */
    init<Entity, A, B, C>(combiningThree generator: @escaping (A, B, C) throws -> Entity,
                          populationThreshold: PopulationThreshold = .unlimited) {
        self.init(gene: Gene5D<Entity, A, B, C, Any, Any>.threeInfluencers(generator),
                  populationThreshold: populationThreshold)
    }

    /**
     * Creates a replicator of four dependencies with the given generator function
     * and population threshold
     */
    init<Entity, A, B, C, D>(combiningFour generator: @escaping (A, B, C, D) throws -> Entity,
                             populationThreshold: PopulationThreshold = .unlimited) {
        self.init(gene: Gene5D<Entity, A, B, C, D, Any>.fourInfluencers(generator),
                  populationThreshold: populationThreshold)
    }

    /**
     * Creates a replicator of five dependencies with the given generator function
     * and population threshold
     */
    init<Entity, A, B, C, D, E>(combiningFive generator: @escaping (A, B, C, D, E) throws -> Entity,
                                populationThreshold: PopulationThreshold = .unlimited) {
        self.init(gene: Gene5D<Entity, A, B, C, D, E>.fiveInfluencers(generator),
                  populationThreshold: populationThreshold)
    }
}

public extension Replicator {
    /**
     * The kind produced by this Replicator
     */
    var kindProduced: Kind {
        return gene.kind
    }
}

extension Replicator: Replicable {
    /**
     * generate the target kind in the given environment
     */
    func generate(in environment: ReplicationEnvironment) throws -> Any {
        return try gene.generateOffspring(in: environment)
    }

    /**
     * returns `true` if this replicator directly depends on the given replicator
     */
    func depends(on anotherReplicator: Replicable) -> Bool {
        guard let other = anotherReplicator as? Replicator else {
            return false
        }
        return gene.isInfluencedBy(individualOf: other.gene.kind)
    }
}
