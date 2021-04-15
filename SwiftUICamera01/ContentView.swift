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
	func makeUIView(context: Context) -> UIView {
		CameraBaseView()
	}

	func updateUIView(_ uiView: UIViewType, context: Context) {}
}

class CameraBaseView: UIView {
	override func layoutSubviews() {
		super.layoutSubviews()

		_ = initCaptureSession

		if let previewLayer = layer.sublayers?.first as? AVCaptureVideoPreviewLayer {
			previewLayer.videoGravity = .resizeAspectFill
			previewLayer.connection?.videoOrientation = UIDevice.current.orientation.video
			previewLayer.frame = frame
		}
	}

	lazy var initCaptureSession: Void = {
		guard let device = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera],
															mediaType: .video,
															position: .unspecified)
				.devices.first(where: { $0.position == .front }),
			  let input = try? AVCaptureDeviceInput(device: device) else { return }

		let session = AVCaptureSession()
		session.sessionPreset = .photo
		session.addInput(input)
		session.startRunning()

		layer.insertSublayer(AVCaptureVideoPreviewLayer(session: session), at: 0)
	}()
}

extension UIDeviceOrientation {
	var video: AVCaptureVideoOrientation {
		print(self.rawValue)
		switch self {
		case .portrait:
			return .portrait
		case .portraitUpsideDown:
			return .portraitUpsideDown
		case .landscapeRight:
			return .landscapeLeft
		case .landscapeLeft:
			return .landscapeRight
		default:
			return .portrait
		}
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
