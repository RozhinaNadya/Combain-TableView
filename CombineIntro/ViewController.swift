//
//  ViewController.swift
//  CombineIntro
//
//  Created by Надежда on 2022-07-22.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
}

class ViewController: UIViewController, UITableViewDataSource {
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(CustomTableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.frame = view.bounds
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CustomTableViewCell else { fatalError()
        }
        return cell
    }

}

