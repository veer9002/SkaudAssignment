//
//  HttpUtility.swift
//  SkaudAssignment
//
//  Created by Manish Sharma on 06/03/21.
//  Copyright © 2021 Manish Sharma. All rights reserved.
//

import Foundation

struct HttpUtility {
    
    func getApiData<T:Decodable>(requestUrl: URL,resultType: T.Type, completionHandler:@escaping(_ result: T?)-> Void)
    {
        URLSession.shared.dataTask(with: requestUrl) { (responseData, httpUrlResponse, error) in
            if(error == nil && responseData != nil && responseData?.count != 0)
            {
                //parse the responseData here
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(T.self, from: responseData!)
                    _=completionHandler(result)
                }
                catch let error{
                    debugPrint("error occured while decoding = \(error)")
                }
            }

        }.resume()
    }

}


