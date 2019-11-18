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
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!

    private let usageCellID = "usageCellID"
    private var vm: UsageViewVM? {
        didSet {
            vm?.tableSections.forEach({ (section) in
                section.vms.forEach { (vm) in
                    if vm.isDecreaseOverPreviousQuarter {
                        print("isDecreaseOverPreviousQuarter")
                    }
                }
            })
            title = vm?.title
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicatorView.isHidden = true
        if output == nil {
            UsageConfigurator().configure(viewController: self)
        }
        tableView.register(UINib(nibName: "UsageTableViewCell", bundle: nil), forCellReuseIdentifier: usageCellID)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: usageCellID, for: indexPath) as? UsageTableViewCell, let vm = vm else {
            return UITableViewCell()
        }

        if indexPath.section == vm.tableSections.count - 1 && indexPath.row == vm.tableSections[indexPath.section].vms.count - 1 {
            output?.reachedEndOfPage()
        }

        let cellVM = vm.tableSections[indexPath.section].vms[indexPath.row]
        cell.vm = cellVM

        return cell
    }
}

extension UsageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}

extension UsageViewController: UsagePresenterOutputProtocol {
    func showLoading() {
        activityIndicatorView.startAnimating()
        activityIndicatorView.isHidden = false
    }

    func hideLoading() {
        activityIndicatorView.stopAnimating()
        activityIndicatorView.isHidden = true
    }

    func update(vm: UsageViewVM) {
        self.vm = vm
    }

    func showAlert(title: String, message: String) {
        AlertSystem.alert(title: title, message: message)
    }
}
