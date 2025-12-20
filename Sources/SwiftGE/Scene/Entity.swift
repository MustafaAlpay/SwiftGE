import Foundation

public final class Entity: Identifiable {
    public let id: UUID
    public var name: String
    public var transform: Transform
    public var isActive: Bool
    private var components: [Component]

    public init(name: String = "Entity", transform: Transform = .identity, isActive: Bool = true) {
        self.id = UUID()
        self.name = name
        self.transform = transform
        self.isActive = isActive
        self.components = []
    }

    public func addComponent(_ component: Component) {
        component.entity = self
        components.append(component)
        component.onAdded(to: self)
    }

    public func getComponent<T: Component>(_ type: T.Type) -> T? {
        components.first { $0 is T } as? T
    }

    public func update(deltaTime: TimeInterval) {
        guard isActive else { return }
        for component in components {
            component.update(deltaTime: deltaTime)
        }
    }
}
