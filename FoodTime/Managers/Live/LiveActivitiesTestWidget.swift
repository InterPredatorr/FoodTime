//
//  LiveActivitiesTestWidget.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 05.10.23.
//

import WidgetKit
import SwiftUI
import Intents
import ActivityKit

@available(iOS 16.1, *)
struct LiveActivitiesTestWidgetEntryView: View {
    @State var attribute: TripAppAttributes
    @State var state: TripAppAttributes.ContentState

    var body: some View {
        VStack(alignment: .center) {
            HStack {
                Label("Ship number", systemImage: "moon.stars")
                Spacer()
                Text(attribute.shipNumber)
            }
            HStack {
                Label("Your stop", systemImage: "lanyardcard")
                Spacer()
                Text(state.userStopPlanetName)
            }
            switch TripAppAttributes.TripStatus(rawValue: state.tripStatus) {
            case .predeparture:
                HStack {
                    Label("Your cabin", systemImage: "person.fill")
                    Spacer()
                    Text(state.userCabinNumber)
                        .font(.title3.bold())
                }
            case .inflight:
                Label("Time to destination", systemImage: "clock")
                Text(state.arrivalTime, style: .timer)
                    .font(.largeTitle)
            case .landed:
                Label("Landed", systemImage: "checkmark.circle.fill")
                    .foregroundColor(.green)
                    .font(.title3)
                Text("Thanks for traveling with us!")
                    .font(.headline)
            default:
                Text("Unknown trip status")
            }
            
        }
        .padding()
    }
}

//@main
@available(iOS 16.1, *)
struct LiveActivitiesTestWidget: Widget {
    let kind: String = "LiveActivitiesTestWidget"

    var body: some WidgetConfiguration {
        ActivityConfiguration(for: TripAppAttributes.self) { context in
            LiveActivitiesTestWidgetEntryView(attribute: context.attributes,
                                              state: context.state)
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    Text("🚀")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text(context.state.arrivalTime, style: .timer)
                        .font(.caption2)
                }
                DynamicIslandExpandedRegion(.center) {
                    Text("次の目的地は\(context.state.userStopPlanetName)です。")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Button("宇宙機アクセスバッジ") {
                        return
                    }.buttonStyle(.borderedProminent)
                }
            } compactLeading: {
                Text("🚀 - \(context.attributes.shipNumber)")
            } compactTrailing: {
                Text(context.state.arrivalTime, style: .relative)
                    .frame(width: 50)
                    .monospacedDigit()
                    .font(.caption2)
            } minimal: {
                ViewThatFits {
                    Text("🚀")
                    Text("context.state.arrivalTime, style: .relative")
                }
            }
        }
    }
}

struct TripAppAttributes: ActivityAttributes {
    
    enum TripStatus: String {
        case predeparture
        case inflight
        case landed
    }

    public struct ContentState: Codable, Hashable {
        var tripStatus: String
        var userStopPlanetName: String
        var userCabinNumber: String
        var arrivalTime: Date
    }
    
    var shipNumber: String
    var departureTime: Date
    
}
