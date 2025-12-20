import Foundation

public final class Scene {
    public var name: String
    private(set) var entities: [Entity]
    public var activeCamera: Camera?

    public init(name: String = "Scene", entities: [Entity] = []) {
        self.name = name
        self.entities = entities
    }

    public func addEntity(_ entity: Entity) {
        entities.append(entity)
    }

    public func removeEntity(_ entity: Entity) {
        entities.removeAll { $0.id == entity.id }
    }

    public func update(deltaTime: TimeInterval) {
        for entity in entities {
            entity.update(deltaTime: deltaTime)
        }
    }
}
