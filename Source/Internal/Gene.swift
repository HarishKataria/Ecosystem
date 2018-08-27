//**************************************************************
//
//  Gene
//
//  Created by Harish Kataria
//  Copyright © 2018 Harish Kataria. All rights reserved.
//
//**************************************************************

import Foundation

/**
 * Gene encapsulates the key functionality of a
 * Replicator, i.e. generation of type
 */
protocol Gene {
    /**
     * the target kind created
     */
    var kind: Kind { get }
    /**
     * checks if the individual of given kind influenced this gene
     */
    func isInfluencedBy(individualOf kind: Kind) -> Bool
    /**
     * generate offspring of this gene in the given environment
     */
    func generateOffspring(in environment: ReplicationEnvironment) throws -> Any
}
