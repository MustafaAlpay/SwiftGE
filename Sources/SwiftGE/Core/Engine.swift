import Foundation

public final class Engine {
    public private(set) var scene: Scene?
    public let renderer: Renderer
    public let input: InputState
    public let audio: AudioSystem
    public private(set) var time: TimeState

    public init(renderer: Renderer = NullRenderer(), input: InputState = InputState(), audio: AudioSystem = AudioSystem()) {
        self.renderer = renderer
        self.input = input
        self.audio = audio
        self.time = TimeState()
    }

    public func load(scene: Scene) {
        self.scene = scene
    }

    public func tick(deltaTime: TimeInterval) {
        time.step(deltaTime: deltaTime)
        scene?.update(deltaTime: deltaTime)
        renderer.prepare(scene: scene, camera: scene?.activeCamera, time: time)
        renderer.draw(scene: scene, camera: scene?.activeCamera, time: time)
    }
}
