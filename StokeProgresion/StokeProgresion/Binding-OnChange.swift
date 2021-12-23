//
//  Binding-OnChange.swift
//  StokeProgresion
//
//  Created by Kyle Price on 12/23/21.
//

import SwiftUI

extension Binding {
    func onChange(_ handler: @escaping () -> Void) -> Binding<Value> {
        Binding(
            get: { self.wrappedValue },
            set: { val in
                self.wrappedValue = val
                handler()
            }
        )
    }
}
