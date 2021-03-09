//
//  ImageResources.swift
//  SkaudAssignment
//
//  Created by Manish Sharma on 07/03/21.
//  Copyright © 2021 Manish Sharma. All rights reserved.
//

import Foundation

struct ImageResources {
    private let httpUtility = HttpUtility()
   
    func getImages(request: QueryRequest, keyword: String, completionHandler: @escaping(_ result: ImageResponse?) -> Void) {
        let encodedString = createPercentageEncodedString(from: request.q!)
        let imageEndpoint = URL(string: "\(Endpoints.baseUrl)?key=\(Endpoints.apiKey)&q=\(encodedString!)&image_type=photo")!
    
        httpUtility.getApiData(requestUrl: imageEndpoint, resultType: ImageResponse.self) { (response) in
            
            _ = completionHandler(response)

        }
    }
    
    func getImagesWithPages(request: QueryRequest, keyword: String, page: Int, completionHandler: @escaping(_ result: ImageResponse?) -> Void) {
        let encodedString = createPercentageEncodedString(from: request.q!)
        let imageEndpoint = URL(string: "\(Endpoints.baseUrl)?key=\(Endpoints.apiKey)&q=\(encodedString!)&image_type=photo&per_page=50&page=\(page)")!
    
        httpUtility.getApiData(requestUrl: imageEndpoint, resultType: ImageResponse.self) { (response) in
            
            _ = completionHandler(response)

        }
    }
    
    func getImageById(request: QueryRequestById, completionHandler: @escaping(_ result: ImageResponse?) -> Void) {
        let imageEndpoint = URL(string: "\(Endpoints.baseUrl)?key=\(Endpoints.apiKey)&id=\(request.id!)&image_type=photo&per_page=50")!
    
        httpUtility.getApiData(requestUrl: imageEndpoint, resultType: ImageResponse.self) { (response) in
            
            _ = completionHandler(response)

        }
    }
}


func createPercentageEncodedString(from value: String) -> String?
{
    return value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
}
