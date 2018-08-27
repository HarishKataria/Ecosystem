//**************************************************************
//
//  CompareUtil
//
//  Created by Harish Kataria
//  Copyright © 2018 Harish Kataria. All rights reserved.
//
//**************************************************************

import Foundation

/**
 * Utils to compare types
 */
struct CompareUtil {
    /**
     * checks if the give type can be stored in the second argument type variable
     */
    static func canAssign(_ type: Kind, to store: Kind) -> Bool {
        if type == store {
            return true
        }
        if let unwrapped = store as? WrappingType.Type {
            return unwrapped.unwrapType == type
        }
        return false
    }
}

/**
 * A protocol for types that wrap around another object
 */
private protocol WrappingType {
    /**
     * return the wrapped type the object controls
     */
    static var unwrapType: Kind { get }
}

extension Optional: WrappingType {
    fileprivate static var unwrapType: Kind {
        return Wrapped.self
    }
}
