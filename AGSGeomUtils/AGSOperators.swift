//
//  AGSOperators.swift
//  SwiftTestbed
//
//  Created by Nicholas Furness on 6/9/14.
//  Copyright (c) 2014 Esri. All rights reserved.
//


/// Project to Spatial Reference
operator infix >> {}

@infix func >> <T: AGSGeometry>(lhs: T, rhs: AGSSpatialReference) -> T {
    return AGSGeometryEngine().projectGeometry(lhs, toSpatialReference: rhs) as T
}


/// "Bitwise" Geometry Operators (|, &, ^)
@infix func | <T: AGSGeometry, U: AGSGeometry where T: Geometry, U: Geometry, T.Dimension == U.Dimension>(lhs: T, rhs: U) -> T {
    return AGSGeometryEngine().unionGeometries([lhs, rhs]) as T
}

@infix func & <T: AGSGeometry, U: AGSGeometry where T: Geometry, U: Geometry, T.Dimension == U.Dimension>(lhs: T, rhs: U) -> T {
    return AGSGeometryEngine().intersectionOfGeometry(lhs, andGeometry: rhs) as T
}

@infix func ^ <T: AGSGeometry, U: AGSGeometry where T: Geometry, U: Geometry, T.Dimension == U.Dimension>(lhs: T, rhs: U) -> T {
    return AGSGeometryEngine().symmetricDifferenceOfGeometry(lhs, andGeometry: rhs) as T
}


/// "Arithmetic" Geometry Operators (-, +)
@infix func - <T: AGSGeometry, U: AGSGeometry where T: Geometry, U: Geometry, T.Dimension == U.Dimension>(lhs: T, rhs: U) -> T {
    return AGSGeometryEngine().differenceOfGeometry(lhs, andGeometry: rhs) as T
}

@infix func + <T: AGSGeometry, U: AGSGeometry where T: Geometry, U: Geometry, T.Dimension == U.Dimension>(lhs: T, rhs: U) -> T {
    return lhs | rhs
}


/// "Logical" Geometry Operators (||, &&)
@infix func || <T: AGSGeometry, U: AGSGeometry where T: Geometry, U: Geometry, T.Dimension == U.Dimension>(lhs: T, rhs: U) -> T {
    return lhs | rhs
}

@infix func && <T: AGSGeometry, U: AGSGeometry where T: Geometry, U: Geometry, T.Dimension == U.Dimension>(lhs: T, rhs: U) -> T {
    return lhs & rhs
}




/// Geometry Operator protocols - necessary to limit generics
protocol Geometry {
    typealias Dimension
}

extension AGSPoint: Geometry {
    typealias Dimension = AGSPoint
}
extension AGSMultipoint: Geometry {
    typealias Dimension = AGSPoint
}
extension AGSPolyline: Geometry {
    typealias Dimension = AGSPolyline
}
extension AGSPolygon: Geometry {
    typealias Dimension = AGSPolygon
}