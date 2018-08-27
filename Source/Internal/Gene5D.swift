//**************************************************************
//
//  Gene5D
//
//  Created by Harish Kataria
//  Copyright © 2018 Harish Kataria. All rights reserved.
//
//**************************************************************

import Foundation

/**
 * A simple gene protocol implementation that supports upto 5 dependencies
 */
enum Gene5D<Entity, A, B, C, D, E> {
    /**
     * 0 dependencies
     */
    case independent(() throws -> Entity)
    /**
     * 1 dependency
     */
    case oneInfluencer((A) throws -> Entity)
    /**
     * 2 dependencies
     */
    case twoInfluencers((A, B) throws -> Entity)
    /**
     * 3 dependencies
     */
    case threeInfluencers((A, B, C) throws -> Entity)
    /**
     * 4 dependencies
     */
    case fourInfluencers((A, B, C, D) throws -> Entity)
    /**
     * 5 dependencies
     */
    case fiveInfluencers((A, B, C, D, E) throws -> Entity)
}

extension Gene5D: Gene {
    /**
     * kind is captured by assoicated type in the generator function
     */
    var kind: Kind {
        return Entity.self
    }

    /**
     * checks if the individual of given kind influenced this gene
     */
    func isInfluencedBy(individualOf kind: Kind) -> Bool {
        let entity = kind
        switch self {
        case .independent:
            return false

        case .oneInfluencer:
            return CompareUtil.canAssign(entity, to: A.self)

        case .twoInfluencers:
            return CompareUtil.canAssign(entity, to: A.self) ||
                CompareUtil.canAssign(entity, to: B.self)

        case .threeInfluencers:
            return CompareUtil.canAssign(entity, to: A.self) ||
                CompareUtil.canAssign(entity, to: B.self) ||
                CompareUtil.canAssign(entity, to: C.self)

        case .fourInfluencers:
            return CompareUtil.canAssign(entity, to: A.self) ||
                CompareUtil.canAssign(entity, to: B.self) ||
                CompareUtil.canAssign(entity, to: C.self) ||
                CompareUtil.canAssign(entity, to: D.self)

        case .fiveInfluencers:
            return CompareUtil.canAssign(entity, to: A.self) ||
                CompareUtil.canAssign(entity, to: B.self) ||
                CompareUtil.canAssign(entity, to: C.self) ||
                CompareUtil.canAssign(entity, to: D.self) ||
                CompareUtil.canAssign(entity, to: E.self)
        }
    }

    /**
     * generate offspring of this gene in the given environment
     */
    func generateOffspring(in environment: ReplicationEnvironment) throws -> Any {
        switch self {
        case .independent(let closure):
            return try closure()

        case .oneInfluencer(let closure):
            let a: A = try environment.produce()
            return try closure(a)

        case .twoInfluencers(let closure):
            let a: A = try environment.produce()
            let b: B = try environment.produce()
            return try closure(a, b)

        case .threeInfluencers(let closure):
            let a: A = try environment.produce()
            let b: B = try environment.produce()
            let c: C = try environment.produce()
            return try closure(a, b, c)

        case .fourInfluencers(let closure):
            let a: A = try environment.produce()
            let b: B = try environment.produce()
            let c: C = try environment.produce()
            let d: D = try environment.produce()
            return try closure(a, b, c, d)

        case .fiveInfluencers(let closure):
            let a: A = try environment.produce()
            let b: B = try environment.produce()
            let c: C = try environment.produce()
            let d: D = try environment.produce()
            let e: E = try environment.produce()
            return try closure(a, b, c, d, e)
        }
    }
}
