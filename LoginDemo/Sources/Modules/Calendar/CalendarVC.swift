//
//  CalendarVC.swift
//  LoginDemo
//
//  Created by Bob on 29/11/2019.
//  Copyright © 2019 Bob. All rights reserved.
//

import UIKit
import WebKit

class CalendarVC: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://labs.coruscantconsulting.co.uk/life/weeks/")!
        let request = URLRequest(url: url)
        webView.load(request)
        
    }
    
    @IBAction func close() {
        dismiss(animated: true, completion: nil)
    }
}
