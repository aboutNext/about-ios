//
//  Highlight.swift
//  About
//
//  Created by yunseo on 11/20/19.
//  Copyright © 2019 aboutNext. All rights reserved.
//

import Foundation

struct Highlight {
    var highlightID: UUID
    var date: Date
    var title: String
    var memo: String?
    var isSuccess: Bool?

    init(highlightID: UUID, date: Date, title: String) {
        self.highlightID = highlightID
        self.date = date
        self.title = title
    }
}
