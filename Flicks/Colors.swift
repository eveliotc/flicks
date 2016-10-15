//
//  Colors.swift
//  Flicks
//
//  Created by Evelio Tarazona on 10/15/16.
//  Copyright © 2016 Evelio Tarazona. All rights reserved.
//

import Foundation
import UIKit

public struct Colors {

    public static var main: UIColor {
        get {
            return UIColor(red: 1, green: 0.91, blue: 0, alpha: 1)
        }
    }
    
    public static var background: UIColor {
        get {
            return UIColor.black
        }
    }
    
    public static var placeholder: UIColor {
        get {
            return UIColor.darkGray
        }
    }
    
    
    public static var great: UIColor {
        get {
            return UIColor(red: 0, green: 200/255, blue: 83/255, alpha: 1)
        }
    }
    
    public static var good: UIColor {
        get {
            return UIColor(red: 76/255, green: 175/255, blue: 80/255, alpha: 1)
        }
    }
    
    public static var average: UIColor {
        get {
            return UIColor.orange
        }
    }
    public static var bad: UIColor {
        get {
            return UIColor.red
        }
    }
}
