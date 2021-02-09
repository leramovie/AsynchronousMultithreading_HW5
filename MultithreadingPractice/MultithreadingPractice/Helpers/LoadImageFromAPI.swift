//
//  LoadImageFromAPI.swift
//  MultithreadingPractice
//
//  Created by Valery Shel on 09.02.2021.
//

import UIKit

final class LoadImageFromAPI: UIImageView{
    
    func set(imageURL: String){
        guard let url = URL(string: imageURL) else {return}
        
        if let cachedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)) {
            self.image = UIImage(data: cachedResponse.data)
            print("from cache")
            return
        }
        
        print("from internet")

        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            
            DispatchQueue.main.async {
                if let data = data, let response = response {
                    self?.image = UIImage(data: data)
                    self?.handleLoadedImage(data: data, response: response)

                }
            }
        }
        dataTask.resume()
    }
    
    // MARK: - Private methods

    private func handleLoadedImage(data: Data, response: URLResponse){
        guard let responseURL = response.url else {return}
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: responseURL))
    }
}

