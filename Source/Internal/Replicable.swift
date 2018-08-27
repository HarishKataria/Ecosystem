//**************************************************************
//
//  Replicable
//
//  Created by Harish Kataria
//  Copyright © 2018 Harish Kataria. All rights reserved.
//
//**************************************************************

import Foundation

/**
 * protocol for Replicator behavior
 */
protocol Replicable {
    /**
     * limits on the population
     */
    var populationThreshold: PopulationThreshold { get }
    /**
     * kind produced by the replicator
     */
    var kindProduced: Kind { get }

    /**
     * environment specific generation
     */
    func generate(in: ReplicationEnvironment) throws -> Any
    /**
     * dependency check
     */
    func depends(on: Replicable) -> Bool
}
