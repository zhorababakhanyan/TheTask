//
 //  TheTaskApp.swift
 //  TheTask
 //
 //  Created by Zhora Babakhanyan on 27/04/2025.
 //
 
 import SwiftUI
 
 @main
 struct TheTaskApp: App {
     
     @StateObject var appState = AppState()
     
     var body: some Scene {
         WindowGroup {
             RootView()
                 .environmentObject(appState)
         }
     }
 }
