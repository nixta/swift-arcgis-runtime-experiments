//
//  AGSPolygon+debug.swift
//  SwiftTestbed
//
//  Created by Nicholas Furness on 6/19/14.
//  Copyright (c) 2014 Esri. All rights reserved.
//

import Foundation
import ArcGIS

extension AGSPolygon {
    func bezierForFrame(frame:CGRect) -> UIBezierPath {

        // Translate our AGSPolygon into a UIBezierPath
        var path = UIBezierPath()
        for ringIndex in 0..self.numRings {
            // Build each ring in turn
            if let firstPtInRing = self.pointOnRing(ringIndex, atIndex: 0)? {
                path.moveToPoint(cgPointFromAgsPoint(firstPtInRing))
                for ptIndex in 1..self.numPointsInRing(ringIndex) {
                    if let pt = self.pointOnRing(ringIndex, atIndex: ptIndex)? {
                        var ptToAdd = cgPointFromAgsPoint(pt)
                        path.addLineToPoint(ptToAdd)
                    }
                }
                path.closePath()
            }
        }

        // Figure out how to scale the geometry to the target frame
        let scaleFactor = min(frame.height/path.bounds.height, frame.width/path.bounds.width)
        var transform = CGAffineTransformConcat(CGAffineTransformMakeTranslation(-path.bounds.midX, -path.bounds.midY), CGAffineTransformMakeScale(scaleFactor, -scaleFactor))
        path.applyTransform(transform)

        return path
    }
    
    func copyCenteredAtOrigin() -> AGSPolygon {
        return self.copyCenteredAtPoint(AGSPoint(x: 0, y: 0, spatialReference: AGSSpatialReference.wgs84SpatialReference()))
    }
    
    func copyCenteredAtPoint(centerPoint: AGSPoint) -> AGSPolygon {
        var centerOffset = AGSGeometryEngine().labelPointForPolygon(self)
        var newPolygon = AGSMutablePolygon(spatialReference: self.spatialReference)
        for ringIndex in 0..self.numRings {
            newPolygon.addRingToPolygon()
            for pointIndex in 0..self.numPointsInRing(ringIndex) {
                let oldPoint = self.pointOnRing(ringIndex, atIndex: pointIndex)
                let newPoint = AGSPoint(x: oldPoint.x - centerOffset.x + centerPoint.x,
                                        y: oldPoint.y - centerOffset.y + centerPoint.y,
                                        spatialReference: oldPoint.spatialReference)
                newPolygon.addPointToRing(newPoint)
            }
        }
        return newPolygon
    }
}