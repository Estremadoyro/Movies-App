//
//  WebView.swift
//  MoviesApp
//
//  Created by Leonardo on 9/22/24.
//

import SwiftUI

struct TrailerView: View {
    var url: URL
    
    var body: some View {
        NavigationStack {
            WebViewSwiftUI(url: url)
                .navigationTitle("Trailer")
                .navigationBarTitleDisplayMode(.inline)
                .addToolBarItem(placement: .topBarTrailing, view: CloseButton())
        }
    }
}

#Preview {
    Text("background")
        .sheet(isPresented: .constant(true)) {
            TrailerView(url: URL(string: "https://www.youtube.com/watch?v=lAbnZvqJdYA")!)
        }
}
