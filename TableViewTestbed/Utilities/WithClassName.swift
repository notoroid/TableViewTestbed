//
//  WithdrawClassName.swift
//  TableViewTestbed
//
//  Created by 能登 要 on 2024/02/18.
//

import Foundation

protocol WithClassName: NSObject {
    
}

extension WithClassName {
    static var className: String {
        NSStringFromClass(Self.self).components(separatedBy: ".").last ?? ""
    }
}
