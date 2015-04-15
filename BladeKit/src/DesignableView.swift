//
//  DesignableView.swift
//  BladeKit
//
//  Original by Kristin
//  Migrated to BladeKit by Doug on 4/6/15.
//  Copyright (c) 2015 Blade. All rights reserved.
//
//  Base class for all IBDesignables.
//

import UIKit

public class DesignableView: UIView {
    
    public var view: UIView!
    
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
        let xib = UINib(nibName: xibName(), bundle: bundle)
        
        // Assumes UIView is top level and only object in .xib file
        view = xib.instantiateWithOwner(self, options: nil)[0] as! UIView
        
        // use bounds not frame or it'll be offset
        view.frame = bounds
        
        // Make the view stretch with containing view
        view.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        
        // Do any custom setup
        xibSetup()
        
        // Add view we just loaded from .xib to ourself
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
