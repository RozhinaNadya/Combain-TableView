//
//  ViewController.swift
//  CombineIntro
//
//  Created by Надежда on 2022-07-22.
//

// lesson https://youtu.be/hbY1KTI0g70

import UIKit
import Combine

class CustomTableViewCell: UITableViewCell {
    private let myButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemPink
        button.setTitle("Button", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    let myLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let action = PassthroughSubject<String, Never>()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(myButton)
        myButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didTapButton() {
        contentView.addSubview(myLabel)
        myButton.isHidden = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        myButton.frame = CGRect(x: 10, y: 3, width: contentView.frame.size.width - 20, height: contentView.frame.size.height - 6)
        myLabel.frame = CGRect(x: 10, y: 3, width: contentView.frame.size.width - 20, height: contentView.frame.size.height - 6)
    }
}

class ViewController: UIViewController, UITableViewDataSource {
    
    var observers: [AnyCancellable] = []
    
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
        ApiCaller.shered.fetchData()
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
            }).store(in: &observers)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CustomTableViewCell else { fatalError()
        }
        cell.action.sink { string in
            print(string)
        }.store(in: &observers)
        cell.myLabel.text = models[indexPath.row]
        return cell
    }

}

