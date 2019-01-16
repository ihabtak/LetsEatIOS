//
//  Dataen.swift
//  Letseat
//
//  Created by MAC on 16/01/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

/*import Foundation
import CryptoSwift

extension String {
    func aesEncrypt(key: String, iv: String) throws -> String{
        let data = self.dataUsingEncoding(NSUTF8StringEncoding)
        let enc = try AES(key: key, iv: iv, blockMode:.CBC).encrypt(data!.arrayOfBytes(), padding: PKCS7())
        let encData = NSData(bytes: enc, length: Int(enc.count))
        let base64String: String = encData.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0));
        let result = String(base64String)
        return result
    }
    
    func aesDecrypt(key: String, iv: String) throws -> String {
        let data = NSData(base64EncodedString: self, options: NSDataBase64DecodingOptions(rawValue: 0))
        let dec = try AES(key: key, iv: iv, blockMode:.CBC).decrypt(data!.arrayOfBytes(), padding: PKCS7())
        let decData = NSData(bytes: dec, length: Int(dec.count))
        let result = NSString(data: decData, encoding: NSUTF8StringEncoding)
        return String(result!)
    }
}*/

/*let key = "bbC2H19lkVbQDfakxcrtNMQdd0FloLyw" // length == 32
let iv = "gqLOHUioQ0QjhuvI" // length == 16
let s = "string to encrypt"
let enc = try! s.aesEncrypt(key, iv: iv)
let dec = try! enc.aesDecrypt(key, iv: iv)
print(s) // string to encrypt
print("enc:\(enc)") // 2r0+KirTTegQfF4wI8rws0LuV8h82rHyyYz7xBpXIpM=
print("dec:\(dec)") // string to encrypt
print("\(s == dec)") // true
 */
