//
//  WalkItem.swift
//  testWalkThrought
//
//  Created by MacSivsa on 07/05/2019.
//  Copyright © 2019 PSA. All rights reserved.
//

import Foundation
import UIKit


public class WalkItem: NSObject {
    
    var imageCenter: UIImage = UIImage()
    var bottomImage: UIImage = UIImage()
    var labelTittle: String = ""
    var labelDescription: String = ""
    
    
    public override init(){
        super.init()
    }
    
    
    public func initWith(imageCenter: UIImage, imageBottom: UIImage, tittle: String, description: String){
        self.imageCenter = imageCenter
        self.bottomImage = imageBottom
        self.labelTittle = tittle
        self.labelDescription = description
    }
    
}


