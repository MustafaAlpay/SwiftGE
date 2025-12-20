import Foundation

#if canImport(MetalKit)
import MetalKit

public final class MetalRenderer: Renderer {
    public let name = "MetalRenderer"
    public private(set) var device: MTLDevice?
    public private(set) var commandQueue: MTLCommandQueue?
    private var pipelineState: MTLRenderPipelineState?
    private var pipelinePixelFormat: MTLPixelFormat?
    private var library: MTLLibrary?

    public init(device: MTLDevice? = MTLCreateSystemDefaultDevice()) {
        self.device = device
        self.commandQueue = device?.makeCommandQueue()
    }

    public func prepare(scene: Scene?, camera: Camera?, time: TimeState) {
        // Placeholder for render pass setup and resource updates.
    }

    public func draw(scene: Scene?, camera: Camera?, time: TimeState) {
        // Placeholder for drawing. Integrate with a MTKView or custom layer later.
    }

    public func draw(in view: MTKView, time: TimeState) {
        guard let device else { return }
        if commandQueue == nil {
            commandQueue = device.makeCommandQueue()
        }
        guard let commandQueue else { return }

        ensurePipeline(device: device, pixelFormat: view.colorPixelFormat)
        guard let pipelineState else { return }
        guard let drawable = view.currentDrawable,
              let renderPassDescriptor = view.currentRenderPassDescriptor else { return }

        guard let commandBuffer = commandQueue.makeCommandBuffer(),
              let encoder = commandBuffer.makeRenderCommandEncoder(descriptor: renderPassDescriptor) else { return }
        encoder.setRenderPipelineState(pipelineState)
        encoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: 3)
        encoder.endEncoding()
        commandBuffer.present(drawable)
        commandBuffer.commit()
    }

    private func ensurePipeline(device: MTLDevice, pixelFormat: MTLPixelFormat) {
        if pipelineState != nil && pipelinePixelFormat == pixelFormat {
            return
        }
        pipelinePixelFormat = pixelFormat

        let source = """
        #include <metal_stdlib>
        using namespace metal;

        struct VSOut {
            float4 position [[position]];
            float4 color;
        };

        vertex VSOut vertex_main(uint vertexID [[vertex_id]]) {
            float2 positions[3] = {
                float2(0.0, 0.6),
                float2(-0.6, -0.6),
                float2(0.6, -0.6)
            };
            float3 colors[3] = {
                float3(1.0, 0.2, 0.2),
                float3(0.2, 1.0, 0.2),
                float3(0.2, 0.6, 1.0)
            };
            VSOut out;
            out.position = float4(positions[vertexID], 0.0, 1.0);
            out.color = float4(colors[vertexID], 1.0);
            return out;
        }

        fragment float4 fragment_main(VSOut in [[stage_in]]) {
            return in.color;
        }
        """

        if library == nil {
            library = try? device.makeLibrary(source: source, options: nil)
        }
        guard let library,
              let vertexFunction = library.makeFunction(name: "vertex_main"),
              let fragmentFunction = library.makeFunction(name: "fragment_main") else {
            return
        }

        let pipelineDescriptor = MTLRenderPipelineDescriptor()
        pipelineDescriptor.vertexFunction = vertexFunction
        pipelineDescriptor.fragmentFunction = fragmentFunction
        pipelineDescriptor.colorAttachments[0].pixelFormat = pixelFormat

        pipelineState = try? device.makeRenderPipelineState(descriptor: pipelineDescriptor)
    }
}
#endif
