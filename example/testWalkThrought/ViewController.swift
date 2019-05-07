//
//  ViewController.swift
//  testWalkThrought
//
//  Created by MacSivsa on 06/05/2019.
//  Copyright © 2019 PSA. All rights reserved.
//

import UIKit
import SwiftWalkthrough


class ViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.showWalkthrought()
    }
    
    @IBAction func show(_ sender: Any) {
        self.showWalkthrought()
    }
    
    func showWalkthrought(){
        DispatchQueue.main.async {
            let customView : WalkThroughtController = WalkThroughtController()
            
            customView.initPagesWithItems(items: self.getPages())
            customView.setSkipButtonText(text: "Skip")
            
            customView.presentOn(presentingViewController: self) {
                print("END")
            }
        }
    }
    
    func getPages()->[WalkItem]{
        let item1 = WalkItem()
        item1.initWith(imageCenter: UIImage(named: "psa-avatar")!, imageBottom: UIImage(named: "iPhoneScreen")!, tittle: "Tittle 1", description: "Description 1")
        
        let item2 = WalkItem()
        item2.initWith(imageCenter: UIImage(named: "psa-avatar")!, imageBottom: UIImage(named: "iPhoneScreen")!, tittle: "Tittle 2", description: "Description 2")

        let item3 = WalkItem()
        item3.initWith(imageCenter: UIImage(named: "psa-avatar")!, imageBottom: UIImage(named: "iPhoneScreen")!, tittle: "Tittle 3", description: "Description 3")
        
        return [item1, item2, item3]
    }
    
}

