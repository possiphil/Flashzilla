//
//  EditCards.swift
//  Flashzilla
//
//  Created by Philipp Sanktjohanser on 25.01.23.
//

import SwiftUI

struct EditCards: View {
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        NavigationStack {
            List {
                Section("Add new card") {
                    TextField("Prompt", text: $vm.prompt)
                    TextField("Answer", text: $vm.answer)
                    Button("Add card", action: { vm.add() })
                }
                
                Section("Cards") {
                    ForEach(vm.cards) { card in
                        VStack(alignment: .leading) {
                            Text(card.prompt)
                                .font(.headline)
                            
                            Text(card.answer)
                                .foregroundColor(.secondary)
                        }
                    }
                    .onDelete(perform: vm.remove)
                }
            }
            .navigationTitle("Edit Cards")
            .toolbar {
                Button("Done", action: done)
            }
            .listStyle(.grouped)
            .onAppear(perform: { vm.load() })
        }
    }
    
    func done() {
        dismiss()
    }
}

struct EditCards_Previews: PreviewProvider {
    static var previews: some View {
        EditCards()
    }
}
