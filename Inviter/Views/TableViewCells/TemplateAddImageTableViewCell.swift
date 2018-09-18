//
//  TemplateAddImageTableViewCell.swift
//  Inviter
//
//  Created by Manikanta Prakash Toram on 9/1/18.
//  Copyright © 2018 Manikanta Prakash Toram. All rights reserved.
//

import UIKit

class TemplateAddImageTableViewCell: UITableViewCell, UICollectionViewDataSource, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, TemplateAddImageCollectionViewCellDelegate {

    @IBOutlet weak var dottedBGView: UIView!
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    var selectedAddImageButton: UIButton?
    var parentVC: TemplateEditViewController!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        AppHelper.Instance.setDottedLineToView(yourView: dottedBGView)
//        dottedBGView.layer.borderColor = UIColor.red.cgColor
//        dottedBGView.layer.borderWidth = 5.0
        // Initialization code
        
        imagesCollectionView.register(UINib.init(nibName: "TemplateAddImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TemplateAddImageCollectionViewCellID")
        setCollectionViewCellSize(collectionView: imagesCollectionView)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCollectionViewCellSize(collectionView: UICollectionView)
    {
        let cellWidth = (collectionView.frame.width)/4
        let cellSize = CGSize(width: cellWidth, height:(cellWidth*2.0)) // Every cell have two subcells data
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = cellSize
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.reloadData()
        
        collectionView.layoutIfNeeded()
    }
    
    @IBAction func showAddImagesViewButtonClicked(_ sender: UIButton)
    {
        dottedBGView.isHidden = true
        imagesCollectionView.isHidden = false
    }
    
    // MARK: - UICollectionViewDataSource Methods
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TemplateAddImageCollectionViewCellID", for: indexPath) as! TemplateAddImageCollectionViewCell
        cell.delegate = self
        return cell
        }
    
    // MARK:- TemplateAddImageCollectionViewCellDelegate Methods
    func addImageButton1Clicked(_ sender: UIButton) {
        downloadSheet(sender: sender)
    }
    
    func addImageButton2Clicked(_ sender: UIButton) {
        downloadSheet(sender: sender)
    }
    
    // MARK:- Add Image Related Methods

    @IBAction func downloadSheet(sender: UIButton)
    {
        selectedAddImageButton = sender
        
        let alertController = UIAlertController(title: "Choose Option", message: "Please select option.", preferredStyle: UIAlertControllerStyle.actionSheet)
        alertController.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action) in
            self.openCameraButton()
        }))
        alertController.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { (action) in
            self.openGallery()
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action) in
            alertController.dismiss(animated: true, completion: nil)
        }))
        self.parentVC.present(alertController, animated: true, completion: nil)
    }
    
    func openCameraButton() {
       
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            var imagePicker = UIImagePickerController()
//            imagePicker.delegate = self
            imagePicker.sourceType = .camera;
            imagePicker.allowsEditing = false
            parentVC.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func openGallery()
    {
        var imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = UIImagePickerControllerSourceType.savedPhotosAlbum
        imagePickerController.allowsEditing = true
        parentVC.present(imagePickerController, animated: true)
    }
    
    func uploadImage(image: UIImage)
    {
        let header = AppHelper.Instance.getUserAuthParameters()
        let imgData = UIImageJPEGRepresentation(image, 0.2)!
        
//        let parameters = ["name": rename] //Optional for extra parameter
        
        NetworkManager.Instance.uploadImage(imgData, header: header, url: APIConstants.POST_MEDIA_DATA) { (result) in
            
        }
    }
    
    // MARK:- UIImagePickerController Delegates
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        picker.dismiss(animated: true, completion: nil)

        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
//            selectedAddImageButton?.contentMode = .center
            selectedAddImageButton?.setImage(pickedImage, for: .normal)
            
            uploadImage(image: pickedImage)
            
//            let closeButton = selectedAddImageButton?.superview?.viewWithTag(11) as! UIButton
//            closeButton.isHidden = false
        }
    }
    
}
