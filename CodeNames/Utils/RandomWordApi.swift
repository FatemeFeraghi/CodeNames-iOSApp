//
//  RandomWordApi.swift
//  CodeNames
//
//  Created by Matheus Cadena on 2022-04-09.
//

import Foundation
import UIKit

class RandomWordApi: Decodable {

   static func generateWords(amountOfWords : String,
                             successHandler: @escaping (_ httpStatusCode : Int, _ response : [String]) -> Void,
                             failHandler : @escaping (_ httpStatusCode : Int, _ errorMessage: String) -> Void)
    {
       
        let baseURL = "https://random-word-api.herokuapp.com/"
        let endPoint = "word?number=\(amountOfWords)&swear=0"
        let method = "GET"
        
        
        let payload : [String:String] = [:]
        
        API.call(baseURL: baseURL, endPoint: endPoint, method: method, payload: payload, successHandler: successHandler, failHandler: failHandler)
    }

}


struct ArrayOfRandomWordsCurrent : Codable {
    
    var arrayOfWords : [String]
    
    
    static func decode( json : [String : Any] ) -> ArrayOfRandomWordsCurrent? {
        
        let decoder = JSONDecoder()
        do{
            let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            let object = try decoder.decode(ArrayOfRandomWordsCurrent.self, from: data)
            return object
        }catch{
            
        }
        return nil
    }
    
    
}
