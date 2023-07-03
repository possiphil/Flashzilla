//
//  AppView.swift
//  Flashzilla
//
//  Created by Philipp Sanktjohanser on 24.01.23.
//

import Combine
import SwiftUI

struct AppView: View {
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var voiceOverEnabled
    @Environment(\.scenePhase) var scenePhase
    
    @StateObject var vm = ViewModel()
    
    @State private var showingEditScreen = false
    
    var body: some View {
        ZStack {
            Image(decorative: "background")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                Text("Time: \(vm.time)")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(.black.opacity(0.7))
                    .clipShape(Capsule())
                
                ZStack {
                    ForEach(vm.cards) { card in
                        CardView(card: card) {
                            withAnimation {
                                vm.complete(card, as: true)
                            }
                        } retry: {
                            withAnimation {
                                vm.complete(card, as: false)
                            }
                        }
                        .stacked(at: vm.indexOf(card), in: vm.cards.count)
                        .allowsHitTesting(vm.on(card))
                        .accessibilityHidden(vm.on(card))
                    }
                }
                .allowsHitTesting(vm.time > 0)
                
                if vm.cards.isEmpty {
                    Button("Start Again") { vm.restart() }
                    .padding()
                    .background(.white)
                    .foregroundColor(.black)
                    .clipShape(Capsule())
                }
            }
            
            VStack {
                HStack {
                    Spacer()
                    
                    Button {
                        showingEditScreen = true
                    } label: {
                        Image(systemName: "plus.circle")
                            .padding()
                            .background(.black.opacity(0.7))
                            .clipShape(Circle())
                    }
                }
                
                Spacer()
            }
            .foregroundColor(.white)
            .font(.largeTitle)
            .padding()
            
            if differentiateWithoutColor || voiceOverEnabled {
                VStack {
                    Spacer()
                    
                    HStack {
                        Button {
                            withAnimation {
                                vm.complete(vm.currentCard, as: false)
                            }
                        } label: {
                            Image(systemName: "xmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibilityLabel("Wrong")
                        .accessibilityHint("Mark your answer as being incorrect")
                        
                        Spacer()
                        
                        Button {
                            withAnimation {
                                vm.complete(vm.currentCard, as: true)
                            }
                        } label: {
                            Image(systemName: "checkmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibilityLabel("Correct")
                        .accessibilityHint("Mark your answer as being correct.")
                    }
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding()
                }
            }
        }
        .onAppear {  vm.restart() }
        .onReceive(timer) { _ in vm.reduceTime() }
        .onChange(of: scenePhase) { newPhase in vm.adjust(to: newPhase) }
        .sheet(isPresented: $showingEditScreen, onDismiss: { vm.restart() }, content: EditCards.init)
        .environmentObject(vm)
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
