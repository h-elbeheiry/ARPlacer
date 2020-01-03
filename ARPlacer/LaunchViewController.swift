
//
//  LaunchViewController.swift
//  ARPlacer
//
//  Created by Hussein AlBehary on 5/8/18.
//  Copyright © 2018 HUSSEIN ELBEHEIRY. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {
    
    var gameTimer: Timer! //Timer object

    override func viewDidLoad() {
        super.viewDidLoad()
        // Timer to move to the next view
        gameTimer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(timeaction), userInfo: nil, repeats: true)
    }
    
    //Timer action
    @objc func timeaction(){
        //code for move next VC
        performSegue(withIdentifier: "toSceneView", sender: nil)
        
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
