//
//  ViewController.swift
//  zalopaywebview
//
//  Created by Luu Duc Hoang on 6/10/20.
//  Copyright © 2020 Luu Duc Hoang. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var myWebView: WKWebView!
    
    @IBAction func btnHome(_ sender: Any) {
        markToWebView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        markToWebView()
        // Do any additional setup after loading the view.
    }
    
    func markToWebView() {
         self.myWebView.uiDelegate = self
         self.myWebView.navigationDelegate = self
         
         // This orderURL is value after create order success with ZaloPay Gateway
         let orderURL = "https://sbgateway.zalopay.vn/openinapp?order=eyJ6cHRyYW5zdG9rZW4iOiIyMDA2MTEwMDAwMDI3NzcxZjMyOHYxIiwiYXBwaWQiOjU1M30"
         
         let url = URL(string: orderURL)!
         myWebView.load(URLRequest(url: url))
         myWebView.allowsBackForwardNavigationGestures = true
    }
}
 
//MARK: - WebviewDelegate
extension ViewController: UIWebViewDelegate, WKUIDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let redirectLink = navigationAction.request.url?.absoluteString ?? ""
        
        if redirectLink.contains("zalopay://") || redirectLink.contains("zalopay.api.v2://") {
            if UIApplication.shared.canOpenURL(URL(string: redirectLink)!) {
                UIApplication.shared.open(URL(string: redirectLink)!, options: [:], completionHandler: nil)
            }
        }
        
        decisionHandler(.allow)
    }
}
