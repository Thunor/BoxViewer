//
//  SCNVector3+Codable.swift
//  BoxViewer
//
//  Created by Eric Freitas on 4/30/23.
//

import Foundation
import SceneKit

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
