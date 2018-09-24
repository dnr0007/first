//
//  Login.swift
//  Module
//
//  Created by vishal singh on 06/09/18.
//  Copyright © 2018 vishal singh. All rights reserved.
//

import UIKit

class Login: Default {


    @IBOutlet weak var login_btn: UIButton!
    @IBOutlet weak var register_btn: UIButton!
    @IBOutlet weak var userimg_view: UIView!
    @IBOutlet weak var passimg_view: UIView!
    @IBOutlet weak var email_view: UIView!
    @IBOutlet weak var password_view: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        createGradientLayer(view: login_btn)
        createGradientLayer(view: register_btn)
        createGradientLayerView(view: userimg_view)
        createGradientLayerView(view: passimg_view)
    }
   

    @IBAction func registerAction(_ sender: UIButton) {
        performSegue(withIdentifier: "register", sender: self)
    }
    

}
