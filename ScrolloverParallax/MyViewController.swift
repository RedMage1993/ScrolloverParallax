//
//  MyViewController.swift
//  ScrolloverParallax
//
//  Created by Fritz Ammon on 7/1/19.
//  Copyright © 2019 Ammon. All rights reserved.
//

import UIKit

class MyViewController: UIViewController {
    let tableView = UITableView()
    let theCell = UITableViewCell()
    let myContentView = UIView()
    var stupidYConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
}

extension MyViewController {
    func setup() {
        theCell.contentView.addSubview(myContentView)
        myContentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: myContentView, attribute:.width, relatedBy: .equal, toItem: theCell.contentView, attribute: .width, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: myContentView, attribute:.height, relatedBy: .equal, toItem: theCell.contentView, attribute: .height, multiplier: 1, constant: 0).isActive = true
        
        stupidYConstraint = NSLayoutConstraint(item: myContentView, attribute:.top, relatedBy: .equal, toItem: theCell.contentView, attribute: .top, multiplier: 1, constant: 0)
        stupidYConstraint?.isActive = true
        
        theCell.clipsToBounds = true
        
        let imgView = UIImageView(image: UIImage(named: "lalafellsss"))
        imgView.contentMode = .scaleToFill
        myContentView.addSubview(imgView)
        imgView.translatesAutoresizingMaskIntoConstraints = false
        addConstraints(for: imgView, to: myContentView, attributes: [.top, .right, .bottom, .left])
        
        tableView.rowHeight = 300
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        addConstraints(for: tableView, to: view, attributes: [.top, .right, .bottom, .left])
    }
    
    func addConstraints(for item: UIView, to toItem: UIView, attributes: [NSLayoutConstraint.Attribute]) {
        attributes.forEach {
            NSLayoutConstraint(item: item, attribute: $0, relatedBy: .equal, toItem: toItem, attribute: $0, multiplier: 1, constant: 0).isActive = true
        }
    }
}

extension MyViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetShowsAtBottom = theCell.frame.minY - scrollView.frame.height
        let offsetDoneShowingAtBottom = offsetShowsAtBottom + tableView.rowHeight
        
        let offsetHidesAtTop = theCell.frame.minY
        let offsetDoneHidingAtTop = offsetHidesAtTop + tableView.rowHeight
        
        let scrollPosition = scrollView.contentOffset.y
        
        var minY: CGFloat = 0
        if scrollPosition >= offsetShowsAtBottom && scrollPosition <= offsetDoneShowingAtBottom {
            minY = -tableView.rowHeight + abs(scrollPosition - offsetShowsAtBottom) + 1
        } else if scrollPosition >= offsetHidesAtTop && scrollPosition <= offsetDoneHidingAtTop {
            minY = abs(scrollPosition - offsetHidesAtTop)
        }
        
        stupidYConstraint?.constant = minY
    }
}

extension MyViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 4:
            return theCell
        default: break
        }
        
        return UITableViewCell()
    }
}

