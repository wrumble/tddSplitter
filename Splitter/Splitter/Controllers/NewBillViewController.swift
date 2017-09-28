//
//  NewBillViewController.swift
//  Splitter
//
//  Created by Wayne Rumble on 19/09/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import UIKit

class NewBillViewController: UIViewController,
                             UIImagePickerControllerDelegate,
                             UINavigationControllerDelegate {
    
    var currentUser: SplitterUser?
    
    private var titleLabel = TitleLabel()
    private var nameTextField = SplitterTextField(accessID: AccesID.nameTextField)
    private var locationTextField = SplitterTextField(accessID: AccesID.locationTextField)
    private var cameraButton = IconButton(accessID: AccesID.cameraButton,
                                          iconImage: Image.cameraButton!)
    private var homeButton = IconButton(accessID: AccesID.homeButton,
                                          iconImage: Image.homeButton!)
    private var saveButton = IconButton(accessID: AccesID.saveButton,
                                          iconImage: Image.saveButton!)
    private var recieptImageAndInstructionView = ImageAndInstructionView()
    
    required init(currentUser: SplitterUser) {
        super.init(nibName: nil, bundle: nil)
        defer {
            self.currentUser = currentUser
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupHierarchy()
        setupViews()
        setupLayout()
    }
    
    private func setupHierarchy() {
        view.addSubview(titleLabel)
        view.addSubview(nameTextField)
        view.addSubview(locationTextField)
        view.addSubview(cameraButton)
        view.addSubview(homeButton)
        view.addSubview(saveButton)
        view.addSubview(recieptImageAndInstructionView)
    }
    
    private func setupViews() {
        view.backgroundColor = Color.mainBackground
        
        titleLabel.text = Localized.newBillViewControllerTitle
        
        cameraButton.addTarget(self,
                               action: #selector(cameraButtonWasTapped),
                               for: .touchUpInside)
        homeButton.addTarget(self,
                               action: #selector(homeButtonWasTapped),
                               for: .touchUpInside)
        saveButton.addTarget(self,
                             action: #selector(saveButtonWasTapped),
                             for: .touchUpInside)
    }
    
    private func setupLayout() {
        layoutTitleLabel()
        layoutNameTextField()
        layoutLocationTextField()
        layoutCameraButton()
        layoutHomeButton()
        layoutSaveButton()
        layoutReceiptImageAndInstructionView()
    }
    
    private func layoutTitleLabel() {
        titleLabel.pinToSuperview(edges: [.left, .right])
        titleLabel.pinTop(to: view,
                          constant: Layout.titleLabelY,
                          priority: .required,
                          relatedBy: .equal)
    }
    
    private func layoutNameTextField() {
        nameTextField.pinToSuperview(edges: [.left, .right])
        nameTextField.pinTop(to: titleLabel,
                             anchor: .bottom,
                             constant: Layout.spacer,
                             priority: .required,
                             relatedBy: .equal)
        nameTextField.addHeightConstraint(with: Layout.textFieldHeight)
    }
    
    private func layoutLocationTextField() {
        locationTextField.pinToSuperview(edges: [.left, .right])
        locationTextField.pinTop(to: nameTextField,
                                 anchor: .bottom,
                                 constant: Layout.spacer,
                                 priority: .required,
                                 relatedBy: .equal)
        locationTextField.addHeightConstraint(with: Layout.textFieldHeight)
    }
    
    private func layoutCameraButton() {
        cameraButton.pinToSuperviewLeft(withConstant: Layout.screenEdgeSpacer,
                                        priority: .required,
                                        relatedBy: .equal)
        cameraButton.pinToSuperviewBottom(withConstant: Layout.screenEdgeSpacer,
                                          priority: .required,
                                          relatedBy: .equal)
        cameraButton.addHeightConstraint(with: Layout.cameraButtonHeightWidth)
        cameraButton.addWidthConstraint(with: Layout.cameraButtonHeightWidth)
    }
    
    private func layoutHomeButton() {
        homeButton.pinToSuperviewBottom(withConstant: Layout.screenEdgeSpacer,
                                        priority: .required,
                                        relatedBy: .equal)
        homeButton.centerXToSuperview()
        homeButton.addHeightConstraint(with: Layout.homeButtonHeightWidth)
        homeButton.addWidthConstraint(with: Layout.homeButtonHeightWidth)
    }
    
    private func layoutSaveButton() {
        saveButton.pinToSuperviewRight(withConstant: -Layout.screenEdgeSpacer,
                                       priority: .required,
                                       relatedBy: .equal)
        saveButton.pinToSuperviewBottom(withConstant: Layout.screenEdgeSpacer,
                                        priority: .required,
                                        relatedBy: .equal)
        
        saveButton.addHeightConstraint(with: Layout.saveButtonHeightWidth)
        saveButton.addWidthConstraint(with: Layout.saveButtonHeightWidth)
    }
    
    private func layoutReceiptImageAndInstructionView() {
        recieptImageAndInstructionView.pinTop(to: locationTextField,
                                              anchor: .bottom,
                                              constant: Layout.spacer,
                                              priority: .required,
                                              relatedBy: .equal)
        recieptImageAndInstructionView.pinLeft(to: view,
                                               anchor: .left,
                                               constant: Layout.spacer,
                                               priority: .required,
                                               relatedBy: .equal)
        recieptImageAndInstructionView.pinRight(to: view,
                                                anchor: .right,
                                                constant: -Layout.spacer,
                                                priority: .required,
                                                relatedBy: .equal)
        recieptImageAndInstructionView.pinBottom(to: homeButton,
                                              anchor: .top,
                                              constant: -Layout.spacer,
                                              priority: .required,
                                              relatedBy: .equal)
    }
    
    @objc private func cameraButtonWasTapped() {
        let imagePicker = UIImagePickerController()
        setupImagePicker(imagePicker)
        selectSourceTypeFor(imagePicker)
        present(imagePicker,
                animated: true,
                completion: nil)
    }
    
    @objc private func homeButtonWasTapped() {
        let myBillsViewController = MyBillsViewController(currentUser: currentUser!)
        present(myBillsViewController, animated: false)
    }
    
    private func setupImagePicker(_ imagePicker: UIImagePickerController) {
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.modalPresentationStyle = .popover
    }
    
    private func selectSourceTypeFor(_ imagePicker: UIImagePickerController) {
        if  UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
            imagePicker.cameraFlashMode = .auto
            imagePicker.cameraOverlayView?.accessibilityIdentifier = AccesID.imagePicker
        } else {
            imagePicker.sourceType = .photoLibrary
            imagePicker.navigationBar.accessibilityIdentifier = AccesID.imagePicker
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true,
                completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        recieptImageAndInstructionView.image = image
        recieptImageAndInstructionView.instructionLabel.isHidden = true
        dismiss(animated:true,
                completion: nil)
    }
    
    @objc private func saveButtonWasTapped() {
        if let base64ImageData = recieptImageAndInstructionView.base64ImageData {
            let ocrRequest = OCRRequest()
            ocrRequest.createRequest(with: base64ImageData)
        }
    }
}
