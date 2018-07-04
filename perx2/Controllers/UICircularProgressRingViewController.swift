
//
//  LocProgressViewController.swift
//  perx2
//
//  Created by Montreaux Rodgers on 7/3/18.
//  Copyright © 2018 Montreaux Rodgers. All rights reserved.
//

import UIKit
import UICircularProgressRing


class UICircularProgressRingViewController: UIViewController {

 
    @IBOutlet weak var progressRing: UICircularProgressRing!
    override func viewDidLoad() {
        // Create the view
        let progressRing = UICircularProgressRing(frame: CGRect(x: 0, y: 0, width: 240, height: 240))
        // Change any of the properties you'd like
        progressRing.maxValue = 50
        progressRing.innerRingColor = UIColor.blue
        // etc ..
    

        // Somewhere not in viewDidLoad (since the views have not set yet, thus cannot be animated)
        // Remember to use unowned or weak self if refrencing self to avoid retain cycle
        progressRing.startProgress(to: 49, duration: 2.0) {
            print("Done animating!")
            // Do anything your heart desires...
    
        
        // Pause at any time during a running animation
        progressRing.pauseProgress()
        
        // Continue where you left off after a pause
        progressRing.continueProgress()
    
        // Do any additional setup after loading the view.
    }
}
}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


