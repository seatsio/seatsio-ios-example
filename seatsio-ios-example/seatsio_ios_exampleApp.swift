//
//  seatsio_ios_exampleApp.swift
//  seatsio-ios-example
//
//  Created by Matti Roloux on 06/01/2025.
//

import SwiftUI

@main
struct seatsio_ios_exampleApp: App {
    var body: some Scene {
        WindowGroup {
            Text("Basic configuration").font(.headline)
            ContentView()
            Spacer()
            Text("Prompts API").font(.headline)
            ContentViewWithPromptsAPI()
        }
    }
}
