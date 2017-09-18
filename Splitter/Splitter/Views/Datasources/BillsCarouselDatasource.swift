//
//  BillsCarouselDatasource.swift
//  Splitter
//
//  Created by Wayne Rumble on 18/09/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import Foundation
import iCarousel

class BillsCarouselDatasource: NSObject, iCarouselDataSource {
    
    var bills = [Bill]()
    var superView = UIView()
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return bills.count
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let bill = bills[index]
        let billCarouselView = BillCarouselView(bill: bill)
        billCarouselView.frame = carousel.contentView.frame
        setupContentView(contentView: carousel.contentView,
                         billCarouselView: billCarouselView)
        return billCarouselView
    }
    
    private func setupContentView(contentView: UIView, billCarouselView: BillCarouselView) {
        billCarouselView.pinTop(to: contentView,
                                constant: 30,
                                priority: .required,
                                relatedBy: .equal)
        billCarouselView.pinLeft(to: contentView,
                                 constant: 30,
                                 priority: .required,
                                 relatedBy: .equal)
        billCarouselView.pinRight(to: contentView,
                                  constant: 30,
                                  priority: .required,
                                  relatedBy: .equal)
        billCarouselView.pinBottom(to: contentView,
                                   constant: 30,
                                   priority: .required,
                                   relatedBy: .equal)
    }
}
