//
//  AGSPolyline+bezier.swift
//  SwiftTestbed
//
//  Created by Nicholas Furness on 6/19/14.
//  Copyright (c) 2014 Esri. All rights reserved.
//

extension AGSPolyline: HasBezier {
    func bezierForFrame(frame:CGRect) -> UIBezierPath {
        
        // Translate our AGSPolygon into a UIBezierPath
        var outPath = UIBezierPath()
        for pathIndex in 0..<self.numPaths {
            // Build each ring in turn
            if let firstPtInPath = self.pointOnPath(pathIndex, atIndex: 0)? {
                outPath.moveToPoint(cgPointFromAgsPoint(firstPtInPath))
                for ptIndex in 1..<self.numPointsInPath(pathIndex) {
                    if let pt = self.pointOnPath(pathIndex, atIndex: ptIndex)? {
                        var ptToAdd = cgPointFromAgsPoint(pt)
                        outPath.addLineToPoint(ptToAdd)
                    }
                }
            }
        }
        
        // Scale and shift the geometry to the target frame
        let scaleFactor = min(frame.height/outPath.bounds.height, frame.width/outPath.bounds.width)
        let objectCenterTransform = CGAffineTransformMakeTranslation(-outPath.bounds.midX, -outPath.bounds.midY)
        let scaleTransform = CGAffineTransformMakeScale(scaleFactor, -scaleFactor)
        let frameCenterTransform = CGAffineTransformMakeTranslation(frame.origin.x + frame.width/2,
            frame.origin.y + frame.height/2)
        
        outPath.applyTransform(objectCenterTransform)
        outPath.applyTransform(scaleTransform)
        outPath.applyTransform(frameCenterTransform)
        
        return outPath
    }
}
