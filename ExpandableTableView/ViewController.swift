//
//  ViewController.swift
//  ExpandableTableView
//
//  Created by hexlant_01 on 2020/02/04.
//  Copyright © 2020 hexlant_01. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var myTableView: UITableView!
    private let cellIdentifier = "cellId"
    private var users: [Users] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        assignData()
        createTableView()

    }
}

extension ViewController {
    fileprivate func assignData() {
        
        users = [
            Users(isHidden: false, user: [User(name: "Caldera"), User(name: "Ronaldo"), User(name: "Casey")]),
            Users(isHidden: false, user: [User(name: "Sam"), User(name: "Neistat"), User(name: "Chui")]),
            Users(isHidden: false, user: [User(name: "Bald"), User(name: "Kulasekara"), User(name: "Mahinda")]),
            Users(isHidden: false, user: [User(name: "Lasith"), User(name: "Malinga"), User(name: "Nuwan")])
        ]
        
    }
}

extension ViewController {
    fileprivate func createTableView() {
        myTableView = UITableView(frame: .zero, style: .grouped)
        myTableView.translatesAutoresizingMaskIntoConstraints = false
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
        myTableView.dataSource = self
        myTableView.delegate = self
        
        view.addSubview(myTableView)
        
        let mytableViewConstraints = [
            myTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            myTableView.topAnchor.constraint(equalTo: view.topAnchor),
            myTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            myTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate((mytableViewConstraints))
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let isHidden = users[section].isHidden
        if isHidden {
            return 0
        }
        return users[section].user.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        cell?.textLabel?.text = users[indexPath.section].user[indexPath.row].name
        return cell!
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40))
        view.backgroundColor = .lightGray
        
        let button = UIButton(frame: CGRect(x: 10, y: 5, width: 100, height: 30))
        button.setTitle("Section: \(section)", for: .normal)
        
        // Expandable 관련
        button.tag = section
        button.addTarget(self, action: #selector(collapse(_:)), for: .touchUpInside)
        
        view.addSubview(button)
        return view
    }
    
}

// Expandable 관련
extension ViewController {
    @objc fileprivate func collapse(_ sender: UIButton) {
        print("working fine: \(sender.tag)")
        
        var selectedUser = users[sender.tag]
        selectedUser.isHidden = !selectedUser.isHidden
        users[sender.tag] = selectedUser
        myTableView.reloadData()
        
    }
}
