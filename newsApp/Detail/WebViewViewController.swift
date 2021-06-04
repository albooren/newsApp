//
//  WebViewViewController.swift
//  newsApp
//
//  Created by Alperen Kişi on 03/06/2021.
//

import UIKit
import WebKit

class WebViewViewController: UIViewController {
    
    
    private let webView : WKWebView = {
        let preferences =  WKWebpagePreferences()
        preferences.allowsContentJavaScript = true
        let configuration = WKWebViewConfiguration()
        configuration.defaultWebpagePreferences = preferences
        let webView = WKWebView(frame: .zero, configuration: configuration)
        return webView
    }()
    private let url: URL
    
    init(url:URL,title:String) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
        self.title = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        webView.load(URLRequest(url: url))

    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
    
}
