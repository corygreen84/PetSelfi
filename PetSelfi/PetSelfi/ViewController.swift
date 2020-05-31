//
//  ViewController.swift
//  PetSelfi
//
//  Created by Cory Green on 5/30/20.
//  Copyright © 2020 Cory Green. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet weak var mainScene: ARSCNView!
    
    var bottomRotarySelector:BottomRotarySelector?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainScene.delegate = self
        mainScene.showsStatistics = true
        
        // coloring the navigation bar //
        self.navigationController?.navigationBar.barTintColor = Colors.sharedInstance.orangeColor
        
        bottomRotarySelector = BottomRotarySelector(view: self.view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let config = ARFaceTrackingConfiguration()
        config.isLightEstimationEnabled = true
        mainScene.session.run(config, options: [.resetTracking, .removeExistingAnchors])
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        mainScene.session.pause()
    }


}

