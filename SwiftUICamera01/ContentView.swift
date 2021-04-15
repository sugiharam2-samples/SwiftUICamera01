//
//  ContentView.swift
//  SwiftUICamera01
//
//  Created by Mamoru Sugihara on 2021/04/15.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    var body: some View {
		CameraView()
			.edgesIgnoringSafeArea(.all)
    }
}

struct CameraView: UIViewControllerRepresentable {
	func makeUIViewController(context: Context) -> ViewController {
		ViewController()
	}

	func updateUIViewController(_ uiViewController: ViewController, context: Context) {
	}
}

class ViewController: UIViewController {
	override func viewDidLoad() {
		super.viewDidLoad()

		let session = AVCaptureSession()
		session.sessionPreset = .photo

		if let device = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera],
													  mediaType: .video,
													  position: .unspecified)
			.devices.first(where: { $0.position == .front }),
		   let input = try? AVCaptureDeviceInput(device: device) {
			session.addInput(input)

			let layer = AVCaptureVideoPreviewLayer(session: session)
			layer.videoGravity = .resizeAspectFill
			layer.connection?.videoOrientation = .portrait
			layer.frame = view.frame
			view.layer.insertSublayer(layer, at: 0)

			session.startRunning()
		}
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
