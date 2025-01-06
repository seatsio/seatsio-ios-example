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
            .pricing([
                Pricing(category: "1", price: 1)
            ])
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
