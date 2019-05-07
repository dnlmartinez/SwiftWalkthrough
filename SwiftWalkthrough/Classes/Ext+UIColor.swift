//
//  Ext+UIColor.swift
//  testWalkThrought
//
//  Created by MacSivsa on 07/05/2019.
//  Copyright © 2019 PSA. All rights reserved.
//

import Foundation
import UIKit


extension UIColor {
    
    public static var linkColor = UIColor.init(hexFromString: "#2861cc")
    
    public static var primary = UIColor.init(hexFromString: "#1B365D")
    
    public static var colorAccent = UIColor.init(hexFromString:"#4698cb")
    
    convenience init(hexFromString:String, alpha:CGFloat = 1.0){
        
        var cString:String = hexFromString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        var rgbValue:UInt32 = 10066329
        
        if (cString.hasPrefix("#")){ cString.remove(at: cString.startIndex) }
        
        if ((cString.count) == 6) { Scanner(string: cString).scanHexInt32(&rgbValue) }
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}
