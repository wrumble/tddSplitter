//
//  BillsCarouselDatasource.swift
//  Splitter
//
//  Created by Wayne Rumble on 18/09/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import Foundation
import iCarousel

class BillCarouselDatasource: NSObject, iCarouselDataSource {
    
    var bills = [Bill]()
    var superView = UIView()
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return bills.count
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let bill = bills[index]
        let billCarouselView = BillCarouselView(bill: bill)
        billCarouselView.frame = CGRect(x: Layout.carouselViewX,
                                        y: Layout.carouselViewY,
                                        width: Layout.carouselViewWidth,
                                        height: Layout.carouselViewHeight)
        
        return billCarouselView
    }
}
