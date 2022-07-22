//
//  ViewController.swift
//  CombineIntro
//
//  Created by Надежда on 2022-07-22.
//

import UIKit
import Combine

class CustomTableViewCell: UITableViewCell {
    
}

class ViewController: UIViewController, UITableViewDataSource {
    
    var observer: AnyCancellable?
    
    private var models = [String]()
    
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
        observer = ApiCaller.shered.fetchData()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("finished")
                case .failure(let error):
                    print(error)
                }
            }, receiveValue: { [weak self] value in
                self?.models = value
                self?.tableView.reloadData()
            })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CustomTableViewCell else { fatalError()
        }
        cell.textLabel?.text = models[indexPath.row]
        return cell
    }

}

