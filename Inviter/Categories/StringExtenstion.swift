//
//  StringExtenstion.swift
//  Inviter
//
//  Created by Manikanta Prakash Toram on 9/22/18.
//  Copyright © 2018 Manikanta Prakash Toram. All rights reserved.
//

import UIKit

extension String {
    
    func parse<D>(to type: D.Type) -> D? where D: Decodable {
        
        let data: Data = self.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        
        do {
            let _object = try decoder.decode(type, from: data)
            return _object
            
        } catch {
            return nil
        }
}
        func convertToDictionary() -> Dictionary<String, String>? {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? Dictionary<String, String>
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}
