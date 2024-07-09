import MetalKit

class GameView: MTKView {
    var renderer: Renderer!
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        guard let device = MTLCreateSystemDefaultDevice() else {
            print("No Device Found for Metal Versions")
            return
        }
        self.device = device
        print("Device Found: ", device)
        
        do {
            try Engine.shared.Ignite(device: device)
        } catch {
            print("Could not initialize Engine")
            return
        }

        self.clearColor = Preferences.clearColor
        self.colorPixelFormat = Preferences.mainPixelFormat
        
        self.renderer = Renderer()
        self.delegate = renderer
    }
    
    override var acceptsFirstResponder: Bool { return true }
    override func keyDown(with event: NSEvent) {
        
    }
    
    override func keyUp(with event: NSEvent) {
        
    }
}
