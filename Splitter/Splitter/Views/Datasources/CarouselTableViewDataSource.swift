//
//  CarouselTableViewDatasource.swift
//  Splitter
//
//  Created by Wayne Rumble on 18/10/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import UIKit

class CarouselTableViewDataSource: NSObject, UITableViewDataSource {
    
    private var items: [Item] {
        didSet {
            let duplicatedItems = items
            filteredItems = duplicatedItems.filterDuplicates{ ( $0.creationID ) }
        }
    }
    private var filteredItems: [Item]!
    
    required init(items: [Item]) {
        self.items = items
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredItems.count
    }
    
    //Set what each cell in the tableview contains.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: CarouselTableViewCell = tableView.dequeueReusableCell(withIdentifier: "carouselTableViewCell") as! CarouselTableViewCell
        let duplicateItems = items.filter { Int($0.creationID)! == indexPath.row }
        let quantity = "\(duplicateItems.count) x"
        let name = duplicateItems[0].name
        let price = formatPrice(duplicateItems[0].price)
        
        return cell
    }
    
    private func formatPrice(_ stringPrice: String) -> String {
        var formattedPrice = stringPrice
        let price = NSNumber(value: Double(stringPrice)!)
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        if let formattedTipAmount = formatter.string(from: price) {
            formattedPrice = "Tip Amount: \(formattedTipAmount)"
        }
        return formattedPrice
    }
}
