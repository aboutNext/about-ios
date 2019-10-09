//
//  CardData.swift
//  About
//
//  Created by yunseo on 10/9/19.
//  Copyright © 2019 aboutNext. All rights reserved.
//

import Foundation
import UIKit

struct CardData {
    var cardID: UUID
    var date: Date
    var imageName: String?
    var image: UIImage?
    var title: String?
    var contents: NSString?

    init(cardID: UUID, date: Date) {
        self.cardID = cardID
        self.date = date
    }
}
//
//class CardData: NSObject {
//    var cardID: UUID
//    var date: Date
//    var image: String?
//    var title: String?
//    var contents: NSString?
//
//    convenience init(cardID: UUID, date: Date) {
//        self.init(cardID: cardID, date: date)
//
//    }
//}
