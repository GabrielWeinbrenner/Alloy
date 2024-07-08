
import MetalKit

class GameView: MTKView {

    var vertices: [VertexLibrary.Vertex]!
    var vertexBuffer: MTLBuffer!;
    
    required init(coder: NSCoder) {
        super.init(coder: coder);
        
        self.device = MTLCreateSystemDefaultDevice();
        Engine.Ignite(device: device!)
        
        self.clearColor = Preferences.clearColor;
        self.colorPixelFormat = Preferences.mainPixelFormat;
        
        createBuffers(from: Engine.vertexLibrary.vertices)
        
    }
    func createBuffers(from vertices: [VertexLibrary.Vertex]) {
        vertexBuffer = Engine.device.makeBuffer(bytes: vertices, length: vertices.count * MemoryLayout<VertexLibrary.Vertex>.stride, options: [])
    }
    
    override func draw(_ rect: NSRect) {
        guard let drawable = self.currentDrawable, let renderPassDescriptor = self.currentRenderPassDescriptor else { return; }
        
        let commandBuffer = Engine.commandQueue.makeCommandBuffer();
        let renderCommandEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: renderPassDescriptor)
        
        renderCommandEncoder?.setRenderPipelineState(Engine.renderPipelineLibrary.getRenderPipelineDescriptor(.Basic))
        renderCommandEncoder?.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        renderCommandEncoder?.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: Engine.vertexLibrary.vertices.count)
        
        renderCommandEncoder?.endEncoding()
        commandBuffer?.present(drawable)
        commandBuffer?.commit()
    }
}

