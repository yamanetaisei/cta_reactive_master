//
//  NewsDataModel.swift
//  CtaReactiveMaster
//
//  Created by 山根大生 on 2020/11/28.
//

import Foundation

struct NewsDataModel: Decodable {
    var author: String?
    var content: String?
    var description: String?
    var title: String?
}
