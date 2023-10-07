//
//  RefreshableScrollView.swift
//  XChange
//
//  Created by Aldo Vernando on 07/10/23.
//

/**
 This file defines the `RefreshableScrollView` view, which is a SwiftUI-based custom scroll view with pull-to-refresh functionality. This documentation provides an overview of the `RefreshableScrollView` view and its functionality.
 
 ### Properties
 - `refresh`: A state property that indicates whether the refresh action is in progress.
 - `coordinateSpace`: The coordinate space used for calculating the scroll view's position.
 - `onRefresh`: A closure to be executed when the pull-to-refresh action is triggered.
 
 ### Functionality
 The `RefreshableScrollView` view enhances the user experience by allowing users to pull down the scroll view to trigger a refresh action. When the user pulls down the scroll view, the `onRefresh` closure is executed.
 */

import SwiftUI

struct RefreshableScrollView: View {
    @State var refresh: Bool = false
    
    var coordinateSpace: CoordinateSpace
    var onRefresh: () -> Void
    
    var body: some View {
        GeometryReader { geo in
            if geo.frame(in: coordinateSpace).midY > 50 {
                Spacer()
                    .onAppear {
                        if refresh == false {
                            onRefresh()
                        }
                        refresh = true
                    }
            } else if geo.frame(in: coordinateSpace).maxY < 1 {
                Spacer()
                    .onAppear {
                        refresh = false
                    }
            }
            
            ZStack(alignment: .center) {
                if refresh {
                    ProgressView()
                } else {
                    ForEach(0..<8) { tick in
                        VStack {
                            Rectangle()
                                .fill(Color(UIColor.tertiaryLabel))
                                .opacity((Int((geo.frame(in: coordinateSpace).midY)/7) < tick) ? 0 : 1)
                                .frame(width: 3, height: 7)
                                .cornerRadius(3)
                            
                            Spacer()
                        }
                        .rotationEffect(Angle.degrees(Double(tick)/(8) * 360))
                    }
                    .frame(width: 20, height: 20, alignment: .center)
                }
            }
            .frame(width: geo.size.width)
        }
        .padding(.top, -50)
    }
}
