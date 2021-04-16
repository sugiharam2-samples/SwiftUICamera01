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

struct CameraView: UIViewRepresentable {
	func makeUIView(context: Context) -> UIView { BaseCameraView() }
	func updateUIView(_ uiView: UIViewType, context: Context) {}
}

class BaseCameraView: UIView {
	override func layoutSubviews() {
		super.layoutSubviews()
		_ = initCaptureSession
		(layer.sublayers?.first as? AVCaptureVideoPreviewLayer)?.frame = frame
	}

	lazy var initCaptureSession: Void = {
		guard let device = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera],
															mediaType: .video,
															position: .unspecified)
				.devices.first(where: { $0.position == .front }),
			  let input = try? AVCaptureDeviceInput(device: device) else { return }

		let session = AVCaptureSession()
		session.addInput(input)
		session.startRunning()

		layer.insertSublayer(AVCaptureVideoPreviewLayer(session: session), at: 0)
	}()
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
