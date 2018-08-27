//**************************************************************
//
//  Ecosystem
//
//  Created by Harish Kataria
//  Copyright © 2018 Harish Kataria. All rights reserved.
//
//**************************************************************

import Foundation

/**
 * Ecosystem is a container for inter-dependent replicators
 */
public protocol Ecosystem {
    /**
     * Add the given replicator (and replaces previous replicator
     * producing the same kind of object)
     */
    mutating func add(_: Replicator)

    /**
     * Creates an instance of the given entity kind. Intermediate
     * instances, whose replicators have a limit propulation threshold,
     * are also created in this process.
     */
    mutating func createEntity<Entity>() throws -> Entity

    /**
     * Captures the current state of this ecosystem in
     * an immutable ecosystem
     */
    mutating func sealed() throws -> SealedEcosystem

    /**
     * count of all the generations created thus far
     */
    var entityCount: Int { get }
}

/**
 * An immutable snapshot of an Ecosystem
 */
public protocol SealedEcosystem {
    /**
     * Creates an instance of the given entity kind
     */
    func createEntity<Entity>() throws -> Entity
}
