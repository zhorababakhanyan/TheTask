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
     @Environment(\.scenePhase) private var scenePhase
     
     var body: some Scene {
         WindowGroup {
             RootView()
                 .environmentObject(appState)
         }
         .onChange(of: scenePhase) { oldPhase, newPhase in
             switch newPhase {
             case .active:
                 appState.appWillEnterForeground()
             case .background:
                 appState.appDidEnterBackground()
             default:
                 break
             }
         }
     }
 }
