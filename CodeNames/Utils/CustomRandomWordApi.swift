//
//  CustomRandomWordApi.swift
//  CodeNames
//
//  Created by Matheus Cadena on 2022-04-17.
//

import Foundation

//
//  RandomWordApi.swift
//  CodeNames
//
//  Created by Fateme Feraghi on 2022-04-15.
//

import Foundation
import UIKit

class CustomRandomWordApi: Decodable {

   static func generateWords(amountOfWords : String,
                             successHandler: @escaping (_ httpStatusCode : Int, _ response : [String]) -> Void,
                             failHandler : @escaping (_ httpStatusCode : Int, _ errorMessage: String) -> Void)
    {
//    http://localhost:8080/words?quantity=25

        
        //Second API attempt
        let baseURL = "http://localhost:8080/"
        let endPoint = "words?quantity=\(amountOfWords)"

        let method = "GET"
        
        
        let payload : [String:String] = [:]
        
        API.call(baseURL: baseURL, endPoint: endPoint, method: method, payload: payload, successHandler: successHandler, failHandler: failHandler)
    }

}


struct ArrayOfRandomWordsCustom : Codable {
    
    var arrayOfWords : [String]
    
    
    static func decode( json : [String : Any] ) -> ArrayOfRandomWordsCustom? {
        
        let decoder = JSONDecoder()
        do{
            let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            let object = try decoder.decode(ArrayOfRandomWordsCustom.self, from: data)
            return object
        }catch{
            
        }
        return nil
    }
    
    
}
