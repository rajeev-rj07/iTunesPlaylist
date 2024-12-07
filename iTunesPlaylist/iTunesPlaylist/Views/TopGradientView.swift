//
//  TopGradientView.swift
//  iTunesPlaylist
//
//  Created by Rajeev Kulariya on 07/12/24.
//

import SwiftUI

struct TopGradientView: View {
    var height: CGFloat
    var color: Color

    var body: some View {
      Rectangle()
        .fill(LinearGradient(gradient: Gradient(colors: [color.opacity(0.6),
                                                         color.opacity(0.3),
                                                         color.opacity(0.0)]),
                             startPoint: .top,
                             endPoint: .bottom))
        .frame(height: height)
    }
  }


#Preview {
  TopGradientView(height: 250, color: Color(hex: "#5628F8"))
}
