//
//  SecondViewController.swift
//  Test
//
//  Created by Sandeep Ahuja on 5/17/19.
//  Copyright © 2019 Sandeep Ahuja. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    var alpha2 = ""
    var alpha3 = ""
    
    @IBOutlet weak var codeLbl: UILabel!
    @IBOutlet weak var codeLbl2: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.codeLbl.text = alpha2
        self.codeLbl2.text = alpha3
        
    }
    


}
