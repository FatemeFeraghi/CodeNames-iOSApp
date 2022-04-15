//
//  API.swift
//  CodeNames
//
//  Created by Fateme Feraghi on 2022-04-15.
//

import Foundation


class API {
    
    
    static func httpStatusCode( response : Any ) -> Int? {
        
        if let httpResponse = response as? HTTPURLResponse {
            return httpResponse.statusCode
        } else {
            return nil
        }
        
    }
    
    
    static func call( baseURL : String,
                      endPoint : String,
                      method : String = "POST",
                      payload : [String:Any],
                      successHandler: @escaping (_ httpStatusCode : Int, _ response : [String]) -> Void,
                      failHandler : @escaping (_ httpStatusCode : Int, _ errorMessage: String) -> Void) {
        
        let Url = String(format: "\(baseURL)\(endPoint)")
        guard let serviceUrl = URL(string: Url) else { return }
        
        var httpStatusCode : Int = 0
        
        var request = URLRequest(url: serviceUrl)
        
        request.httpMethod = method.uppercased()
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        
//        for (key, value) in header {
//            request.setValue(value, forHTTPHeaderField: key)
//        }
        
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: payload, options: []) else {
            failHandler(httpStatusCode, "Unknow data received from server.")
            return
        }
        if payload.count > 0 {
            request.httpBody = httpBody
        }
        
        let session = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            
            if error == nil && data != nil {
                
                httpStatusCode = API.httpStatusCode( response : response! ) ?? 0
                
                if let response = data {
                    do {
                        print(response)
                        
                        if let jsonObject = try JSONSerialization.jsonObject(with: response, options : []) as? [String]{
                            
                            print(jsonObject)
                            print("*** HTTP Response Code: \(httpStatusCode)")
                            
                            if !(200..<300).contains(httpStatusCode)
                            {
                                    failHandler(httpStatusCode, "Something went wrong! (http code: \(httpStatusCode))")
                                return
                            }
                            
                            successHandler(httpStatusCode, jsonObject)
                            return
                            
                        }
                    } catch {
                        failHandler(httpStatusCode, "Something went wrong when decoding server response!")
                        return
                    }
                } else {
                    failHandler(httpStatusCode, "Unknow data received from the server!")
                    return
                }
                
            } else {
                print(error!)
                let errorMsg = "Fetch failed: \(error?.localizedDescription ?? "Unknown error")"
                failHandler(httpStatusCode, errorMsg)
                return
            }
            
        }.resume()
        
    }
    
    
    
    
}
