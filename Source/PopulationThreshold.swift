//**************************************************************
//
//  PopulationThreshold
//
//  Created by Harish Kataria
//  Copyright © 2018 Harish Kataria. All rights reserved.
//
//**************************************************************

import Foundation

/**
 * An enum for specifying limits on the population of
 * Replicators in Ecosystems
 */
public enum PopulationThreshold {
    /**
     * allow as many as possible
     */
    case unlimited
    /**
     * allow at most one
     */
    case one
    /**
     * allow a fixed number of individuals
     */
    case fixedPool(ofSize: Int, withPicker: (Int) -> Int)
}

extension PopulationThreshold {
    /**
     * numeric summarization of the limit
     */
    var retainSize: Int {
        switch self {
        case .unlimited:              return 0
        case .one:                    return 1
        case .fixedPool(let size, _): return max(1, size)
        }
    }
}

extension PopulationThreshold: Comparable {
    /**
     * Returns `true` if the population threshold value on the first argument
     * is less than the second
     */
    public static func < (lhs: PopulationThreshold, rhs: PopulationThreshold) -> Bool {
        return lhs.retainSize < rhs.retainSize
    }

    /**
     * Returns `true` if the population threshold values match
     */
    public static func == (lhs: PopulationThreshold, rhs: PopulationThreshold) -> Bool {
        return lhs.retainSize == rhs.retainSize
    }
}
