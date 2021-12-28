//
//  Sequence-Sorting.swift
//  StokeProgresion
//
//  Created by Kyle Price on 12/28/21.
//

import Foundation


extension Sequence {
    func sorted<Value>(by keypath: KeyPath<Element, Value>,
                      using areIncreasing: (Value, Value) throws -> Bool) rethrows -> [Element] {
        return try self.sorted(by: { try areIncreasing($0[keyPath: keypath], $1[keyPath: keypath]) })
    }
    
    func sorted<Value: Comparable>(by keypath: KeyPath<Element, Value>) -> [Element] {
        return self.sorted(by: keypath, using: <)
    }
}
