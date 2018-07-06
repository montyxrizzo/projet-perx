//
//  HomescreenViewController.swift
//  perx2
//
//  Created by Montreaux Rodgers on 7/6/18.
//  Copyright © 2018 Montreaux Rodgers. All rights reserved.
//

import UIKit

class HomescreenViewController: UIViewController {
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var passwordLabel: UILabel!
    
    
    var firstDataPass: String!
    var secondDataPass: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameLabel.text = firstDataPass
        passwordLabel.text = secondDataPass

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
