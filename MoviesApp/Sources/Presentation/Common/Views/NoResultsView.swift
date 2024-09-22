//
//  NoResultsView.swift
//  MoviesApp
//
//  Created by Leonardo on 9/21/24.
//

import SwiftUI


struct NoResultsView: View {
    var style: NoResultsStyle
    
    var body: some View {
        VStack(spacing: 16) {
            Image.noResults
                .resizable()
                .frame(width: 80, height: 80)
            Text("We Are Sorry, We Can\nNot Find The Movie :(")
                .font(.title2)
                .bold()
            Text(style.subtitle)
                .multilineTextAlignment(.center)
                .foregroundStyle(.gray)
                .font(.callout)
        }
    }
}

#Preview {
    NoResultsView(style: .homeFilter)
}
