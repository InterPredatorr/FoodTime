//
//  ChangeAreaViewModel.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 18.09.23.
//

import SwiftUI

struct AreaInfo: Identifiable {
    var id = UUID()
    let city: String
    let regions: [String]
    var isSelected: Bool
}

class ChangeAreaViewModel: ObservableObject {
    
    @EnvironmentObject var viewHandler: ViewSelectionManager
    @Published var areas: [AreaInfo] = [.init(city: "Kuala Lumpur",
                                              regions: ["Sri Petaling", "Bukit Jalil",
                                                        "Bangsar", "Bukit Bintang"],
                                              isSelected: false),
                                        .init(city: "Cyberjaya",
                                              regions: ["Cyberjaya"],
                                              isSelected: false),
                                        .init(city: "Kajang",
                                              regions: ["Sungai Chua", "Pearl Avenue",
                                                        "Bandar Kajang", "Taman Kajang Mewah"],
                                              isSelected: false)]
    @Published var areaSearchText = ""
}
