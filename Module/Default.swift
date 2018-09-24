//
//  Default.swift
//  Module
//
//  Created by vishal singh on 07/09/18.
//  Copyright © 2018 vishal singh. All rights reserved.
//

import UIKit

class Default: UIViewController {
    
    // Variables
    var gradientLayer: CAGradientLayer!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func createGradientLayer(view: UIButton) {
        gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = view.bounds
        
        gradientLayer.colors = [UIColor(red:0.23, green:0.52, blue:0.81, alpha:1.0).cgColor,
                                UIColor(red:0.33, green:0.62, blue:0.85, alpha:1.0).cgColor,
                                UIColor(red:0.48, green:0.75, blue:0.90, alpha:1.0).cgColor]
        
        view.layer.addSublayer(gradientLayer)
    }
    func createGradientLayerView(view: UIView) {
        gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = view.bounds
        
        gradientLayer.colors = [UIColor(red:0.23, green:0.52, blue:0.81, alpha:1.0).cgColor,
                                UIColor(red:0.33, green:0.62, blue:0.85, alpha:1.0).cgColor,
                                UIColor(red:0.48, green:0.75, blue:0.90, alpha:1.0).cgColor]
        
        view.layer.addSublayer(gradientLayer)
    }


}
