//
//  ActivityView.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 05.10.23.
//

import ActivityKit
import SwiftUI

@available(iOS 16.1, *)
struct ActivityView: View {
    @Binding var isActivityEnabled: Bool
    @State private var currentActivity: Activity<TripAppAttributes>?
    
    var body: some View {
        
        Form {
            
            Section("Status") {
                Button("Check permission") {
                    let isEnabled = ActivityAuthorizationInfo().areActivitiesEnabled
                    self.isActivityEnabled = isEnabled
                }
                Label(isActivityEnabled ? "Activity enabled" : "Activity not enabled",
                      systemImage: isActivityEnabled ? "checkmark.circle.fill" : "xmark.circle.fill")
            }
            
            Button("Create live activity") {
                let attributes = TripAppAttributes(shipNumber: "火星へ",
                                                   departureTime: Calendar.current.date(byAdding: .minute, value: -2,
                                                                                        to: Date()) ?? Date())
                let contentState = TripAppAttributes.ContentState(tripStatus: TripAppAttributes.TripStatus.inflight.rawValue,
                                                                  userStopPlanetName: "火星",
                                                                  userCabinNumber: "A12",
                                                                  arrivalTime: Calendar.current.date(byAdding: .minute, value: 8, to: Date()) ?? Date())
                do {
                    self.currentActivity = try Activity<TripAppAttributes>.request(
                        attributes: attributes,
                        contentState: contentState,
                        pushType: nil)
                } catch (let error) {
                    print(error.localizedDescription)
                }
            }
            
            Button("Get on-going activity") {
                let activities = Activity<TripAppAttributes>.activities
                self.currentActivity = activities.first
                
            }
            
            Button("Trip arrival time +10 minutes") {
                Task {
                    guard let currentActivity else { return }
                    let updatedState = TripAppAttributes.ContentState(tripStatus: TripAppAttributes.TripStatus.inflight.rawValue,
                                                                      userStopPlanetName: "火星",
                                                                      userCabinNumber: "火星へ",
                                                                      arrivalTime: Calendar.current.date(byAdding: .minute, value: 10, to: currentActivity.contentState.arrivalTime) ?? Date())
                    await currentActivity.update(using: updatedState)
                }
            }
            
            Button("End activity") {
                Task {
                    guard let currentActivity else { return }
                    let updatedState = TripAppAttributes.ContentState(tripStatus: TripAppAttributes.TripStatus.landed.rawValue,
                                                                      userStopPlanetName: "火星",
                                                                      userCabinNumber: "A12",
                                                                      arrivalTime: currentActivity.contentState.arrivalTime)
                    await currentActivity.end(using: updatedState, dismissalPolicy: .default)
                }
            }
            
        }
        
    }
}
