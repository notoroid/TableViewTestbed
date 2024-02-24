//
//  ViewController.swift
//  TableViewTestbed
//
//  Created by 能登 要 on 2024/02/18.
//


import UIKit

enum Section: CaseIterable {
        case body
    }

struct Item: Hashable, Sendable {
    let label: String
}

class ViewController: UIViewController {
    @IBOutlet private var tableView: UITableView!
    
    // Reference: https://qiita.com/mishimay/items/e5cd61b55a1011c93190
    private lazy var dataSource: UITableViewDiffableDataSource<Section, Item> = {
        let dataSource: UITableViewDiffableDataSource<Section, Item> = .init(tableView: tableView, cellProvider: { tableView, indexPath, item in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: Cell.className) as? Cell
            cell?.textLabel?.text = item.label
            return cell
        })
        _ = dataSource.defaultRowAnimation // dataSource.defaultRowAnimation = .automatic
        return dataSource
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        let headerResourceName = HeaderView.className
        let nib: UINib = .init(nibName: headerResourceName, bundle: nil)
        tableView.register( nib, forHeaderFooterViewReuseIdentifier: headerResourceName)
        
        
        let cellResourcename = Cell.className
        tableView.register( .init(nibName: cellResourcename, bundle: nil), forCellReuseIdentifier: cellResourcename)
        tableView.dataSource = dataSource
        tableView.estimatedSectionHeaderHeight = UITableView.automaticDimension
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems([Item(label: "テスト1"), Item(label: "テスト2") , Item(label: "テスト3") ,Item(label: "テスト4")], toSection: .body)
        dataSource.apply(snapshot)
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderView.className) as? HeaderView
        headerView?.headerLabel.text = "これは改行あり\nのヘッダーです。"
        return headerView
    }
}
