import MetalKit

class GameView: MTKView {

    var renderer: Renderer!
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        
        self.device = MTLCreateSystemDefaultDevice()
        guard let device = device else {
            print("No Device Found for Metal Versions")
            return
        }
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
}
