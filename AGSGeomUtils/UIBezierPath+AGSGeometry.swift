//
//  UIBezierPath+AGSGeometry.swift
//  SwiftMap
//
//  Created by Nicholas Furness on 7/11/14.
//  Copyright (c) 2014 Esri. All rights reserved.
//

import ArcGIS

/// A protocol that drives everything AGSGeometry with UIBezierPath
@objc protocol HasBezier {
    func bezierForFrame(frame:CGRect) -> UIBezierPath
    func appendToBezier(bezier:UIBezierPath, forFrame frame:CGRect) -> UIBezierPath
}



/// Extend UIBezierPath with a new convenience initializer and a property
extension UIBezierPath {
    convenience init(geometry: HasBezier, frame: CGRect) {
        self.init()
        geometry.appendToBezier(self, forFrame: frame)
    }
    
    var isEmpty: Bool {
        get {
            return self.currentPoint == CGPointZero
        }
    }
}



extension AGSPoint {
    var cgPoint:CGPoint {
        get {
            return CGPointMake(CGFloat(self.x), CGFloat(self.y))
        }
    }

}



/// Implement the HazBezier protocol on AGSPolyline
extension AGSPolyline: HasBezier {
    func bezierForFrame(frame:CGRect) -> UIBezierPath {
        return self.appendToBezier(UIBezierPath(), forFrame: frame)
    }
    
    func appendToBezier(bezier:UIBezierPath, forFrame frame:CGRect) -> UIBezierPath {
        for pathIndex in 0 ..< self.numPaths {
            // Build each ring in turn
            if let firstPtInPath = self.pointOnPath(pathIndex, atIndex: 0)?.cgPoint {
                bezier.moveToPoint(firstPtInPath)
                for ptIndex in 1 ..< self.numPointsInPath(pathIndex) {
                    if let ptToAdd = self.pointOnPath(pathIndex, atIndex: ptIndex)?.cgPoint {
                        bezier.addLineToPoint(ptToAdd)
                    }
                }
            }
        }

        transformGeographicBezierToFrame(bezier, frame)
        
        return bezier
    }
}



/// Implement the HazBezier protocol on AGSPolygon
extension AGSPolygon: HasBezier {
    func bezierForFrame(frame:CGRect) -> UIBezierPath {
        return self.appendToBezier(UIBezierPath(), forFrame: frame)
    }
    
    func appendToBezier(bezier:UIBezierPath, forFrame frame:CGRect) -> UIBezierPath {
        if self.isEmpty() {
            return bezier
        }
        
        // Translate our AGSPolygon into a UIBezierPath
        for ringIndex in 0 ..< self.numRings {
            // Build each ring in turn
            if let firstPtInRing = self.pointOnRing(ringIndex, atIndex: 0)?.cgPoint {
                bezier.moveToPoint(firstPtInRing)
                for ptIndex in 1 ..< self.numPointsInRing(ringIndex) {
                    if let ptToAdd = self.pointOnRing(ringIndex, atIndex: ptIndex)?.cgPoint {
                        bezier.addLineToPoint(ptToAdd)
                    }
                }
                bezier.closePath()
            }
        }
        
        transformGeographicBezierToFrame(bezier, frame)
        
        return bezier
    }
}



/// Common helper function for UIBezierPath to Frame transformation
func transformGeographicBezierToFrame(bezier:UIBezierPath, frame:CGRect) {
    // Scale and shift the geometry to the target frame
    let objectCenterTransform = CGAffineTransformMakeTranslation(-bezier.bounds.midX, -bezier.bounds.midY)
    
    let scaleFactor = min(frame.height/bezier.bounds.height, frame.width/bezier.bounds.width)
    let scaleTransform = CGAffineTransformMakeScale(scaleFactor, -scaleFactor)
    
    let frameCenterTransform = CGAffineTransformMakeTranslation(frame.origin.x + frame.width/2, frame.origin.y + frame.height/2)
    
    bezier.applyTransform(objectCenterTransform)
    bezier.applyTransform(scaleTransform)
    bezier.applyTransform(frameCenterTransform)
}
