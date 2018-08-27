//**************************************************************
//
//  Composer
//
//  Created by Harish Kataria
//  Copyright © 2018 Harish Kataria. All rights reserved.
//
//**************************************************************

import Foundation

/**
 * A factory for creating Ecosystems
 */
public final class Composer {
    /**
     * Creates a new Ecosystem instance
     */
    public static func ecosystem() -> Ecosystem {
        return ReplicatorEcosystem()
    }

    /**
     * Creates a null-object equivalent Ecosystem
     */
    public static func emptyEcosystem() -> SealedEcosystem {
        return SealedEcosys()
    }
}
