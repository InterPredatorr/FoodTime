//
//  ContentView.swift
//  a
//
//  Created by Sevak Tadevosyan on 30.09.23.
//

import SwiftUI

enum Types: String, CaseIterable {
    case a
    case b
    case c
}

struct ContentView: View {
    
    var a = 10
    
    
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .frame(width: 100, height: 100)
                    .scaleEffect(size)
//                    .rotation(.degrees(angle))
                
            }
        }
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
                size -= 5
            }
        }
    }
}

#Preview {
    ContentView()
}
