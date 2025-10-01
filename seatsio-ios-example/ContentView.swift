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

struct ContentView: View {
    var body: some View {
        WebView()
    }
}

#Preview {
    ContentView()
}
