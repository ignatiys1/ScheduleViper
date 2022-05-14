//
//  GroupsTableViewController.swift
//  ScheduleViper
//
//  Created by Ignat Urbanovich on 4.05.22.
//

import UIKit

class GroupsTableViewController: UITableViewController, GroupsViewProtocol, UITextFieldDelegate {
    
    var mainController: MainViewController!

    var configurator: GroupsConfiguratorProtocol = GroupsConfigurator()
    var presenter: GroupsPresenterProtocol!
    override func viewDidLoad() {
        super.viewDidLoad()

        configurator.configure(with: self)
        
        presenter.configureView()
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.getNumberOfGroups() + 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if indexPath.section == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath)
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath)
            cell.textLabel?.text = presenter.getGroupName(with: indexPath.section - 1)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section != 0 {
            presenter.groupIsSelected(index: indexPath.section - 1)
            presenter.closeScene()
        }
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    // MARK: - UITextFieldDelegate methods
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.availableAdding(string: string) {
            textField.addString(string)
            self.presenter.sortGroups(with: textField.text ?? "")
            return true
        }
        return false
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        textField.text = ""
        self.presenter.sortGroups(with: "")
        return true
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter.router.prepare(for: segue, sender: sender)
    }

    // MARK: - GroupsViewProtocol methods
    func reloadData() {
        tableView.reloadData()
    }
}
