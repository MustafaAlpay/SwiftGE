import SwiftUI
import SwiftGE
#if canImport(MetalKit) && !os(watchOS)
import MetalKit
#endif

@main
struct SwiftGEAppApp: App {
    private let engine: Engine
    #if canImport(MetalKit) && !os(watchOS)
    private let metalRenderer: MetalRenderer?
    #endif

    init() {
        #if canImport(MetalKit) && !os(watchOS)
        let renderer = MetalRenderer()
        self.metalRenderer = renderer
        self.engine = Engine(renderer: renderer)
        #else
        self.engine = Engine()
        #endif
    }

    var body: some SwiftUI.Scene {
        WindowGroup {
            #if canImport(MetalKit) && !os(watchOS)
            ContentView(engine: engine, metalRenderer: metalRenderer)
            #else
            ContentView(engine: engine)
            #endif
        }
    }
}
