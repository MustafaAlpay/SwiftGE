import SwiftUI
import SwiftGE

struct ContentView: View {
    let engine: Engine
    #if canImport(MetalKit) && !os(watchOS)
    let metalRenderer: MetalRenderer?
    #endif
    @State private var frameCount: UInt64 = 0

    #if canImport(MetalKit) && !os(watchOS)
    init(engine: Engine, metalRenderer: MetalRenderer?) {
        self.engine = engine
        self.metalRenderer = metalRenderer
    }
    #else
    init(engine: Engine) {
        self.engine = engine
    }
    #endif

    var body: some View {
        VStack(spacing: 16) {
            #if canImport(MetalKit) && !os(watchOS)
            if let metalRenderer {
                MetalView(engine: engine, renderer: metalRenderer)
                    .frame(minHeight: 240)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            } else {
                Text("Metal not available on this platform.")
                    .font(.caption)
            }
            #else
            Text("Metal not available on this platform.")
                .font(.caption)
            #endif

            Text("SwiftGE")
                .font(.largeTitle)
            Text("Engine version: \(SwiftGE.version)")
                .font(.subheadline)
            Text("Frames: \(frameCount)")
                .font(.caption)
            Button("Tick Engine") {
                engine.tick(deltaTime: 1.0 / 60.0)
                frameCount = engine.time.frameCount
            }
        }
        .padding()
        .onAppear {
            frameCount = engine.time.frameCount
        }
    }
}
