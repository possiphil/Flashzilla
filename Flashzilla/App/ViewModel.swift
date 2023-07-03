//
//  ViewModel.swift
//  Flashzilla
//
//  Created by Philipp Sanktjohanser on 10.02.23.
//

import SwiftUI

@MainActor final class ViewModel: ObservableObject {
    private let savePath = FileManager().documentDirectory().appending(path: "Cards")
    
    @Published var cards = [Card]() {
        didSet {
            print(cards)
        }
    }
    @Published var time = 100
    @Published var active = true
    @Published var prompt = ""
    @Published var answer = ""
    
    var currentCard: Card {
        return cards.first ?? Card.example
    }
    
    private var topCard: Card {
        return cards.last ?? Card.example
    }
    
    init() {
        load()
    }
    
    func load() {
        do {
            let data = try Data(contentsOf: savePath)
            cards = try JSONDecoder().decode([Card].self, from: data)
        } catch {
            cards = []
        }
    }
    
    func add() {
        let trimmedPrompt = prompt.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedAnswer = answer.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !(trimmedPrompt.isEmpty || trimmedAnswer.isEmpty) else { return }
        
        let card = Card(prompt: trimmedPrompt, answer: trimmedAnswer)
        prompt = ""
        answer = ""
        
        cards.insert(card, at: 0)
        save()
    }
    
    func remove(at offsets: IndexSet) {
        cards.remove(atOffsets: offsets)
        save()
    }
    
    func complete(_ card: Card, as outcome: Bool) {
        cards.removeAll(where: { $0 == card })

        if outcome == false {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.cards.insert(card, at: 0)
            }
        }
        
        save()
    }
    
    func save() {
        if let data = try? JSONEncoder().encode(cards) {
            try? data.write(to: savePath, options: [.atomic, .completeFileProtection])
        }
    }
    
    func reduceTime() {
        guard active else { return }
        if time > 0 { time -= 1 }
    }
    
    func restart() {
        time = 100
        active = true
        load()
    }
    
    func adjust(to scenePhase: ScenePhase) {
        active = (scenePhase == .active && !cards.isEmpty)
    }
    
    func on(_ card: Card) -> Bool {
        return topCard == card
    }
    
    func indexOf(_ card: Card) -> Int {
        return cards.firstIndex(where: { $0 == card })!
    }
}
