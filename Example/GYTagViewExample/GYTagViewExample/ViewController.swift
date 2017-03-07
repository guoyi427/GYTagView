//
//  ViewController.swift
//  GYTagViewExample
//
//  Created by kokozu on 2017/3/7.
//  Copyright © 2017年 guoyi. All rights reserved.
//

import UIKit

import GYTagViewSDK

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let frame = CGRect(x: 0, y: 100, width: view.frame.width, height: view.frame.height - 120)
        var tags:[String] = []
        
        for index in 0...50 {
            tags.append("abcd\(index)")
        }
        
        let myTagView = GYTagView(frame: frame, tags: tags)
        view.addSubview(myTagView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

