//
//  AGSPolygon+bezier.swift
//  SwiftTestbed
//
//  Created by Nicholas Furness on 6/19/14.
//  Copyright (c) 2014 Esri. All rights reserved.
//

extension AGSPolygon: HasBezier {
    func bezierForFrame(frame:CGRect) -> UIBezierPath {

        // Translate our AGSPolygon into a UIBezierPath
        var outPath = UIBezierPath()
        for ringIndex in 0..<self.numRings {
            // Build each ring in turn
            if let firstPtInRing = self.pointOnRing(ringIndex, atIndex: 0)? {
                outPath.moveToPoint(cgPointFromAgsPoint(firstPtInRing))
                for ptIndex in 1..<self.numPointsInRing(ringIndex) {
                    if let pt = self.pointOnRing(ringIndex, atIndex: ptIndex)? {
                        var ptToAdd = cgPointFromAgsPoint(pt)
                        outPath.addLineToPoint(ptToAdd)
                    }
                }
                outPath.closePath()
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