//
//  StreamView.swift
//  Exercise-Project
//
//  Created by Inagamjanov on 30/10/24.
//

import UIKit
import SwiftUI
import AVFoundation

struct StreamView: View {
    
    @State var is_front: Bool = true
    @State var is_cam_active: Bool = false
    
    @State var msg: String = ""
    @State var messages: Array<String> = []
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .center, spacing: 1) {
                ZStack(alignment: .topLeading) {
                    if is_cam_active {
                        CameraView(isCameraActive: $is_cam_active, isUsingFrontCamera: $is_front)
                            .frame(width: UIScreen.main.bounds.size.width - 122, height: 362)
                            .cornerRadius(5)
                    } else {
                        ZStack {
                            RoundedRectangle(cornerRadius: 5)
                                .frame(width: UIScreen.main.bounds.size.width - 122, height: 362)
                                .cornerRadius(5)
                            
                            Image(systemName: "video.slash.fill")
                                .foregroundColor(.white)
                                .font(.largeTitle)
                                .fontWeight(.semibold)
                        }
                    }
                    
                    Text("Inagamjanov")
                        .as_font(size: .callout, weight: .medium, color: .white, line_limit: 2, align: .leading)
                        .shadow(color: .white, radius: 15, x: 2, y: -2)
                        .padding(10)
                }
                
                VStack(alignment: .center, spacing: 1) {
                    NoVideo()
                    NoVideo()
                    NoVideo()
                }
                .padding(.trailing, 1)
            }
            .padding(.top, 2)
            
            Spacer(minLength: 0)
            
            HStack(alignment: .bottom, spacing: 10) {
                
                // Messages
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 5) {
                        ForEach(messages, id: \.self) { each in
                            Text("Inagamjanov: \(each)")
                                .as_font(size: .caption, weight: .medium, color: .black, line_limit: .max, align: .leading)
                        }
                    }
                    .padding(.top, 10)
                }
                
                Spacer(minLength: 0)
                
                VStack(alignment: .leading, spacing: 10) {
                    Buttons(img: "mic.fill") { }
                    Buttons(img: "speaker.wave.2.fill") { }
                    Buttons(img: is_cam_active ? "video.slash.fill" : "video.fill.badge.plus") {
                        is_cam_active.toggle()
                    }
                    Buttons(img: "arrow.counterclockwise") {
                        is_front.toggle()
                    }
                }
            }
            .padding(.horizontal, 10)
            .padding(.bottom, 10)
            
            HStack(alignment: .bottom, spacing: 10) {
                // TextField
                TextField("Comment", text: $msg, axis: .horizontal)
                    .as_font(size: .callout, weight: .medium, color: .black, line_limit: 1, align: .leading)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 7)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.gray, lineWidth: 1)
                    }
                
                Button {
                    if msg.isEmpty == false {
                        withAnimation {
                            messages.append(msg)
                            msg = ""
                        }
                    }
                } label: {
                    Image(systemName: "arrow.up.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                        .foregroundColor(msg.isEmpty ? .gray : Color(.systemBlue))
                        .padding(.bottom, 4)
                }
            }
            .padding(10)
            
        }
        .background(Color(.secondarySystemBackground))
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
    
    @ViewBuilder
    func NoVideo() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .frame(width: 120, height: 120)
                .foregroundColor(.black)
            
            Image(systemName: "video.slash.fill")
                .foregroundColor(.white)
                .font(.title)
                .fontWeight(.semibold)
        }
    }
    
    @ViewBuilder
    func Buttons(img: String, on_click: @escaping () -> Void) -> some View {
        Button {
            withAnimation {
                on_click()
            }
        } label: {
            Image(systemName: img)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 25, height: 25)
                .foregroundColor(.black)
                .padding(7)
                .background {
                    Circle()
                        .foregroundColor(Color(.black).opacity(0.04))
                }
        }
    }
}

struct CameraView: UIViewControllerRepresentable {
    @Binding var isCameraActive: Bool
    @Binding var isUsingFrontCamera: Bool
    
    func makeUIViewController(context: Context) -> CameraViewController {
        return CameraViewController(isUsingFrontCamera: $isUsingFrontCamera)
    }
    
    func updateUIViewController(_ uiViewController: CameraViewController, context: Context) {
        uiViewController.updateCamera(isUsingFrontCamera: isUsingFrontCamera)
    }
}

class CameraViewController: UIViewController {
    var captureSession: AVCaptureSession?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    @Binding var isUsingFrontCamera: Bool
    
    init(isUsingFrontCamera: Binding<Bool>) {
        self._isUsingFrontCamera = isUsingFrontCamera
        super.init(nibName: nil, bundle: nil)
        setupCamera()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Coder has not been implemented")
    }
    
    func setupCamera() {
        captureSession = AVCaptureSession()
        updateCamera(isUsingFrontCamera: isUsingFrontCamera)
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
        videoPreviewLayer?.videoGravity = .resizeAspectFill
        videoPreviewLayer?.frame = view.layer.bounds
        view.layer.addSublayer(videoPreviewLayer!)
        captureSession?.startRunning()
    }
    
    func updateCamera(isUsingFrontCamera: Bool) {
        captureSession?.stopRunning()
        captureSession?.inputs.forEach { input in
            captureSession?.removeInput(input)
        }
        
        guard let camera = getCamera(usingFrontCamera: isUsingFrontCamera) else { return }
        let input = try? AVCaptureDeviceInput(device: camera)
        
        if let input = input, captureSession!.canAddInput(input) {
            captureSession!.addInput(input)
            captureSession?.startRunning()
        }
    }
    
    func getCamera(usingFrontCamera: Bool) -> AVCaptureDevice? {
        let cameras = AVCaptureDevice.DiscoverySession(
            deviceTypes: [.builtInWideAngleCamera],
            mediaType: .video,
            position: .unspecified).devices
        
        return usingFrontCamera ? cameras.first(where: { $0.position == .front }) : cameras.first(where: { $0.position == .back })
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        videoPreviewLayer?.frame = view.layer.bounds
    }
}
