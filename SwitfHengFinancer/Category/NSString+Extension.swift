//
//  NSString+Extension.swift
//  SwitfHengFinancer
//
//  Created by apple on 2020/5/14.
//  Copyright © 2020 APPLE. All rights reserved.
//

import Foundation

// MARK: MD5
extension String {
    func md5() -> String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_MD5(str!, strLen, result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        result.deinitialize(count: 0)
        return String(format: hash as String)
    }
}
