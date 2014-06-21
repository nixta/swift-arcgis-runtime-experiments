//
//  AGSPolyline+debug.swift
//  SwiftTestbed
//
//  Created by Nicholas Furness on 6/19/14.
//  Copyright (c) 2014 Esri. All rights reserved.
//

import Foundation
import ArcGIS

extension AGSPolyline {
    func bezier() -> UIBezierPath {
        var line84 = self >>> AGSSpatialReference.wgs84SpatialReference()
        
        var path = UIBezierPath()
        for pathIndex in 0..self.numPaths {
            if let firstPt = self.pointOnPath(pathIndex, atIndex: 0)? {
                path.moveToPoint(cgPointFromAgsPoint(firstPt))
                for ptIndex in 1..self.numPointsInPath(pathIndex) {
                    if let ptOnPath = self.pointOnPath(pathIndex, atIndex: ptIndex)? {
                        path.addLineToPoint(cgPointFromAgsPoint(ptOnPath))
                    }
                }
            }
        }
        
        return path
    }
}