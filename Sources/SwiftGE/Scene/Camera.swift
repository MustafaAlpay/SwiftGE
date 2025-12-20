import Foundation

public final class Camera: Component {
    public weak var entity: Entity?
    public var isOrthographic: Bool
    public var fieldOfView: Double
    public var near: Double
    public var far: Double

    public init(isOrthographic: Bool = false, fieldOfView: Double = 60, near: Double = 0.1, far: Double = 1000) {
        self.isOrthographic = isOrthographic
        self.fieldOfView = fieldOfView
        self.near = near
        self.far = far
    }
}
