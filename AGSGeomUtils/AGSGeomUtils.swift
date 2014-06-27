//
//  AGSGeomUtils.swift
//  SwiftMap
//
//  Created by Nicholas Furness on 6/24/14.
//  Copyright (c) 2014 Esri. All rights reserved.
//

func cgPointFromAgsPoint(agsPoint:AGSPoint) -> CGPoint {
    var x = CGFloat(agsPoint.x)
    var y = CGFloat(agsPoint.y)
    var pt = CGPointMake(x, y)
    return pt
}

@objc protocol HasBezier {
    func bezierForFrame(frame:CGRect) -> UIBezierPath
}
