//
//  ContentView.swift
//  seatsio-ios-example
//
//  Created by Matti Roloux on 06/01/2025.
//

import SwiftUI
import Seatsio

struct WebView: UIViewRepresentable {

    func makeUIView(context: Context) -> SeatsioWebView {
        let config: SeatingChartConfig = SeatingChartConfig()
            .workspaceKey("publicDemoKey")
            .event("smallTheatreWithGAEvent")
            .session("start")
            .onObjectSelected({ (object, ticketType) in
                print(object, ticketType ?? "nil")
            })
            .onObjectDeselected({ (object, ticketType) in
                print(object, ticketType ?? "nil")
            })
            .selectedObjects([SelectedObject("A-1")])
            .onChartRendered({ (chart) in
                print("rendered")
                chart.getReportBySelectability({ (report) in print(report)})
                chart.changeConfig(ConfigChange(unavailableCategories: ["Balcony"]))
                chart.isObjectInChannel("K-3", "NO_CHANNEL", { (result) in print("Is object in channel NO_CHANNEL? " + String(result)) })
            })
            .categoryFilter(CategoryFilter(enabled: true))
            .onHoldCallsInProgress({ () in
                print("hold calls in progress")
            })
            .onHoldCallsComplete({ () in
                print("hold calls complete")
            })
            .onPlacesPrompt({ (params, callback) in
                print("onPlacesPrompt \(params)")
                // use a dialog here to get the correct value instead of the placeholder 3
                callback(3)
            })
            .onTicketTypePrompt({ (params, callback) in
                print("onTicketTypePrompt \(params)")
                // use a dialog here to get the correct value instead of the placeholder "adult"
                callback("adult")
            })
            .onPlacesWithTicketTypesPrompt({ (params, callback) in
                print("onPlacesWithTicketTypesPrompt \(params)")
                // use a dialog here to get the correct value instead of the placeholder choice
                var choice = [String: Int]()
                choice["adult"] = 2
                callback(choice)
            })

        return SeatsioWebView(
            frame: UIScreen.main.bounds,
            region: "eu",
            seatsioConfig: config
        )
    }

    func updateUIView(_ uiView: SeatsioWebView, context: Context) {
    }
}

struct ContentView: View {
    var body: some View {
        WebView()
    }
}

#Preview {
    ContentView()
}
