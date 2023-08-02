//
//  View+Extensions.swift
//  TaskTracker
//
//  Created by Ahmad Maulana on 02/08/23.
//

import SwiftUI

extension View {
    @ViewBuilder public func hidden(_ shouldHide: Bool) -> some View {
        switch shouldHide {
        case true: self.hidden()
        case false: self
        }
    }
}


