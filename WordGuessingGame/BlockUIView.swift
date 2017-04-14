//
//  BlockUIView.swift
//  WordMaker
//
//  Created by Eric on 9/12/16.
//  Copyright © 2016 Eric. All rights reserved.
//

import UIKit

class BlockUIView: UIView {
    var shouldListenToEvents: Bool = true;
    let letterLabel: UILabel = UILabel();
    let backgroundImage: UIImageView = UIImageView();
    
    init(letter: String) {
        let screenWidth: CGFloat = UIScreen.main.bounds.size.width
        let screenHeight: CGFloat = UIScreen.main.bounds.size.height
        
        var x = CGFloat(arc4random_uniform(UInt32(screenWidth - 100)))
        var y = CGFloat(arc4random_uniform(UInt32(screenHeight - 300)))
        
        if x < 50 {
            x = 50
        }
        if y < 50 {
            y = 50
        }
        
        super.init(frame: CGRect(x: x, y: y, width: 45, height: 45));
        
        backgroundImage.image = UIImage(named: "wood");
        backgroundImage.frame = CGRect(x: 0, y: 0, width: 45, height: 45);
    
        letterLabel.text = letter;
        letterLabel.font = letterLabel.font.withSize(32);
        letterLabel.textAlignment = NSTextAlignment.center;
        letterLabel.textColor = UIColor.white;
        letterLabel.frame = CGRect(x: 0, y: 0, width: 45, height: 45);
    
        addSubview(backgroundImage);
        addSubview(letterLabel);
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
