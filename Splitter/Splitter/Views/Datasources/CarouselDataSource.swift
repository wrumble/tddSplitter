//
//  BillsCarouselDataSource.swift
//  Splitter
//
//  Created by Wayne Rumble on 18/09/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import Foundation
import iCarousel

class CarouselDataSource: NSObject, iCarouselDataSource {
    
    var bills = [Bill]()
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return bills.count
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let bill = bills[index]
        let billCarouselView = BillCarouselView(bill: bill)
        billCarouselView.frame = carousel.frame
        
        return billCarouselView
    }
}
