//
//  AGSOperators+Experimental.swift
//  SwiftMap
//
//  Created by Nicholas Furness on 6/27/14.
//  Copyright (c) 2014 Esri. All rights reserved.
//

import Foundation

protocol Expandable {}
protocol Contractible {}

extension AGSPoint: Expandable {}
extension AGSMultipoint: Expandable {}
extension AGSPolyline: Expandable {}
extension AGSPolygon: Expandable, Contractible {}


/// Expand or contract a geometry
var expandFactor = 1.1

@postfix func ++<T: AGSGeometry, Expandable>(item: T) -> AGSMutablePolygon {
    var env = item.envelope
    var expansion = ((env.width + env.height) / 2) * expandFactor
    return AGSGeometryEngine().bufferGeometry(item, byDistance: expansion)
}

@postfix func --<T: AGSGeometry, Contractible>(item: T) -> AGSMutablePolygon {
    var env = item.envelope
    var expansion = -((env.width + env.height) / 2) * (1 - 1/expandFactor)
    return AGSGeometryEngine().bufferGeometry(item, byDistance: expansion)
}

/// Geometry Comparison Operators
@infix func > (lhs: AGSPoint, rhs: AGSPoint) -> Bool {
    return sqrt(lhs.x*lhs.x + lhs.y*lhs.y) > sqrt(rhs.x*rhs.x + rhs.y*rhs.y)
}

@infix func > (lhs: AGSMultipoint, rhs: AGSMultipoint) -> Bool {
    return lhs.numPoints > rhs.numPoints
}

@infix func > (lhs: AGSPolyline, rhs: AGSPolyline) -> Bool {
    return AGSGeometryEngine().geodesicLengthOfGeometry(lhs, inUnit: AGSSRUnitMeter) > AGSGeometryEngine().geodesicLengthOfGeometry(rhs, inUnit: AGSSRUnitMeter)
}

@infix func > (lhs: AGSPolygon, rhs: AGSPolygon) -> Bool {
    return AGSGeometryEngine().geodesicAreaOfGeometry(lhs, inUnit: AGSAreaUnitsSquareMeters) > AGSGeometryEngine().geodesicAreaOfGeometry(rhs, inUnit: AGSAreaUnitsSquareMeters)
}

@infix func < <T: AGSGeometry, U: AGSGeometry where T: Geometry, U: Geometry, T.Dimension == U.Dimension> (lhs: T, rhs: U) {
    return rhs < lhs
}


@infix func >= (lhs: AGSMultipoint, rhs: AGSMultipoint) -> Bool {
    return lhs.numPoints >= rhs.numPoints
}

@infix func <= (lhs: AGSMultipoint, rhs: AGSMultipoint) -> Bool {
    return lhs.numPoints <= rhs.numPoints
}