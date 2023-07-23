//
//  MainTabView.swift
//  CustomTabbar
//
//  Created by 13an on 2023/07/23.
//

import SwiftUI

struct MainTabView: View {
    
    @State var selectedIndex: Int = 0
    
    var body: some View {
        CustomTabView(tabs: TabType.allCases.map({ $0.tabItem }), selectedIndex: $selectedIndex) { index in
            let type = TabType(rawValue: index) ?? ._1
            getTabView(type: type)
        }
    }
    
    @ViewBuilder
    func getTabView(type: TabType) -> some View {
        switch type {
        case ._1:
            _1()
        case ._2:
            _2()
        case ._3:
            _3()
        }
    }
}

enum TabType: Int, CaseIterable {
    case _1 = 0
    case _2
    case _3
    
    var tabItem: TabItemData {
        switch self {
        case ._1:
            return TabItemData(image: "globe-america-ontlined", selectedImage: "globe-america-filled", title: "home")
        case ._2:
            return TabItemData(image: "message-outlined", selectedImage: "message-filled", title: "home")
        case ._3:
            return TabItemData(image: "person-outlined", selectedImage: "person-filled", title: "home")
        }
    }
}

struct CustomTabView<Content: View>: View {
    
    let tabs: [TabItemData]
    @Binding var selectedIndex: Int
    @ViewBuilder let content: (Int) -> Content
    
    var body: some View {
        ZStack {
            TabView(selection: $selectedIndex) {
                ForEach(tabs.indices) { index in
                    content(index)
                        .tag(index)
                }
            }
            
            VStack {
                Spacer()
                TabBottomView(tabbarItems: tabs, selectedIndex: $selectedIndex)
            }
            .padding(.bottom, 8)
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
