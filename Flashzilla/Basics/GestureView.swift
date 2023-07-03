//
//  GestureView.swift
//  Flashzilla
//
//  Created by Philipp Sanktjohanser on 23.01.23.
//

import SwiftUI

struct GestureView: View {
//    @State private var currentAmount = 0.0
    @State private var currentAmount = Angle.zero
    @State private var finalAmount = Angle.zero
//    @State private var finalAmount = 1.0
    
    @State private var offset = CGSize.zero
    @State private var isDragging = false
    
    var body: some View {
        let dragGesture = DragGesture()
            .onChanged { value in offset = value.translation }
            .onEnded { _ in
                withAnimation {
                    offset = .zero
                    isDragging = false
                }
            }
        
        let pressGesture = LongPressGesture()
            .onEnded { value in
                withAnimation {
                    isDragging = true
                }
            }
        
        let combined = pressGesture.sequenced(before: dragGesture)
        
        Circle()
            .fill(.red)
            .frame(width: 64, height: 64)
            .scaleEffect(isDragging ? 1.5 : 1)
            .offset(offset)
            .gesture(combined)
        
//        VStack {
//            Text("Hello, world!")
//                .onTapGesture {
//                    print("Text tapped!")
//                }
//        }
////        .onTapGesture {
////            print("VStack tapped!")
////        } prints child
////        .highPriorityGesture(
////            TapGesture()
////                .onEnded {
////                    print("VStack tapped!")
////                }
////        ) prints container
//        .simultaneousGesture(
//            TapGesture()
//                .onEnded {
//                    print("VStack tapped!")
//                }
//        )
        
        
//        Text("Hello, World!")
////            .scaleEffect(finalAmount + currentAmount)
//            .rotationEffect(currentAmount + finalAmount)
//            .gesture(
////                MagnificationGesture()
////                    .onChanged{ amount in
////                        currentAmount = amount - 1
////                    }
////                    .onEnded{ amount in
////                        finalAmount += currentAmount
////                        currentAmount = 0
////                    }
//                RotationGesture()
//                    .onChanged({ angle in
//                        currentAmount = angle
//                    })
//                    .onEnded({ angle in
//                        finalAmount += currentAmount
//                        currentAmount = .zero
//                    })
//            )
//            .onTapGesture(count: 2) {
//                print("Double tapped!")
//            }
//            .onLongPressGesture(minimumDuration: 1) {
//                print("Long pressed!")
//            } onPressingChanged: { inProgress in
//                print("In progress: \(inProgress)")
//            }
    }
}

struct GestureView_Previews: PreviewProvider {
    static var previews: some View {
        GestureView()
    }
}
