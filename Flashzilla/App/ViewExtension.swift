//
//  ViewExtension.swift
//  Flashzilla
//
//  Created by Philipp Sanktjohanser on 25.01.23.
//

import SwiftUI

struct DynamicBackground: ViewModifier {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    let offset: CGSize
    @Binding var isDragging: Bool
    
    func body(content: Content) -> some View {
        content
            .background(
                differentiateWithoutColor
                ? nil
                : RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .fill(isDragging ? (offset.width > 0 ? .green : .red) : .white)
            )
    }
}

extension View {
    func dynamicBackground(withOffset offset: CGSize, isDragging: Binding<Bool>) -> some View {
        modifier(DynamicBackground(offset: offset, isDragging: isDragging))
    }
}

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = Double(total - position)
        return self.offset(x: 0, y: offset * 10)
    }
}
