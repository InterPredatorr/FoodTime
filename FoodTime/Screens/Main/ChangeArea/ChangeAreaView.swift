//
//  ChangeAreaView.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 12.09.23.
//

import SwiftUI

struct ChangeAreaView: View {
    
    @EnvironmentObject var viewHandler: ViewSelectionManager
    @ObservedObject var viewModel: ChangeAreaViewModel
    @State private var contentRequestState: ButtonState = .pending
    let config = SettingsManager.shared.screens.changeArea
    var body: some View {
        ScrollView(showsIndicators: false) {
            ContentHeaderView(title: config.title)
            if contentRequestState == .ready {
                contentView
            } else {
                pendingView
            }
        }
        .rootViewSetup()
    }
}

extension ChangeAreaView {
    var contentView: some View {
        VStack(spacing: 15) {
            SearchFieldView(placeholder: config.searchPlaceholder, text: $viewModel.areaSearchText)
            VStack(alignment: .leading) {
                if !viewHandler.recentlySearchedAreas.isEmpty {
                    TitleView(title: config.subtitle.localized, fontSize: 20)
                    ForEach(viewHandler.recentlySearchedAreas, id: \.self) { region in
                        AreaRegionItemView(region: region) { selectedRegion in
                            withAnimation {
                                viewHandler.addNewRegion(selectedRegion)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                ForEach($viewModel.areas) { area in
                    AreaSectionView(area: area) { region in
                        withAnimation {
                            viewHandler.addNewRegion(region)
                        }
                    }
                }
            }
            Spacer()
        }
        .padding(.horizontal, Constants.screenPadding)

    }
    
    var pendingView: some View {
        ListSkeletonView(count: 20)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation {
                        contentRequestState = .ready
                    }
                }
            }
            .padding(.all, Constants.screenPadding)
    }
}

struct AreaSectionView: View {
    
    @Binding var area: AreaInfo
    let cornerRadius: CGFloat = 12
    let onSelect: (String) -> Void
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Image(systemName: Images.triangleRight)
                    .rotationEffect(.degrees(area.isSelected ? 90 : 0))
                    .foregroundColor(.textPrimary)
                Text(area.city + " (\(area.regions.count))")
                    .foregroundColor(area.isSelected ? .mainWhite : .textPrimary)
                Spacer()
            }
            .frame(height: 45)
            .padding(.horizontal, cornerRadius)
            .background(area.isSelected ? Color.mainColor : Color.mainWhite)
            .cornerRadius(cornerRadius)
            .onTapGesture {
                withAnimation {
                    area.isSelected.toggle()
                }
            }
            VStack(spacing: 3) {
                if area.isSelected {
                    ForEach(area.regions, id: \.self) { region in
                        AreaRegionItemView(region: region) { selectedRegion in
                            onSelect(selectedRegion)
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
        .foregroundColor(.textPrimary)
    }
}

private struct AreaRegionItemView: View {
    
    let region: String
    let onSelect: (String) -> Void
    
    var body: some View {
        TitleView(title: region, color: .textPrimary, fontSize: 20)
            .frame(height: 40)
            .padding(.horizontal)
            .background(Color.mainGrayDark.opacity(0.5))
            .cornerRadius(Constants.cornerRadius)
            .onTapGesture { onSelect(region) }
    }
}

struct ChangeAreaView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeAreaView(viewModel: .init())
    }
}
