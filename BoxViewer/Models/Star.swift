//
//  Star.swift
//  BoxViewer
//
//  Created by Eric Freitas on 2/1/23.
//

import Foundation
import SceneKit

/// Star
///   var position - position relative to the center point
struct Star: Codable {
  enum CodingKeys: String, CodingKey {
    case position
    case spectralClass
    case subClass
    case stellarType
    case mass
    case bioZoneInner
    case bioZoneOuter
    case innerLimit
    case radius
  }
  
  /// TODO: add several properties that describe the placement within a star system.
  /// For instance, in a binary star system, we need to know the distance
  /// of each element of a binary pair from their center of mass, as well as the angle at which
  /// they are tilted relative to the reference plane (which is either the galactic plane or one defined differently
  /// for a star cluster).
  ///
  ///    |   L - x     x  |
  ///   <M1--------Cm----M2>
  ///    |        L       |
  ///
  /// x = M1L / (M1 + M2)
  ///
  ///
  /// Keplerian Elements: https://en.wikipedia.org/wiki/Orbital_elements
  ///
  ///   Eccentricity (e - unitless)
  ///   Semimajor Axis (a - meters)
  ///   Inclination (i - radians)
  ///   Longitude of Ascending Node (Ω - radians)
  ///   Argument of perapsis (ω - radians)
  ///   True anomaly (v, θ, or f - radians) at Epoch (T0 - timedate)
  ///   Epoch (T0 - timedate)
  
  var position: SCNVector3? = SCNVector3(0, 0, 0)
  var spectralClass: SpectralClass? = .A
  var subClass: Int? = 5
  var stellarType: StellarType? = .Dwarf
  var mass: Double? = 1.0
  var bioZoneInner: Double? = 1.0
  var bioZoneOuter: Double? = 1.0
  var innerLimit: Double? = 1.0
  var radius: Double? = 1.0
  
  /// when saving to sqlite db:
  ///   - SCNVector3 must have the coords saved individually as Double;
  ///   - SpectralClass as String
  ///   - StellarType as Int
  
  init() {
    //
  }
  
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    position = try values.decode(SCNVector3.self, forKey: .position)
    spectralClass = try values.decode(SpectralClass.self, forKey: .spectralClass)
    subClass = try values.decode(Int.self, forKey: .subClass)
    stellarType = try values.decode(StellarType.self, forKey: .stellarType)
    mass = try values.decode(Double.self, forKey: .mass)
    bioZoneInner = try values.decode(Double.self, forKey: .bioZoneInner)
    bioZoneOuter = try values.decode(Double.self, forKey: .bioZoneOuter)
    innerLimit = try values.decode(Double.self, forKey: .innerLimit)
    radius = try values.decode(Double.self, forKey: .radius)
  }
  
  init(position: SCNVector3, spectralClass: SpectralClass, subClass: Int, stellarType: StellarType, mass: Double, bioZoneInner: Double, bioZoneOuter: Double, innerLimit: Double, radius: Double) {
    self.position = position
    self.spectralClass = spectralClass
    self.subClass = subClass
    self.stellarType = stellarType
    self.mass = mass
    self.bioZoneInner = bioZoneInner
    self.bioZoneOuter = bioZoneOuter
    self.innerLimit = innerLimit
    self.radius = radius
  }
  
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(position, forKey: .position)
    try container.encode(spectralClass, forKey: .spectralClass)
    try container.encode(subClass, forKey: .subClass)
    try container.encode(stellarType, forKey: .stellarType)
    try container.encode(mass, forKey: .mass)
    try container.encode(bioZoneInner, forKey: .bioZoneInner)
    try container.encode(bioZoneOuter, forKey: .bioZoneOuter)
    try container.encode(innerLimit, forKey: .innerLimit)
    try container.encode(radius, forKey: .radius)
  }
}

extension Star: CustomDebugStringConvertible {
    var debugDescription: String {
      return "\(spectralClass ?? .M)\(subClass ?? 5)\(stellarType ?? .V) \(mass ?? 0) \(innerLimit ?? 0) \(bioZoneInner ?? 0) \(bioZoneOuter ?? 0) \(radius ?? 0) \(position?.x ?? 0), \(position?.y ?? 0), \(position?.z ?? 0)\n"
    }
}

class Stars: ObservableObject {
  @Published var stars = [Star]()
}
