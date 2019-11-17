//
//  UsageViewController.swift
//  NetworkUsageTests
//
//  Created by v.a.jayachandran on 13/11/19.
//  Copyright © 2019 v.a.jayachandran. All rights reserved.
//

import UIKit

class UsageViewController: UIViewController {
    var output: UsageInteractorInputProtocol?

    @IBOutlet var tableView: UITableView!

    private let usageCellID = "usageCellID"
    private var vm: UsageViewVM?

    override func viewDidLoad() {
        super.viewDidLoad()
        if output == nil {
            UsageConfigurator().configure(viewController: self)
        }

        tableView.register(UINib(nibName: "UsageTableViewCell", bundle: nil), forCellReuseIdentifier: usageCellID)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = UIColor.green
        output?.load()
    }

}

extension UsageViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return vm?.tableSections.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm?.tableSections[section].vms.count ?? 0
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return vm?.tableSections[section].title
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: usageCellID, for: indexPath) as? UsageTableViewCell else {
            return UITableViewCell()
        }
        let cellVM = vm?.tableSections[indexPath.section].vms[indexPath.row]
        cell.vm = cellVM
        return cell
    }
}

extension UsageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}

extension UsageViewController: UsagePresenterOutputProtocol {
    func update(vm: UsageViewVM) {
        self.vm = vm
        tableView.reloadData()
    }

    func showAlert(title: String, message: String) {
        AlertSystem.alert(title: title, message: message)
    }
}
