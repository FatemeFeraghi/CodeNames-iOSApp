//
//  DictionaryApi.swift
//  CodeNames
//
//  Created by Matheus Cadena on 2022-04-09.
//

import Foundation

class DictionaryApi: Decodable {
    
    static func checkWordExistance(word : String,
                                   successHandler: @escaping (_ word : String, _ response : [Word]) -> Void,
                              failHandler : @escaping (_ errorMessage: String) -> Void)
     {
        
         let baseURL = "https://api.dictionaryapi.dev/api/v2/entries/en/"
         let endPoint = word
         let url = URL(string: String(format: "\(baseURL)\(endPoint)"))!
        
         URLSession.shared.fetchDataDictionary(at: url) { result in
             switch result
             {
             case .success(let words):
                 successHandler(word, words)
                 break
             case .failure(let error):
                 failHandler(error.localizedDescription)
                 break

             }
         }
         
     }

 }



 struct DictionaryWord : Codable {
     
     let word : String
     
     
     static func decode( json : [Word] ) -> DictionaryWord? {
         
         let decoder = JSONDecoder()
         do{
             let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
             let object = try decoder.decode(DictionaryWord.self, from: data)
             return object
         }catch{
             
         }
         return nil
     }
     
     
 }
