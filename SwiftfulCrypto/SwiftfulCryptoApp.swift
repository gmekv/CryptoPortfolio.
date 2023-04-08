//
//  SwiftfulCryptoApp.swift
//  SwiftfulCrypto
//
//  Created by Giorgi Meqvabishvili on 04.04.23.
//

import SwiftUI

@main
struct SwiftfulCryptoApp: App {
    
    @StateObject private var vm = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .navigationBarHidden(true)
            }
            .environmentObject(vm)
        }
    }
}
