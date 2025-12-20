import Testing
@testable import SwiftGE

private final class CounterComponent: Component {
    weak var entity: Entity?
    private(set) var updates: Int = 0

    func update(deltaTime: TimeInterval) {
        updates += 1
    }
}

@Test func engineTicksScene() async throws {
    let component = CounterComponent()
    let entity = Entity(name: "Player")
    entity.addComponent(component)
    let scene = Scene(name: "Main", entities: [entity])
    let engine = Engine()
    engine.load(scene: scene)

    engine.tick(deltaTime: 1.0 / 60.0)

    #expect(component.updates == 1)
}
