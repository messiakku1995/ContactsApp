//
//  APIRequestHandler.swift
//  ConnectsApp
//
//  Created by Utkarsh on 22/07/23.
//

import UIKit

import Foundation
import Alamofire
import UIKit
import IHProgressHUD


typealias CallResponse<T> = ((Result<T,Swift.Error>) -> Void)?

protocol APIRequestHandler{

}
extension APIRequestHandler where Self: URLRequestBuilder {
    
    func send<T: CodableInitWithDecodable>(_ isShowLoader: Bool,
                                           _ decoder: T.Type,
                                           data: UploadData? = nil,
                                           request: String = "",
                                           requestInterval: TimeInterval = 30,
                                           getEtagResponse: ((_ eTag: String) -> Void)? = nil,
                                           then: CallResponse<T>) {
        if networkNotReachable(then: then) { return }
        if isShowLoader{
            // show loader view
            DispatchQueue.global(qos: .default).async(execute: {
                LoaderView().showHood()
            })
        }
        var requestURL: URLRequest?
        if request != ""{
            var url = URL(string: "\(self.mainURL.absoluteString)\(request)")!
            
            requestURL = URLRequest(url: url)
            
            if !self.parameters!.isEmpty {
                do {
                    // convert parameters to Data and assign dictionary to httpBody of request
                    requestURL?.httpBody = try JSONSerialization.data(withJSONObject: self.parameters!, options: .prettyPrinted)
                  } catch let error {
                    print(error.localizedDescription)
                    return
                  }
            }
            
            //requestURL?.httpBody = customparams.percentEncoded()
            
            requestURL?.httpMethod = method.rawValue //customMethod!.rawValue
            requestURL?.setValue("application/json", forHTTPHeaderField:"Content-Type")
            requestURL?.addValue("application/json", forHTTPHeaderField: "Accept")
            headers.forEach { requestURL?.addValue($0.value, forHTTPHeaderField: $0.name) }
        }
        
        print("request::", self.urlRequest,"parameter::",self.parameters)
         print("request::", requestURL?.urlRequest)
        if let data = data {
            // POST and PUT Api case
            uploadToServerWith(isShowLoader, decoder, data: data, request: self.mainURL, parameters: self.parameters, then: then)

        }else{
        
            AF.request(requestURL ?? self).responseDecodable(of: T.self) { (response) in
                print("response::", response)
                if isShowLoader {
                    //hiode loader
                    DispatchQueue.global(qos: .default).async(execute: {
                    // time-consuming task
                    IHProgressHUD.dismiss()
                    })
                }
                print("success response::",String(data: response.data ?? Data(), encoding: .utf8) )
                switch response.result {
                case .success:
                    print("response::", response.result)
                    guard let data = response.data else {
                        let newError = NSError(domain: "Something went worng", code: 0)
                        then?(Result<T, Error>.failure(newError))
                        return
                    }
                    do {
                        let modules = try T(data: data)
                        then?(Result<T, Error>.success(modules))
                    } catch {
                        then?(Result<T, Error>.failure(error))
                    }
                case .failure(let error):
                    print("response failure::", response.result)
                    then?(Result<T, Error>.failure(error))
                }
            }
        }
        
    }

}
extension APIRequestHandler{
    private func networkNotReachable<T: CodableInitWithDecodable>(then: CallResponse<T>) -> Bool {
        if !NetworkReachabilityManager()!.isReachable {
            displayToastMessageOutside("No Internet Connection")
           //hide loader view
            DispatchQueue.global(qos: .default).async(execute: {
            // time-consuming task
            IHProgressHUD.dismiss()
            })
            return true
        }
        return false
    }
    private func uploadToServerWith<T: CodableInitWithDecodable>(_ isShowLoader: Bool, _ decoder: T.Type, data: UploadData, request: URLConvertible, parameters: Parameters?, then: CallResponse<T>) {
        
        AF.upload(multipartFormData: { (mul) in
            mul.append(data.data, withName: data.name, fileName: data.fileName, mimeType: data.mimeType)
            guard let parameters = parameters else { return }
            for (key, value) in parameters {
                mul.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
        }, to: request).responseData(completionHandler: { results in
            DispatchQueue.global(qos: .default).async(execute: {
            // time-consuming task
            IHProgressHUD.dismiss()
            })
           // self.handleAppUpdateIfNeeded(false, results)
        })
    }

}

extension Dictionary {
    func percentEncoded() -> Data? {
        map { key, value in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
        .data(using: .utf8)
    }
}

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="
        
        var allowed: CharacterSet = .urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}

struct UploadData {
    var data: Data
    var fileName, mimeType, name: String
}
