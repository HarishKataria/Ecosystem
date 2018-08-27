//**************************************************************
//
//  Array+Shortcuts
//
//  Created by Harish Kataria
//  Copyright © 2018 Harish Kataria. All rights reserved.
//
//**************************************************************

import Foundation

extension Array {
    /**
     * shortcut for finding the first match and mapping it to target result type
     */
    func firstResult<Result>(where predicate: (Element) throws -> Result?) rethrows -> Result? {
        for entry in self {
            if let value = try predicate(entry) {
                return value
            }
        }
        return nil
    }
}
