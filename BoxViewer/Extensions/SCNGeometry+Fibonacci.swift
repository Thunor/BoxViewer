//
//  SCNGeometry+Fibonacci.swift
//  BoxViewer
//
//  Created by Eric Freitas on 4/30/23.
//

import Foundation
import SceneKit

extension SCNGeometry {
    /// Create a fibonacci sphere with a specific number of points and a specific radius
    private func fiboSphere(numPoints: Int, radius: Float = 1.0) -> [SCNVector3] {
        var points = [SCNVector3]()
        let angleIncrement = Float.pi * (3.0 - sqrt(5.0))
        
        for i in 0..<numPoints {
            let t = Float(i) / Float(numPoints)
            let angle1 = acos(1.0 - 2.0 * t)
            let angle2 = angleIncrement * Float(i)
            
            let x: Float = sin(angle1) * cos(angle2) * radius
            let y: Float = sin(angle1) * sin(angle2) * radius
            let z: Float = cos(angle1) * radius
            points.append(SCNVector3Make(x, y, z))
        }
        return points
    }
    
    func createFiboSphere(radius: CGFloat) -> SCNGeometry {
        var vertices = [SCNVector3]()
        var colors = [SIMD4<Float>]()
        var indices = [UInt32]()
        
        vertices = fiboSphere(numPoints: 200, radius: Float(radius))
        for idx in 0..<vertices.count {
            colors.append(SIMD4<Float>(0.1, 0.8, 0.3, 1.0))
            indices.append(UInt32(idx))
        }
        
        let vertexSource = SCNGeometrySource(vertices: vertices)
        
        let colorsData = Data(bytes: &colors, count: colors.count * MemoryLayout<SIMD4<Float>>.stride)
        let colorSource = SCNGeometrySource(data: colorsData,
                                            semantic: .color,
                                            vectorCount: colors.count,
                                            usesFloatComponents: true,
                                            componentsPerVector: 4,
                                            bytesPerComponent: MemoryLayout<Float>.stride,
                                            dataOffset: 0,
                                            dataStride: MemoryLayout<SIMD4<Float>>.stride)
        
        let pointsElement = SCNGeometryElement(indices: indices, primitiveType: SceneKit.SCNGeometryPrimitiveType.point)
        pointsElement.pointSize = 0.005
        pointsElement.minimumPointScreenSpaceRadius = 1
        pointsElement.maximumPointScreenSpaceRadius = 50
        
        let geometry = SCNGeometry(sources: [vertexSource, colorSource], elements: [pointsElement])
        geometry.firstMaterial?.writesToDepthBuffer = false
        
        return geometry
    }
}
