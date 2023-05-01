//
//  SCNVector3+DebugString.swift
//  BoxViewer
//
//  Created by Eric Freitas on 4/30/23.
//

import Foundation
import SceneKit

extension SCNVector3: CustomDebugStringConvertible {
    public var debugDescription: String {
        return "[\(self.x), \(self.y), \(self.z)]"
    }
}
