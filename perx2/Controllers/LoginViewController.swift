//
//  LoginViewController.swift
//  perx2
//
//  Created by Montreaux Rodgers on 7/6/18.
//  Copyright © 2018 Montreaux Rodgers. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var usernameField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "loginSubmitSegue") {
            let svc = segue.destination as! HomescreenViewController
            svc.firstDataPass = usernameField.text
            svc.secondDataPass = passwordField.text
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view control ler.
    }
 

}
