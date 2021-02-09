//
//  NetworkPhoto.swift
//  MultithreadingPractice
//
//  Created by Valery Shel on 09.02.2021.
//

import UIKit
import SwiftyJSON

struct PhotoRealData {
    var albumId: Int
    var id: Int
    var title: String?
    var thumbnailUrl: String?
    
}

final class NetworkPhoto {
    
    var photoItems = [PhotoRealData]() {
        didSet {
            self.onDataChanged?()
        }
    }
    
    var onDataChanged: (() -> Void)?
    
    init() {}
    
    func load() {
        
        downloadPhotosJSON() { [weak self] result in
            
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case let .failure(error):
                    print("Downloading failed with error")
                case let .success(photoItems):
                    self.photoItems = photoItems
                }
            }
        }
    }
    
    enum DownloadError: Error {
        case emptyData
    }
    
    func downloadPhotosJSON(completion: @escaping (Result<[PhotoRealData], Error>) -> ()) {
        
        let url = URL(string: "https://jsonplaceholder.typicode.com/photos")
        
        guard let downloadURL = url else { return }
        let session = URLSession.shared
        session.dataTask(with: downloadURL) { data, response, error in
            
            if let response = response {
                print(response )
            }
            
            guard let data = data, error == nil else {
                completion(.failure(error ?? DownloadError.emptyData))
                return
            }
            
            do {
                let json = try JSON(data: data)
                // let items = json["photos"]
                var photoItems: [PhotoRealData] = []
                
                for item in json.arrayValue {
                    let albumId = item["albumId"].intValue
                    let id = item["id"].intValue
                    let title = item["title"].stringValue
                    let thumbnailUrl = item["thumbnailUrl"].stringValue
                    
                    photoItems.append(PhotoRealData(albumId: albumId, id: id, title: title, thumbnailUrl: thumbnailUrl))
                }
                completion(.success(photoItems))
            } catch {
                completion(.failure(error))
                print(error)
            }
        }.resume()
        
    }
}
