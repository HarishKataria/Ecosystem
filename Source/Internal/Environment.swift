//**************************************************************
//
//  Environment
//
//  Created by Harish Kataria
//  Copyright © 2018 Harish Kataria. All rights reserved.
//
//**************************************************************

import Foundation

/**
 * An Environment is the context for a replicator to
 * create new instances
 */
struct Environment {
    /**
     * collection of interconnected replicators
     */
    private let replicators: [Replicable]
    /**
     * the generator to manage the population
     */
    private let generator: Generator
    /**
     * connection tracker to find circular dependencies
     */
    private var connections: [Kind]

    /**
     * Create a environment with a fixed set of
     * replicator and the given generator
     */
    init(replicators: [Replicable], generator: Generator) {
        self.replicators = replicators
        self.generator = generator
        self.connections = []
    }
}

extension Environment: ReplicationEnvironment {
    /**
     * produces an entity and connected populations
     */
    func produce<Entity>() throws -> Entity {
        let result = try produce(kind: Entity.self)
        if let entity = result as? Entity {
            return entity
        }
        throw EcosystemError.mismatch(result, Entity.self)
    }

    /**
     * produces an entity, of the given kind, and connected populations
     */
    func produce(kind: Kind) throws -> Any {
        if let result = generator.produced.firstResult(where: { $0.availableMember(ofKind: kind) }) {
            return result
        }

        guard !connections.contains(where: { CompareUtil.canAssign($0, to: kind) }) else {
            throw EcosystemError.circularDependency(kind)
        }

        guard !replicators.isEmpty else {
            throw EcosystemError.notFound(kind)
        }

        var environment = self
        environment.connections.append(kind)

        if let result: Any = try replicators.firstResult(where: { replicator in
            guard CompareUtil.canAssign(replicator.kindProduced, to: kind) else {
                return nil
            }
            return try generator.generate(replicator: replicator, in: environment)
        }) {
            return result
        }

        throw EcosystemError.notFound(kind)
    }
}
