import SwiftUI
import SwiftGE

#if canImport(MetalKit) && !os(watchOS)
import MetalKit
#if canImport(QuartzCore)
import QuartzCore
#endif

final class MetalViewCoordinator: NSObject, MTKViewDelegate {
    private let engine: Engine
    private let renderer: MetalRenderer
    private var lastTime: CFTimeInterval = CACurrentMediaTime()

    init(engine: Engine, renderer: MetalRenderer) {
        self.engine = engine
        self.renderer = renderer
    }

    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        // Hook for resize handling.
    }

    func draw(in view: MTKView) {
        let now = CACurrentMediaTime()
        let delta = now - lastTime
        lastTime = now
        engine.tick(deltaTime: delta)
        renderer.draw(in: view, time: engine.time)
    }
}

#if canImport(UIKit)
struct MetalView: UIViewRepresentable {
    let engine: Engine
    let renderer: MetalRenderer

    func makeUIView(context: Context) -> MTKView {
        let view = MTKView(frame: .zero, device: renderer.device)
        view.clearColor = MTLClearColor(red: 0.06, green: 0.08, blue: 0.12, alpha: 1)
        view.colorPixelFormat = .bgra8Unorm
        view.isPaused = false
        view.enableSetNeedsDisplay = false
        view.delegate = context.coordinator
        view.preferredFramesPerSecond = 60
        return view
    }

    func updateUIView(_ uiView: MTKView, context: Context) {
        // No-op for now.
    }

    func makeCoordinator() -> MetalViewCoordinator {
        MetalViewCoordinator(engine: engine, renderer: renderer)
    }
}
#elseif canImport(AppKit)
struct MetalView: NSViewRepresentable {
    let engine: Engine
    let renderer: MetalRenderer

    func makeNSView(context: Context) -> MTKView {
        let view = MTKView(frame: .zero, device: renderer.device)
        view.clearColor = MTLClearColor(red: 0.06, green: 0.08, blue: 0.12, alpha: 1)
        view.colorPixelFormat = .bgra8Unorm
        view.isPaused = false
        view.enableSetNeedsDisplay = false
        view.delegate = context.coordinator
        view.preferredFramesPerSecond = 60
        return view
    }

    func updateNSView(_ nsView: MTKView, context: Context) {
        // No-op for now.
    }

    func makeCoordinator() -> MetalViewCoordinator {
        MetalViewCoordinator(engine: engine, renderer: renderer)
    }
}
#endif
#endif
