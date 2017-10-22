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
    
    var currentUser: SplitterUser!
    
    private let billID = UUID().uuidString

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
    
    private let activityIndicator = ActivityIndicator(text: Localized.extractingTextMessage,
                                                      isDarkIndicator: true)
    
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
        view.addSubview(activityIndicator)
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
        
        activityIndicator.hide()
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
        titleLabel.addHeightConstraint(with: Layout.titleLabelHeight)
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
        goToMyBillsViewController()
    }
    
    private func goToMyBillsViewController() {
        let myBillsViewController = MyBillsViewController(currentUser: currentUser!)
        view.window?.rootViewController = myBillsViewController
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
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        recieptImageAndInstructionView.image = image
        recieptImageAndInstructionView.instructionLabel.isHidden = true
        dismiss(animated:true,
                completion: nil)
        
    }
    
    @objc private func saveButtonWasTapped() {
        let ocrRequest = OCRRequest()
        guard let image = recieptImageAndInstructionView.base64Image else { return }
        var imageURL: String = ""
        createImageURL(complete: {url in
            imageURL = url
        })
        
        activityIndicator.show()
        ocrRequest.uploadReceiptImage(image: image,
                                      complete: { textResult in
            if let textResult = textResult {
                let items = self.createItems(textResult)
                self.createBill(items: items,
                                imageURL: imageURL)
            }
            self.activityIndicator.hide()
        })
    }
    
    private func createItems(_ textResult: String) -> [Item] {
        var items = [Item]()
        let ocrResultConverter = OCRResultConverter()
        let receiptLines = textResult.components(separatedBy: .newlines)
        receiptLines.forEach { line in
            var receiptLine = line
            let newItems = ocrResultConverter.convertToItems(&receiptLine,
                                                             billID: billID)
            newItems.forEach { item in
                items.append(item)
            }
        }
        
        return items
    }
    
    private func createBill(items: [Item],
                            imageURL: String) {
        let firebaseData = FirebaseData()
        let name = nameTextField.text ?? ""
        let location = locationTextField.text ?? ""
        let bill = Bill(id: billID,
                        userID: self.currentUser.id,
                        name: name,
                        location: location,
                        imageURL: imageURL,
                        items: items)
        
        firebaseData.createBill(bill,
                                completion: { error in
            if let error = error {
                print(error)
            }
            self.goToMyBillsViewController()
        })
    }
    
    private func createImageURL(complete: @escaping((String) -> Void)) {
        var imageURL = ""
        let firebaseStorage = FirebaseStorage()
        let imageData = UIImageJPEGRepresentation(recieptImageAndInstructionView.image!, 0.5)!
        firebaseStorage.uploadImage(billId: billID,
                                    imageData: imageData,
                                    completion: { url in
            if let url = url {
                imageURL = url.absoluteString
            }
            complete(imageURL)
        })
    }
}
