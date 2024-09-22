//
//  ReusableProgressView.swift
//  MoviesApp
//
//  Created by Leonardo on 9/22/24.
//

import SwiftUI

struct ReusableProgressView: View {
    @State private var id: Int = 0

    var body: some View {
        ProgressView()
            .id(id)
            .onAppear {
                id += 1
            }
    }
}
