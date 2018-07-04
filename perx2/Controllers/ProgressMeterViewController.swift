//
//  ProgressMeterViewController.swift
//  perx2
//
//  Created by Montreaux Rodgers on 7/4/18.
//  Copyright © 2018 Montreaux Rodgers. All rights reserved.
//

import UIKit
import ProgressMeter

class ProgressMeterViewController: UIViewController {

    @IBOutlet weak var progressControl: ProgressMeter!
    override func viewDidLoad() {
        super.viewDidLoad()
        func setupWithCustomData() {
            progressControl.maxValue = 20000
            progressControl.data = [1999, 4999, 9999, 14999]
            progressControl.progress = 14999 / 20000
            
        }
        func visualSetup() {
            progressControl.progressTintColor = .purple
            progressControl.trackTintColor = .gray
            progressControl.borderWidth = 1
            progressControl.borderColor = .darkGray
            progressControl.annotationTextColor = .purple
            progressControl.dividerColor = .darkGray
        }
        
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
