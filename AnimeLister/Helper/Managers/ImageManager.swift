//
//  ImageManager.swift
//  AnimeLister
//
//  Created by Michael Craun on 6/30/19.
//  Copyright © 2019 Craunic Productions. All rights reserved.
//

import UIKit
import Photos
import YangMingShan

protocol ImageManagerDelegate: class {
    func imageManager(didFinishWith image: UIImage)
    func imageManager(didRemoveImage: Bool)
    func imageManager(didEncounterError error: String)
}

class ImageManager: NSObject, Themeable {
    private var authorizationStatus: PHAuthorizationStatus
    private var authorized: Bool {
        return authorizationStatus == .authorized
    }
    
    var delegate: ImageManagerDelegate? 
    var parent: UIViewController?
    
    override init() {
        self.authorizationStatus = PHPhotoLibrary.authorizationStatus()
    }
    
    init(parent: UIViewController) {
        self.parent = parent
        self.authorizationStatus = PHPhotoLibrary.authorizationStatus()
    }
    
    func displayOptionSheet() {
        let optionSheet = UIAlertController(title: "Add photo from...", message: nil, preferredStyle: .actionSheet)
        
        optionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (_) in
            self.openCamera()
        }))
        
        optionSheet.addAction(UIAlertAction(title: "Photo Album", style: .default, handler: { (_) in
            self.openImagePicker()
        }))
        
        optionSheet.addAction(UIAlertAction(title: "Remove Picture", style: .destructive, handler: { (_) in
            self.delegate?.imageManager(didRemoveImage: true)
        }))
        
        optionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        parent?.present(optionSheet, animated: true, completion: nil)
    }
    
    private func openImagePicker() {
        if authorized && UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            
            self.parent?.present(imagePicker, animated: true, completion: nil)
        } else {
            print("IMAGE: Not authorized or photo library unavailable")
            updateAuthorization { (isAuthorized) in
                if isAuthorized {
                    self.openImagePicker()
                }
            }
        }
    }
    
    private func openCamera() {
        if authorized && UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraController = UIImagePickerController()
            cameraController.allowsEditing = true
            cameraController.cameraCaptureMode = .photo
            cameraController.cameraDevice = .front
            cameraController.cameraFlashMode = .auto
            cameraController.delegate = self
            cameraController.mediaTypes = UIImagePickerController.availableMediaTypes(for: .camera)!
            
            self.parent?.present(cameraController, animated: true, completion: nil)
        } else {
            print("IMAGE: Not authorized or camera unavailable")
            updateAuthorization { (isAuthorized) -> Void in
                if isAuthorized {
                    self.openCamera()
                }
            }
        }
    }
    
    private func updateAuthorization(completion: @escaping (Bool) -> Void) {
        authorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch authorizationStatus {
        case .authorized:
            completion(true)
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({ (_) in completion(true) })
        case .restricted:
            completion(false)
        case .denied:
            completion(false)
        default:
            print("IMAGE: authorization status:", authorizationStatus)
            completion(false)
        }
    }
}

extension ImageManager: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            delegate?.imageManager(didFinishWith: image)
        } else if let image = info[.originalImage] as? UIImage {
            delegate?.imageManager(didFinishWith: image)
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
}
