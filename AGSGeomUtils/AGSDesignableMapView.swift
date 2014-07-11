//
//  AGSDesignableMapView.swift
//  SwiftMap
//
//  Created by Nicholas Furness on 6/21/14.
//  Copyright (c) 2014 Esri. All rights reserved.
//

import QuartzCore

@IBDesignable class AGSDesignableMapView: AGSMapView {
    var ibDesignerImage:UIImage?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Only do anything if ibDesignerImage is set, which it only will be if 
        // prepareForInterfaceBuilder has been called. So, do nothing at runtime.
        if let i = ibDesignerImage {
            var backdropLayer = CALayer()
            backdropLayer.frame = layer.bounds
            backdropLayer.contentsGravity = kCAGravityResizeAspectFill
            layer.addSublayer(backdropLayer)
            backdropLayer.contents = i.CGImage
        }
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        // Thanks to WWDC Session 411 - What's New in Interface Builder for this resource path trick
        // Xcode6 Beta 3 broke this in all sorts of ways.
        let dirsAny: AnyObject? = NSProcessInfo.processInfo().environment["IB_PROJECT_SOURCE_DIRECTORIES"]
        if let dirsString = dirsAny as? String {
            let projectPaths =  dirsString.componentsSeparatedByString(",")
            if projectPaths.count > 0 {
                let imagePath = projectPaths[0].stringByAppendingPathComponent("TestImages/topo.png")
                println(imagePath)
                ibDesignerImage = UIImage(contentsOfFile: imagePath)
            }
        }
    }
}

