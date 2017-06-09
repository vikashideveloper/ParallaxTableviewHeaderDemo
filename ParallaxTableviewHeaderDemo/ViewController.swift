//
//  ViewController.swift
//  ParallaxTableviewHeaderDemo
//
//  Created by Vikash Kumar on 09/06/17.
//  Copyright © 2017 Vikash Kumar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

//MARK: Tableview DataSource and Delegate

extension ViewController: UITableViewDataSource, UITableViewDelegate  {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        
        switch indexPath.section {
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: "imageCell")!
        default:
            cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 200
        default:
            return 50
        }
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? ParallaxImageCell {
            cell.tableViewDidScroll(tblView: tableView)
        }
    }
    
    
}

//MARK:- ParallaxImageCell
class ParallaxImageCell: UITableViewCell {
    @IBOutlet var imgTopSpacing: NSLayoutConstraint!
    @IBOutlet var imgBottomSpacing: NSLayoutConstraint!
    @IBOutlet var containerView: UIView!
    
    func tableViewDidScroll(tblView: UITableView) {
        if tblView.contentOffset.y >= 0 {
            containerView.clipsToBounds = true
            imgTopSpacing.constant = tblView.contentOffset.y/2
            imgBottomSpacing.constant = -tblView.contentOffset.y/2
            self.clipsToBounds = true
            
        } else {
            imgTopSpacing.constant = tblView.contentOffset.y
            imgBottomSpacing.constant = 0
            containerView.clipsToBounds = false
            self.clipsToBounds = false
        }
        
        containerView.layoutIfNeeded()
    }
}
