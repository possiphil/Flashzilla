//
//  AppDisappearView.swift
//  Flashzilla
//
//  Created by Philipp Sanktjohanser on 23.01.23.
//

import SwiftUI

struct AppDisappearView: View {
    @Environment(\.scenePhase) var scenePhase
    
    var body: some View {
        Text("Hello, World!")
            .onChange(of: scenePhase) { newPhase in
                if newPhase == .active {
                    print("active")
                } else if newPhase == .inactive {
                    print("inactive")
                } else if newPhase == .background {
                    print("background")
                }
            }
    }
}

struct AppDisappearView_Previews: PreviewProvider {
    static var previews: some View {
        AppDisappearView()
    }
}
