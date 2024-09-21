//
//  SettingsView.swift
//  MoviesApp
//
//  Created by Leonardo on 9/21/24.
//

import SwiftUI

struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()

    var body: some View {
        NavigationStack {
            List {
                Section {
                    Toggle("Mock movies", isOn: $viewModel.debug)
                } header: {
                    Text("Debug")
                } footer: {
                    Text("""
                        When active, the movies service will load mocks instead of making requests.
                        This facilitates debugging with breakpoints in the simulator.
                        """
                    )
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    SettingsView()
}
