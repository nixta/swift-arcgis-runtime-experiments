//
//  AGSDesignableMapView.swift
//  SwiftMap
//
//  Created by Nicholas Furness on 6/21/14.
//  Copyright (c) 2014 Esri. All rights reserved.
//

import QuartzCore
import UIKit
import ArcGIS

@IBDesignable
class AGSDesignableMapView: AGSMapView {
    var image:UIImage?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let i = image {
            var backdropLayer = CALayer()
            backdropLayer.frame = layer.bounds
            backdropLayer.contentsGravity = kCAGravityResizeAspectFill
            layer.addSublayer(backdropLayer)
            
            backdropLayer.contents = i.CGImage
        }
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        let projectPaths = NSProcessInfo.processInfo().environment["IB_PROJECT_SOURCE_DIRECTORIES"].componentsSeparatedByString(",")
        if projectPaths.count > 0 {
            if let projectPath = projectPaths[0] as? String {
                let imagePath = projectPath.stringByAppendingPathComponent("TestImages/topo.png")
                println(imagePath)
                image = UIImage(contentsOfFile: imagePath)
            }
        }
    }
}

