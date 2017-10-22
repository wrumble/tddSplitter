//
//  CarouselTableViewDatasource.swift
//  Splitter
//
//  Created by Wayne Rumble on 18/10/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import UIKit

class CarouselTableViewDataSource: NSObject, UITableViewDataSource {
    
    var items: [Item]? {
        didSet {
            let duplicatedItems = items?.filterDuplicates { ( $0.creationID ) }
            filteredItems = duplicatedItems?.sorted(by: { Int($0.creationID)! < Int($1.creationID)! })
        }
    }
    
    private var filteredItems: [Item]!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredItems.count
    }
    
    //Set what each cell in the tableview contains.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CarouselTableViewCell = tableView.dequeueReusableCell(withIdentifier: "carouselTableViewCell") as! CarouselTableViewCell
        let sortedItems = items?.sorted(by: { Int($0.creationID)! < Int($1.creationID)! })
        let duplicateItems = sortedItems?.filter { Int($0.creationID)! == indexPath.row }
        let quantity = "\(duplicateItems!.count) x "
        let name = duplicateItems![0].name
        let doublePrice = Double(duplicateItems![0].price)!
        let doubleQuantity = Double(duplicateItems!.count)
        let price = String(doublePrice * doubleQuantity)
        
        cell.quantityLabel.text = quantity
        cell.nameLabel.text = name
        cell.priceLabel.text = price.formatPrice()
        
        return cell
    }
}
