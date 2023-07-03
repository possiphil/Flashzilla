//
//  AccessibilitySettingsView.swift
//  Flashzilla
//
//  Created by Philipp Sanktjohanser on 23.01.23.
//

import SwiftUI

func withOptionalAnimation<Result>(_ animation: Animation? = .default, _ body: () throws -> Result) rethrows -> Result {
    if UIAccessibility.isReduceMotionEnabled {
        return try body()
    } else {
        return try withAnimation(animation, body)
    }
}

struct AccessibilitySettingsView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityReduceMotion) var reduceMotion
    @Environment(\.accessibilityReduceTransparency) var reduceTransparency
    
    @State private var scale = 1.0
    
    var body: some View {
        Text("Hello, world!")
//            .scaleEffect(scale)
            .padding()
            .background(reduceTransparency ? .black : .black.opacity(0.5))
            .foregroundColor(.white)
            .clipShape(Capsule())
//            .onTapGesture {
//                withOptionalAnimation {
//                    scale *= 1.5
//                }
//
////                if reduceMotion {
////                    scale *= 1.5
////                } else {
////                    withAnimation {
////                        scale *= 1.5
////                    }
////                }
//            }
        
//        HStack {
//            if differentiateWithoutColor {
//                Image(systemName: "checkmark.circle")
//            }
//
//            Text("Success")
//        }
//        .padding()
//        .background(differentiateWithoutColor ? .black : .green)
//        .foregroundColor(.white)
//        .clipShape(Capsule())
    }
}

struct AccessibilitySettingsView_Previews: PreviewProvider {
    static var previews: some View {
        AccessibilitySettingsView()
    }
}
