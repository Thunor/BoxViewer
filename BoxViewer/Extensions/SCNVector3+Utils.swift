//
//  SCNVector3+Utils.swift
//  BoxViewer
//
//  Created by Eric Freitas on 2/1/23.
//

import Foundation
import SceneKit

extension SCNVector3 {
  func distance(to vector: SCNVector3) -> Float {
    return simd_distance(simd_float3(self), simd_float3(vector))
  }
  
  /// Generate a point in a cubic volume of space
  static func getRandom(halfLength: CGFloat) -> SCNVector3 {
    
    let x = (CGFloat.random(in: 0.0...1.0) * halfLength * 2) - halfLength
    let y = (CGFloat.random(in: 0.0...1.0) * halfLength * 2) - halfLength
    let z = (CGFloat.random(in: 0.0...1.0) * halfLength * 2) - halfLength
    
    let vector = SCNVector3(x: Float(x), y: Float(y), z: Float(z))
    return vector
  }
}

extension SCNVector3: CustomDebugStringConvertible {
  public var debugDescription: String {
    return "[\(self.x), \(self.y), \(self.z)]"
  }
}

extension SCNVector3: Codable {
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let x = try values.decode(Float.self, forKey: .x)
        let y = try values.decode(Float.self, forKey: .y)
        let z = try values.decode(Float.self, forKey: .z)
        self.init(x, y, z)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(x, forKey: .x)
        try container.encode(y, forKey: .y)
        try container.encode(z, forKey: .z)
    }

    private enum CodingKeys: String, CodingKey {
        case x,y,z
    }
}
