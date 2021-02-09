//
//  PhotoCollectionCell.swift
//  MultithreadingPractice
//
//  Created by Valery Shel on 09.02.2021.
//

import UIKit


class PhotoCollectionCell: UICollectionViewCell {

    
    @IBOutlet weak var photoActivityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var imageView: LoadImageFromAPI!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //Cell style
        layer.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        layer.cornerRadius = 0
    
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
    }
    
    func setupCell(photo: PhotoRealData){
        
        //Для кэширования картинок
        guard let imageURL = photo.thumbnailUrl else { return }
        self.imageView?.set(imageURL: imageURL)  //set(imageURL: imageURL) = promotion.image
   
    }


}
