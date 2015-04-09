//
//  DesignableView.swift
//  BladeKit
//
//  Original by Kristin
//  Migrated to BladeKit by Doug on 4/6/15.
//  Copyright (c) 2015 Blade. All rights reserved.
//

import UIKit

public class DesignableView: UIView {
    
    var view: UIView!
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        loadXib()
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadXib()
    }
    
    private func loadXib() {
        
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: xibName(), bundle: bundle)
        
        // Assumes UIView is top level and only object in .xib file
        view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        
        // use bounds not frame or it'll be offset
        view.frame = bounds
        
        // Make the view stretch with containing view
        view.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        
        // Do any custom setup
        xibSetup()
        
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(view)
    }
    
    // This must be overridden in subclass
    public func xibName() -> String {
        fatalError("xibName() has not been implemented")
    }
    
    // Override if you need a hook for additional setup after .xib is loaded
    public func xibSetup() {
    }
}
