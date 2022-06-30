//
//  MD5.swift
//  ScriptRunner
//
//  Created by Grande, Christopher A on 6/29/22.
//

// function to return the Md5 hash of a file

import Foundation
import CryptoKit

extension String {
var MD5: String {
        let computed = Insecure.MD5.hash(data: self.data(using: .utf8)!)
        return computed.map { String(format: "%02hhx", $0) }.joined()
    }
}
