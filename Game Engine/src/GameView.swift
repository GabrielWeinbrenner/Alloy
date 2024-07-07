
import MetalKit

class GameView: MTKView {
    struct Vertex {
        var position: SIMD3<Float>
        var color: SIMD4<Float>
    }
    var commandQueue: MTLCommandQueue!;
    var renderPipelineState: MTLRenderPipelineState!;
    
    var vertices: [Vertex]!
    var vertexBuffer: MTLBuffer!;
    
    required init(coder: NSCoder) {
        super.init(coder: coder);
        
        self.device = MTLCreateSystemDefaultDevice();
        
        self.clearColor = MTLClearColorMake(0.2, 0.4, 0.1, 1.0);
        self.colorPixelFormat = .bgra8Unorm;
        
        self.commandQueue = device?.makeCommandQueue();
        
        createRenderPipelineState()
        createVertices()
        createBuffers()
        
    }
    func createVertices() {
        vertices = [
            Vertex(position: SIMD3<Float>(0,1,0), color: SIMD4(1,0,0,1)),
            Vertex(position: SIMD3<Float>(-1,-1,0), color: SIMD4(0,1,0,1)),
            Vertex(position: SIMD3<Float>(1,-1,0), color: SIMD4(0,0,1,1)),
        ]
    }
    func createBuffers() {
        vertexBuffer = device?.makeBuffer(bytes: vertices, length: vertices.count * MemoryLayout<Vertex>.stride, options: [])
    }
    
    func createRenderPipelineState() {
        let library = device?.makeDefaultLibrary();
        let vertexFunction = library?.makeFunction(name: "basic_vertex_shader");
        let fragmentFunction = library?.makeFunction(name: "basic_fragment_shader");
        
        let renderPipelineDescriptor = MTLRenderPipelineDescriptor();
        renderPipelineDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm;
        renderPipelineDescriptor.vertexFunction = vertexFunction;
        renderPipelineDescriptor.fragmentFunction = fragmentFunction;
        do {
            renderPipelineState = try device?.makeRenderPipelineState(descriptor: renderPipelineDescriptor)
        } catch let error as NSError {
            print(error)
        }
    }
    
    override func draw(_ rect: NSRect) {
        guard let drawable = self.currentDrawable, let renderPassDescriptor = self.currentRenderPassDescriptor else { return; }
        
        let commandBuffer = commandQueue.makeCommandBuffer();
        let renderCommandEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: renderPassDescriptor)
        
        renderCommandEncoder?.setRenderPipelineState(renderPipelineState)
        
        renderCommandEncoder?.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        renderCommandEncoder?.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: vertices.count)
        
        
        renderCommandEncoder?.endEncoding()
        commandBuffer?.present(drawable)
        commandBuffer?.commit()
    }
}

