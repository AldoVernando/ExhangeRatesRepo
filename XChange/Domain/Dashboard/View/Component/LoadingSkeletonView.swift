//
//  LoadingSkeletonView.swift
//  XChange
//
//  Created by Aldo Vernando on 08/10/23.
//

import SwiftUI

/// A SwiftUI view for displaying a loading skeleton animation.
struct LoadingSkeletonView: View {
    /// A timer for controlling the skeleton animation.
    private let timer = Timer.publish(every: 0.5, on: .current, in: .common).autoconnect()

    /// The minimum opacity for skeleton elements.
    private let minOpacity: Double = 0.25
    /// The maximum opacity for skeleton elements.
    private let maxOpacity: Double = 1.0
    
    /// A flag to toggle opacity during animation.
    @State private var flag: Bool = false
    /// The opacity for skeleton elements.
    @State private var opacity: Double = 0.25
    
    var body: some View {
        VStack {
            ForEach(0..<8) { _ in
                loaderItemView()
            }
        }
        .padding(.horizontal, 8)
        .onReceive(timer) { value in
            opacity = flag ? minOpacity : maxOpacity
            flag.toggle()
        }
    }
}

extension LoadingSkeletonView {
    
    /// Creates a view for a single loader item.
    @ViewBuilder private func loaderItemView() -> some View {
        Rectangle()
            .fill(.white)
            .shadow(radius: 0.5)
            .frame(height: 85)
            .cornerRadius(16)
            .opacity(opacity)
            .transition(.opacity)
            .animation(.easeInOut(duration: 1.0))
    }
}

struct LoadingSkeletonView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingSkeletonView()
    }
}
