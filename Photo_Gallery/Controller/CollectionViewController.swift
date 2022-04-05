//
//  CollectionViewController.swift
//  Photo_Gallery
//
//  Created by David Gunawan on 28/03/22.
//

import UIKit



private let reuseIdentifier = "collectionCell"

class CollectionViewController: UICollectionViewController {
    let product = ProductModel()
    var photos: [ProductModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
    }
    
    private func setUpCollectionView() {
        photos = product.populatePhotos()
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        collectionView
            .setCollectionViewLayout(layout, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photo = photos[indexPath.row]
        performSegue(withIdentifier: "detailVC", sender: photo)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextView = segue.destination as? DetailPhotoViewController
        nextView?.initData(product: (sender as? ProductModel)!)
    }
    
}

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? CollectionViewCell)!
        let chosenPhoto = photos[indexPath.row]
        cell.photoImage.image = UIImage(named: chosenPhoto.photoImage ?? "default")
        cell.photoTitle.text = chosenPhoto.photoTitle
        cell.backgroundColor = .systemGray6
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let lay = collectionViewLayout as! UICollectionViewFlowLayout
        let widthPerItem = collectionView.frame.width / 2 - lay.minimumInteritemSpacing
        return CGSize(width: widthPerItem - 16, height: 190)
    }
    
    
}


