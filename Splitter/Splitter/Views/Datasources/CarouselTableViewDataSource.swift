//
//  CarouselTableViewDatasource.swift
//  Splitter
//
//  Created by Wayne Rumble on 18/10/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import UIKit

class CarouselTableViewDataSource: NSObject, UITableViewDataSource {
    
    private let items = [Item]()
    
    required init(items: [Item]) {
        self.items = items
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    }
    
    //Set what each cell in the tableview contains.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        let cell: CarouselTableViewCell = tableView.dequeueReusableCell(withIdentifier: "carouselTableViewCell") as! CarouselTableViewCell
        
        
        return cell
    }
}
