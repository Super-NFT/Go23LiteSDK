//
//  Go23LiteSDKMangager.swift
//  Go23LiteSDK
//
//  Created by luming on 2023/2/17.
//

import Go23SDK

public class Go23LiteSDKMangager {
    
    public static let shared = Go23LiteSDKMangager()
    var uniqueId = "" //This value is the unique identifier of the wallet when it is registered, and it is determined by the third-party access itself
    var iconImage: UIImage?
    var nickName: String?
    
    //register appKey and secretKey for Go23SDK
    //only be used if the return value is true
    public func auth(appKey: String,
                            secretKey: String,
                            completion: @escaping ((Bool) -> Void)) {
        Go23WalletSDK.auth(appKey: appKey, secretKey: secretKey, completion: completion)
    }
    
    // uniqueId must be passed
    // email and phone number can choose one
    // uniqueId is the unique identifier of the wallet when it is registered, and it is determined by the third-party access itself
    public func initialization(uniqueId: String, email: String, phone: (String, String), iconImage: UIImage? = nil, nickName: String? = nil) {
        self.uniqueId = uniqueId
        if email.count > 0 {
            UserDefaults.standard.set(email, forKey: kEmailPrivateKey)
        }
        if phone.0.count > 0 , phone.1.count > 0 {
            UserDefaults.standard.set(phone.0+" "+phone.1, forKey: kPhonePrivateKey)
        } else {
            
        }
        
        self.iconImage = iconImage
        self.nickName = nickName
    }
    
    
    
}
