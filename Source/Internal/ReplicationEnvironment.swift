//**************************************************************
//
//  ReplicationEnvironment
//
//  Created by Harish Kataria
//  Copyright © 2018 Harish Kataria. All rights reserved.
//
//**************************************************************

import Foundation

/**
 * Environment abstraction that faciliates delegation of finding/creating
 * instances of related entities
 */
protocol ReplicationEnvironment {
    /**
     * finding/create related entity
     */
    func produce<Instance>() throws -> Instance
}
