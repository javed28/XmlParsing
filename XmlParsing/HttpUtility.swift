//
//  HttlUtility.swift
//  XmlParsing
//
//  Created by JAVED SIDDIQUE on 09/05/20.
//  Copyright © 2020 JAVED SIDDIQUE. All rights reserved.
//

import Foundation

class HttpUtility{
    
    var responsecompletionhandler : ((_ result : Data) -> Void)?
    
    func getApiData(request : URL,completionHandler : ((_ result : Data)-> Void)?){
        self.responsecompletionhandler = completionHandler
        let request = URLRequest(url: request)
        let urlSession = URLSession.shared
        let task = urlSession.dataTask(with: request){ (data,response,error) in
        
            guard let data = data else{
                if let error = error{
                    print(error.localizedDescription)
                }
                return
            }
            
            self.responsecompletionhandler?(data)
        }
        task.resume()
    }
}
