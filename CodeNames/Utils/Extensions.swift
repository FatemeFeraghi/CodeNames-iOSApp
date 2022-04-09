//
//  Extensions.swift
//  CodeNames
//
//  Created by Fateme Feraghi on 2022-03-28.
//

import UIKit

extension UIView {
    
    func addSubviews ( _ subviews : UIView... ) {
        
        for subview in subviews {
            self.addSubview(subview)
        }
        
    }
    
}

//For dictionary API
extension URLSession{
    func fetchDataDictionary(at url: URL, completion: @escaping (Result<[Word], Error>) -> Void) {
      self.dataTask(with: url) { (data, response, error) in
        if let error = error {
            completion(.failure(error))
        }

        if let data = data {
          do {
            let word = try JSONDecoder().decode([Word].self, from: data)
            completion(.success(word))
          } catch let decoderError {
              completion(.failure(decoderError))
          }
        }
      }.resume()
    }
}
