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
        let projectPaths = NSProcessInfo.processInfo().environment["IB_PROJECT_SOURCE_DIRECTORIES"].componentsSeparatedByString(",")
        if projectPaths.count > 0 {
            if let projectPath = projectPaths[0] as? String {
                let imagePath = projectPath.stringByAppendingPathComponent("TestImages/topo.png")
                println(imagePath)
                ibDesignerImage = UIImage(contentsOfFile: imagePath)
            }
        }
    }
}

