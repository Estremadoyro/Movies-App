//
//  WebViewSwiftUI.swift
//  MoviesApp
//
//  Created by Leonardo on 9/22/24.
//

import SwiftUI
import WebKit

struct WebViewSwiftUI: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        WKWebView()
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
