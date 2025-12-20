import Foundation

public struct SceneFrame {
    public let scene: Scene?
    public let camera: Camera?
    public let time: TimeState

    public init(scene: Scene?, camera: Camera?, time: TimeState) {
        self.scene = scene
        self.camera = camera
        self.time = time
    }
}

public protocol Renderer {
    var name: String { get }
    func prepare(scene: Scene?, camera: Camera?, time: TimeState)
    func draw(scene: Scene?, camera: Camera?, time: TimeState)
}

public extension Renderer {
    func prepare(scene: Scene?, camera: Camera?, time: TimeState) {}
}

public final class NullRenderer: Renderer {
    public let name = "NullRenderer"

    public init() {}

    public func draw(scene: Scene?, camera: Camera?, time: TimeState) {}
}
