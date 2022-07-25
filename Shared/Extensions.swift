//
//  Extensions.swift
//  saxjaxdenlilletabel
//
//  Created by Jakob Skov Søndergård on 25/07/2022.
//

import SwiftUI

///this alows me to add an onChange handler directly on the binding in TextField:
///TextField("x", value: $fieldValue .onChange(numberFieldChanged),format:.number)
///
///func numberFieldChanged(to value: Int?){
/// print("changed value \(value), facit: \(facit)")
/// isCorrect = facit == value
///}
extension Binding {
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        Binding(
            get: { self.wrappedValue },
            set: { newValue in
                self.wrappedValue = newValue
                handler(newValue)
            }
        )
    }
}
