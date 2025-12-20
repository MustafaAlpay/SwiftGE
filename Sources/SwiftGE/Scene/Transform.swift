import Foundation

public struct Transform: Equatable, Sendable {
    public var position: Vector3
    public var rotation: Vector3
    public var scale: Vector3

    public init(position: Vector3 = .zero, rotation: Vector3 = .zero, scale: Vector3 = Vector3(x: 1, y: 1, z: 1)) {
        self.position = position
        self.rotation = rotation
        self.scale = scale
    }

    public static let identity = Transform()
}
