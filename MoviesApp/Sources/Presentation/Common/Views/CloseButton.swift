//
//  CloseButton.swift
//  MoviesApp
//
//  Created by Leonardo on 9/22/24.
//

import SwiftUI

struct CloseButton: View {
    @Environment(\.dismiss) private var dismiss
    var side: CGFloat = 24
    var action: (() -> Void)? = nil

    var body: some View {
        SafeButton {
            if let action {
                action()
            } else {
                dismiss()
            }
        } label: {
            Image.xMarkCircleFill
                .font(.system(size: side))
                .foregroundStyle(.gray, .gray.opacity(0.2))
        }
    }
}

#Preview {
    Text("background")
        .sheet(isPresented: .constant(true)) {
            NavigationStack {
                Text("Sheet")
                    .navigationTitle("Close Button")
                    .navigationBarTitleDisplayMode(.inline)
                    .addToolBarItem(placement: .topBarTrailing, view: {
                        CloseButton()
                    })
            }
        }
}
