//
//  AGSPoint+debug.swift
//  SwiftTestbed
//
//  Created by Nicholas Furness on 6/19/14.
//  Copyright (c) 2014 Esri. All rights reserved.
//

import Foundation
import ArcGIS

func cgPointFromAgsPoint(agsPoint:AGSPoint) -> CGPoint {
    var x = CGFloat(agsPoint.x)
    var y = CGFloat(agsPoint.y)
    var pt = CGPointMake(x, y)
    return pt
}

//extension AGSPoint {
//    var location: CLLocation {
//    get {
//        var pt84 = self >>> AGSSpatialReference.wgs84SpatialReference()
//        return CLLocation(latitude: pt84.y, longitude: pt84.x)
//    }
//    }
//}