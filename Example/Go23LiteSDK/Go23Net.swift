//
//  Go23Net.swift
//  Go23WalletSDKDemo
//
//  Created by luming on 2022/12/27.
//

import UIKit
import Go23SDK

class Go23Net {
    //get phone code
    static func getPhoneCode(completion: @escaping ((Go23PhoneCodeListModel?) -> Void)) {
        Go23NetworkManager.shared.postRequest(URLString: "/country", parameters: nil) { (response) in
            switch response {
            case .success(let data):
                guard let dict = data as? [String: Any],
                      let code = dict["code"] as? Int else {
                    completion(nil)
                    return
                }
                if code == 0 {
                    if let model = Go23PhoneCodeListModel.decodeJSON(from: dict) {
                        completion(model)
                    } else {
                        completion(nil)
                    }
                } else {
                    completion(nil)
                }
            case .failure:
                completion(nil)
            }
        }
    }
}


public struct Go23PhoneCodeListModel: Codable {
    @DecodableDefault.EmptyList public var data: [Go23PhoneCodeModel]
    
    enum CodingKeys: String, CodingKey {
        case data
    }
}

public struct Go23PhoneCodeModel: Codable {
    @DecodableDefault.EmptyString public var name: String
    @DecodableDefault.EmptyString public var code: String
    @DecodableDefault.EmptyString public var dialCode: String
    @DecodableDefault.EmptyString public var falgEmoji: String
    
    enum CodingKeys: String, CodingKey {
        case code
        case dialCode = "dial_code"
        case falgEmoji = "flag_emoji"
        case name
    }
}


