//
//  WeatherDataManager.swift
//  Sky
//
//  Created by Rick on 2018/9/10.
//  Copyright © 2018 cn.rick96. All rights reserved.
//

import Foundation

enum DataManagerError: Error {
    case failedRequest
    case invalidResponse
    case unknown
}

final class WeatherDataManager {
    internal let baseURL: URL
    internal let urlSession: URLSessionProtocol
    internal init(baseURL: URL, urlSession: URLSessionProtocol ) {
        self.baseURL = baseURL
        self.urlSession = urlSession
    }
    
    static let shared = WeatherDataManager(baseURL: API.authenticatedURL, urlSession: URLSession.shared )
    typealias CompletionHandler = (WeatherData?, DataManagerError?) -> Void
    
    func weatherDataAt(latitude: Double, longitude: Double, completion: @escaping CompletionHandler) {
        
        //判断本机是否为中文，如果为中文则添在url中添加参数 ?lang=zh 以获取中文天气
        let transformationBeforeURL = baseURL.appendingPathComponent("\(latitude),\(longitude)/")
        let appendStr = UserDefaults.getCurrentLanguage() == "CN" ? "?lang=zh" : ""

        var urlStr = transformationBeforeURL.absoluteString
        urlStr += appendStr
        let transformationAfterURL = URL(string: urlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
        
        var request = URLRequest(url: transformationAfterURL!)
        request.setValue("application/json", forHTTPHeaderField: "Content-type")
        request.httpMethod = "GET"
        
        self.urlSession.dataTask(with: request, completionHandler: {(data, response, error) in
            DispatchQueue.main.async {
                self.didFinishGettingWeatherData(data: data, response: response, error: error, completion: completion)
            }
        }).resume()
    }
    func didFinishGettingWeatherData(data: Data?, response: URLResponse?, error: Error?, completion: CompletionHandler) {
        if let _ = error {
            completion(nil,.failedRequest)
        } else if let data = data, let response = response as? HTTPURLResponse  {
            if response.statusCode == 200 {
                do {
                    let weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
//                    print(weatherData)
//                    print("1")
                    completion(weatherData, nil)
                }
                catch {
                    print(response)
                    print("inv")
                    completion(nil, .invalidResponse)
                }
            } else {
                print("1")
                completion(nil, .failedRequest)
            }
        }
        else {
            completion(nil, .unknown)
        }
    }
}
