//
//  Requestable.swift
//  CtaReactiveMaster
//
//  Created by 山根大生 on 2020/12/26.
//

import Foundation

protocol Requestable {
    associatedtype Response: Decodable
    var url: URL { get }
}
