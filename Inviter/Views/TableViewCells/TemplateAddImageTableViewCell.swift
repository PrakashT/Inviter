//
//  TemplateAddImageTableViewCell.swift
//  Inviter
//
//  Created by Manikanta Prakash Toram on 9/1/18.
//  Copyright © 2018 Manikanta Prakash Toram. All rights reserved.
//

import UIKit
import MBProgressHUD

protocol TemplateAddImageTableViewCellDelegate:class {
    
    func didUpdateImageInfo(imageInfo:Image, s3Object:String)
}

class TemplateAddImageTableViewCell: UITableViewCell, UICollectionViewDataSource, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, TemplateAddImageCollectionViewCellDelegate {

    weak var delegate:TemplateAddImageTableViewCellDelegate?
    
    @IBOutlet weak var dottedBGView: UIView!
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    @IBOutlet weak var numberOfImagesLbl: UILabel!
    
    var selectedAddImageInfo: Image?
    var selectedImageBGView: UIView?
    var selectedImageView: UIImageView?
    var imagesListDic: [String:UIImage] = [:]

    var parentVC: TemplateEditViewController!
    private var imagesList = [Image]()
    
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
    
    func setupViewData(imagesDatalist: [Image])
    {
        imagesList = imagesDatalist
        numberOfImagesLbl.text = String(imagesList.count)+" images"
        
        imagesCollectionView.reloadData()
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        let numberOfItems = (imagesList.count%2 == 0) ? imagesList.count/2 : (imagesList.count/2)+1
        return (imagesList.count > 0) ? numberOfItems : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TemplateAddImageCollectionViewCellID", for: indexPath) as! TemplateAddImageCollectionViewCell
        cell.delegate = self
        
        let secondItemIndex = (indexPath.item*2)+1
        let imageInfo2 = (secondItemIndex == imagesList.count) ? nil : imagesList[secondItemIndex]
        let imageInfo1 = imagesList[secondItemIndex-1]
        cell.setupViewData(imageInfo1: imageInfo1, imageInfo2: imageInfo2, imagesDic: imagesListDic)
        
        return cell
    }
    
    // MARK:- TemplateAddImageCollectionViewCellDelegate Methods
    
    func addImageButtonClicked(_ imageBGView: UIView, imageView: UIImageView, imageInfo: Image) {
        downloadSheet(imageBGView, imageView: imageView, imageInfo: imageInfo)
    }
    
    func removeImageInfo(imageInfo: Image)
    {
        self.delegate?.didUpdateImageInfo(imageInfo: self.selectedAddImageInfo!, s3Object:"")
    }
    
    // MARK:- Add Image Related Methods

    func downloadSheet(_ imageBGView: UIView, imageView: UIImageView, imageInfo: Image)
    {
        selectedImageBGView = imageBGView
        selectedImageView = imageView
        selectedAddImageInfo = imageInfo
        
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
    
    func openCameraButton()
    {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
//            imagePicker.delegate = self
            imagePicker.sourceType = .camera;
            imagePicker.allowsEditing = false
            parentVC.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func openGallery()
    {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = UIImagePickerControllerSourceType.savedPhotosAlbum
        imagePickerController.allowsEditing = true
        parentVC.present(imagePickerController, animated: true)
    }
    
    func uploadImage(image: UIImage)
    {
        let header = AppHelper.Instance.getUserAuthParameters()
        let imgData = UIImageJPEGRepresentation(image, 0.2)!
        
        let progressHUD = MBProgressHUD.showAdded(to: parentVC.view, animated: true)
        
        NetworkManager.Instance.uploadImage(imgData, header: header, url: APIConstants.POST_MEDIA_DATA) { (result) in
            progressHUD.hide(animated: true)

            for data in result.dictionary!
            {
                print("DATA", data.value)
                
//                let newImageInfo = Image(type: (self.selectedAddImageInfo?.type)!, inputType: (self.selectedAddImageInfo?.inputType)!, index: (self.selectedAddImageInfo?.index)!, s3Object:(data.value.rawValue as? String)! , fileLocation: (self.selectedAddImageInfo?.fileLocation)!, enableCropping: (self.selectedAddImageInfo?.enableCropping)!, croppingShape: ((self.selectedAddImageInfo?.croppingShape))!, viewportWidth: (self.selectedAddImageInfo?.viewportWidth)!, viewportHeight: (self.selectedAddImageInfo?.viewportHeight)!, boundaryWidth: (self.selectedAddImageInfo?.boundaryWidth)!, boundaryHeight: (self.selectedAddImageInfo?.boundaryHeight)!)
//                self.selectedAddImageInfo?.s3Object = (data.value.rawValue as? String)!
//                let newImageInfo = Image()
//                newImageInfo.s3Object = (data.value.rawValue as? String)!
                self.delegate?.didUpdateImageInfo(imageInfo: self.selectedAddImageInfo!, s3Object:(data.value.rawValue as? String)!)
            }
        }
    }
    
    // MARK:- UIImagePickerController Delegates
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        picker.dismiss(animated: true, completion: nil)

        if let pickedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            
            selectedImageBGView?.isHidden = false
            selectedImageView?.image = pickedImage
            
            let key = selectedAddImageInfo?.index.description
            imagesListDic[key!] = pickedImage
            uploadImage(image: pickedImage)
        }
    }
    
}
