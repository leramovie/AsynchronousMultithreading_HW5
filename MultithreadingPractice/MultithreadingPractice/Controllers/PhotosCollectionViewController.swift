//
//  PhotosCollectionViewController.swift
//  MultithreadingPractice
//
//  Created by Valery Shel on 09.02.2021.
//

import UIKit


final class PhotosCollectionViewController: UICollectionViewController {
    
    var photoData: NetworkPhoto = NetworkPhoto()

    override func viewDidLoad() {
        super.viewDidLoad()

        photoData.onDataChanged = { self.collectionView.reloadData() }
        photoData.load()
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        self.collectionView.register(UINib(nibName: "PhotoCollectionCell", bundle: nil), forCellWithReuseIdentifier: "PhotoCollectionCell")
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.backgroundColor = #colorLiteral(red: 0.1994589269, green: 0.2107458413, blue: 0.2646746039, alpha: 1)
        self.title = "Photo"

    }
}


// MARK: UICollectionViewDelegate

extension PhotosCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoData.photoItems.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionCell", for: indexPath) as! PhotoCollectionCell
        
        cell.photoActivityIndicator.startAnimating()
        //Устанавливаем картинку и текст в ячейку из хранимых данных
        let photo = photoData.photoItems[indexPath.item]
        cell.setupCell(photo: photo)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 260)
    }
    
    

        
}

   
    
    

    

