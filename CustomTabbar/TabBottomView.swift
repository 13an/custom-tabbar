//
//  TabBottomView.swift
//  CustomTabbar
//
//  Created by 13an on 2023/07/23.
//

import SwiftUI

struct TabBottomView: View {
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    @StateObject private var hapticEngine = HapticEngine()
    let tabbarItems: [TabItemData]
    var height: CGFloat = 48
    var width: CGFloat = UIScreen.main.bounds.width
    @Binding var selectedIndex: Int
    
    var body: some View {
        VStack(spacing: 0) {
            Rectangle().frame(width: width,height: 1).foregroundColor(.black)
            HStack(spacing: 0) {
                Spacer()
                
                ForEach(tabbarItems.indices) { index in
                    let item = tabbarItems[index]
                    Button {
                        self.selectedIndex = index
                    } label: {
                        let isSelected = selectedIndex == index
                        TabItemView(data: item, isSelected: isSelected)
                    }
                    .onLongPressGesture(minimumDuration: 0.1, maximumDistance: .infinity, pressing: { pressing in
                            if pressing {
                                hapticEngine.playHapticsFile(named: "light")
                            }
                        }, perform: {})
                    Spacer()
                }
            }
            .frame(width: width, height: height)
        }
        .padding(.bottom, safeAreaInsets.bottom)
        .background(Color.gray)
        .ignoresSafeArea()
    }
}

struct TabItemData {
    let image: String
    let selectedImage: String
    let title: String
}

struct TabItemView: View {
    let data: TabItemData
    let isSelected: Bool
    
    var body: some View {
        VStack {
            VStack {
                Spacer().frame(height: 8)

                Image(isSelected ? data.selectedImage : data.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
                
                Spacer().frame(height: 4)
                
                Text(data.title)
                    .foregroundColor(isSelected ? .black : .gray)
                    .font(.system(size: 14))
            }
            .frame(maxWidth: .infinity)
        }
    }
}

struct TabBottomView_Previews: PreviewProvider {
    static var previews: some View {
        TabBottomView(tabbarItems: [
            TabItemData(image: "globe-america-ontlined", selectedImage: "globe-america-filled", title: "map"),
            TabItemData(image: "message-outlined", selectedImage: "message-filled", title: "message"),
            TabItemData(image: "person-outlined", selectedImage: "person-filled", title: "profile"),
        ], selectedIndex: .constant(0))
    }
}
