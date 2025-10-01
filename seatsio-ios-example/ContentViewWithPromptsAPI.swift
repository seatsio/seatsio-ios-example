//
//  ContentView.swift
//  seatsio-ios-example
//
//  Created by Matti Roloux on 06/01/2025.
//

import SwiftUI
import Seatsio

struct WebViewWithPromptsAPI: UIViewRepresentable {

    func makeUIView(context: Context) -> SeatsioWebView {
        let config: SeatingChartConfig = SeatingChartConfig()
            .workspaceKey("publicDemoKey")
            .event("fa78299a-6b61-4bf3-99c8-8434a79be17e")
            .session("start")
            .pricing(Pricing(
                prices: [
                    Price.priceForCategory(CategoryPricing(category: 13, price: 10, originalPrice: 15.5)),
                    Price.priceForCategory(CategoryPricing(category: 10, ticketTypes: [
                        TicketTypePricing(ticketType: "Adult", price: 20, originalPrice: 25, fee: 3),
                        TicketTypePricing(ticketType: "Child", price: 15, originalPrice: 20, fee: 2.5),
                    ])),
                    Price.priceForObjects(ObjectPricing(objects: ["VIP SEATS-A-1", "VIP SEATS-A-2", "VIP SEATS-A-3"], price: 10, originalPrice: 21.5, fee: 3)),
                    Price.priceForCategory(CategoryPricing(category: 1, price: 30, channels: [
                        ChannelPricing(channel: "b75c212e-0910-44b4-bb0a-98376e49c5b1", price: 10),
                        ChannelPricing(channel: "a2f732a9-c5d4-44f6-92a1-6f7e9b9c6147", ticketTypes: [
                            TicketTypePricing(ticketType: "Adult", price: 20, description: "16 and older", originalPrice: 22, fee: 3),
                            TicketTypePricing(ticketType: "Child", price: 15, originalPrice: 20, fee: 2.5),
                        ])
                    ]))
                ],
                allFeesIncluded: false,
                priceFormatter: { price in String(format: "€%.2f", price) }
            ))
            .onFloorChanged {(floor: Floor?) -> () in
                debugPrint("Floor")
                debugPrint(floor)
            }
            .onObjectSelected({ (object, ticketType) in
                print(object, ticketType ?? "nil")
            })
            .onObjectDeselected({ (object, ticketType) in
                print(object, ticketType ?? "nil")
            })
            .selectedObjects([SelectedObject("VIP SEATS-A-1")])
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
                callback("Adult")
            })
            .onPlacesWithTicketTypesPrompt({ (params, callback) in
                print("onPlacesWithTicketTypesPrompt \(params)")
                // use a dialog here to get the correct value instead of the placeholder choice
                var choice = [String: Int]()
                choice["Adult"] = 2
                callback(choice)
            })


        let extractedExpr: SeatsioWebView = SeatsioWebView(
            frame: UIScreen.main.bounds,
            region: "eu",
            seatsioConfig: config
        )
        extractedExpr.isInspectable = true
        return extractedExpr
    }

    func updateUIView(_ uiView: SeatsioWebView, context: Context) {
    }
}

struct ContentViewWithPromptsAPI: View {
    var body: some View {
        WebViewWithPromptsAPI()
    }
}

#Preview {
    ContentViewWithPromptsAPI()
}
