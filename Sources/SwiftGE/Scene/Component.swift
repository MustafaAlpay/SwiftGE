import Foundation

public protocol Component: AnyObject {
    var entity: Entity? { get set }
    func onAdded(to entity: Entity)
    func update(deltaTime: TimeInterval)
}

public extension Component {
    func onAdded(to entity: Entity) {}
    func update(deltaTime: TimeInterval) {}
}
