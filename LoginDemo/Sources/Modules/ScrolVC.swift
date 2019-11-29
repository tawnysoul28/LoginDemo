//
//  ScrolVC.swift
//  LoginDemo
//
//  Created by Bob on 16/11/2019.
//  Copyright © 2019 Bob. All rights reserved.
//

import UIKit

class ScrolVC: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollVC: UIScrollView!
    
    private var weeks = [[Int]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.weeks = (0...50).map { _ in Array(repeating: 0, count: 53) } //repeating: 0 -  номер недели
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.scrollVC.delegate = self
        self.fillWeeksView()
     }
    
    func fillWeeksView() {
        let weeksWidth = 40
        let weekHeigh = 40
        let offset = 10
        
        let containerWidth = 53 * (weeksWidth + offset)
        let containerHeight = 50 * (weekHeigh + offset)
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: containerWidth, height: containerHeight))
        
        for yearIndex in self.weeks.indices {
            let startY = yearIndex * (weekHeigh + offset)
            
            for weekIndex in self.weeks[yearIndex].indices {
                let startX = weekIndex * (weeksWidth + offset)
                let item = UIView(frame: CGRect(x: startX, y: startY, width: weeksWidth, height: weekHeigh))
                item.backgroundColor = .gray
                containerView.addSubview(item)
            }
        }
        self.scrollVC.addSubview(containerView)
        self.scrollVC.contentSize = containerView.bounds.size //.contentSize -
        self.scrollVC.minimumZoomScale = 0.01 //потом поменять
        self.scrollVC.minimumZoomScale = 10
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.scrollVC.subviews.first
    }
}
