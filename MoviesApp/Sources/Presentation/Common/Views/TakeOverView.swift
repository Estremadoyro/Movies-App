//
//  NoResultsView.swift
//  MoviesApp
//
//  Created by Leonardo on 9/21/24.
//

import SwiftUI


struct TakeOverView: View {
    var style: TakeOverViewStyle
    
    var body: some View {
        VStack(spacing: 16) {
            style.icon
                .resizable()
                .frame(width: 80, height: 80)
            Text(style.title)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .font(.title2)
                .bold()
                .fixedSize(horizontal: false, vertical: false)
            Text(style.subtitle)
                .multilineTextAlignment(.center)
                .foregroundStyle(.gray)
                .font(.callout)
        }
        .padding(.horizontal)
    }
}

#Preview {
    TakeOverView(style: .start)
}
