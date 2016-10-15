//
//  VoteView.swift
//  Flicks
//
//  Created by Evelio Tarazona on 10/16/16.
//  Copyright © 2016 Evelio Tarazona. All rights reserved.
//

import UIKit

@IBDesignable
class VoteView: UILabel {

    convenience init() {
        self.init(frame: CGRect.zero)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    private func setup() {
        layer.masksToBounds = true
        layer.cornerRadius = 8.0
    }
    
    @IBInspectable public var voteAverage: Float = 0 {
        didSet {
            self.text = String(format: "%.1f", voteAverage)
            
            isHidden = false
            switch voteAverage {
            case let x where x >= 7.5:
                self.backgroundColor = Colors.great
                break
            case let x where x >= 6.0:
                self.backgroundColor = Colors.good
                break
            case let x where x >= 4.0:
                self.backgroundColor = Colors.average
            case let x where x >= 0.1:
                self.backgroundColor = Colors.bad
            default:
                isHidden = true
            }
        }
    }

}
