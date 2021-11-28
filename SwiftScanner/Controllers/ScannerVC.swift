//
//  ScannerVC.swift
//  SwiftScanner
//
//  Created by Jason on 2018/11/30.
//  Copyright © 2018 Jason. All rights reserved.
//

import UIKit
import AVFoundation

public class ScannerVC: UIViewController {
    
    public lazy var cameraViewController: CameraVC = .init()
    
    public var animationStyle:ScanAnimationStyle = .default{
        didSet{
            cameraViewController.animationStyle = animationStyle
        }
    }
    
    public lazy var closeBtn: UIImageView = UIImageView()
    public lazy var permissionLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "test"
        label.isHidden = true
        label.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(permissionClick(tapGestureRecognizer:)))
        label.addGestureRecognizer(tapGesture)
        return label
    }()
    
    public var scannerColor: UIColor = .red{
        didSet{
            cameraViewController.scannerColor = scannerColor
        }
    }
    
    public var scannerTips:String = "" {
        didSet{
           cameraViewController.scanView.tips = scannerTips
        }
    }
    
    public var metadata = AVMetadataObject.ObjectType.metadata {
        didSet{
            cameraViewController.metadata = metadata
        }
    }
    
    public var successBlock:((String)->())?
    
    public var errorBlock:((Error)->())?
    
        
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(permissionLabel)
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized: // The user has previously granted access to the camera.
            self.setupUI()
            
        case .notDetermined: // The user has not yet been asked for camera access.
            permissionLabel.isHidden = false
        case .denied: // The user has previously denied access.
            permissionLabel.isHidden = false
        case .restricted: // The user can't grant access due to restrictions.
            permissionLabel.isHidden = false
        default:
            permissionLabel.isHidden = false
        }
        
//        setupUI()
        
    }
    
    @objc
    func permissionClick(tapGestureRecognizer: UITapGestureRecognizer) {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {
                    DispatchQueue.main.async {
                    self.setupUI()
                    }
                }
            }
        case .denied:
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
        default:
            return
        }
        
    }
    
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        cameraViewController.startCapturing()
    }
    
    
    
    
}




// MARK: - CustomMethod
extension ScannerVC {
    
    public func setupUI() {
        permissionLabel.isHidden = true
        
        if title == nil {
            title = "扫一扫"
        }
        
        view.backgroundColor = .black
        
        
        cameraViewController.metadata = metadata
        
        cameraViewController.animationStyle = animationStyle
        
        cameraViewController.delegate = self
        
        add(cameraViewController)
    }

    
    
    public func setupScanner(_ title:String? = nil, _ color:UIColor? = nil, _ style:ScanAnimationStyle? = nil, _ tips:String? = nil, _ success:@escaping ((String)->())){
        
        if title != nil {
            self.title = title
        }
        
        if color != nil {
            scannerColor = color!
        }
        
        if style != nil {
            animationStyle = style!
        }
        
        if tips != nil {
            scannerTips = tips!
        }
        
        successBlock = success
        
    }
    
    
}


extension ScannerVC: CameraViewControllerDelegate{
    
    func didOutput(_ code: String) {
        
        successBlock?(code)
        
    }
    
    func didReceiveError(_ error: Error) {
        
        errorBlock?(error)
        
    }
    
}
