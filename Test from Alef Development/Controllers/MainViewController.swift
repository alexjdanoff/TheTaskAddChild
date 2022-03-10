//
//  ViewController.swift
//  Test from Alef Development
//
//  Created by Alexandru Jdanov on 27.02.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    private let clearButton = UIButton(title: "Очистить", titleColor: #colorLiteral(red: 0.858640492, green: 0.3206482828, blue: 0.3036393523, alpha: 1))
    private let userLabel = UILabel(text: "Персональные данные")
    private let userNameTextField = InsertableTextField(placeholder: "Имя")
    private let userAgeTextField = InsertableTextField(placeholder: "Возраст")
    private let childLabel = UILabel(text: "Дети (макс.5)")
    private let addButton = UIButton(title: "  Добавить ребенка", titleColor: #colorLiteral(red: 0.004408729728, green: 0.6530340314, blue: 0.9960127473, alpha: 1))
    private let tableView = UITableView()
    
    private var childs = [Child]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        setupConstraints()
        addButton.setImage(UIImage(systemName: "plus"), for: .normal)
        addButton.tintColor = #colorLiteral(red: 0.004408729728, green: 0.6530340314, blue: 0.9960127473, alpha: 1)
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.register(ChildCell.self, forCellReuseIdentifier: "ChildCell")
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(onTap(_:)))
        recognizer.cancelsTouchesInView = false
        self.view.addGestureRecognizer(recognizer)
        
        addButton.addTarget(self, action: #selector(addChildAction), for: .touchUpInside)
        clearButton.addTarget(self, action: #selector(clearButtonAction), for: .touchUpInside)
    }
    
    @objc private func addChildAction(_ sender: UIButton) {
        self.view.endEditing(true)
        
        let child = Child(name: nil, age: nil)
        self.childs.append(child)
        
        self.tableView.reloadData()
        
        if childs.count == 5 {
            self.addButton.isHidden = true
            return
        }
    }
    
    @objc private func clearButtonAction(_ sender: UIButton) {
        let clearMenu = UIAlertController(title: nil, message: "Очистить", preferredStyle: .actionSheet)
        let resetAction = UIAlertAction(title: "Сбросить данные", style: .default) { (action) in
            self.childs = []
            self.tableView.reloadData()
            ChildCell().childNameTextField.text = ""
            ChildCell().childAgeTextField.text = ""
            self.addButton.isHidden = false
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        
        clearMenu.addAction(resetAction)
        clearMenu.addAction(cancelAction)
        
        self.present(clearMenu, animated: true, completion: nil)
    }
    
    @objc private func onTap(_ recognizer: UIGestureRecognizer) {
        self.view.endEditing(true)
    }
    
}

// MARK: - Data Source
extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return childs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let childCell = tableView.dequeueReusableCell(withIdentifier: "ChildCell", for: indexPath) as? ChildCell else { return UITableViewCell() }
        
        let child = childs[indexPath.row]
        
        childCell.delegate = self
        childCell.indexPath = indexPath
        
        childCell.setupWith(child: child)
        
        return childCell
    }
}

// MARK: - Get data from cells
extension MainViewController: ChildCellDelegate {
    
    func shouldDelete(at indexPath: IndexPath) {
        self.childs.remove(at: indexPath.row)
        
        self.tableView.reloadData()
        
        if self.childs.count < 5 {
            self.addButton.isHidden = false
        }
    }
    
    func addNotification(at indexPath: IndexPath, child: Child) {
        self.childs[indexPath.row] = child
        self.tableView.reloadData()
    }
}

// MARK: - Setup constraints
extension MainViewController {
    
    private func setupConstraints() {
        let childStackView = UIStackView(arrangedSubviews: [childLabel, addButton],
                                         axis: .horizontal,
                                         spacing: 10)
        
        let stackView = UIStackView(arrangedSubviews: [userLabel, userNameTextField, userAgeTextField, childStackView],
                                    axis: .vertical,
                                    spacing: 10)
        
        view.backgroundColor = .white
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        clearButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        view.addSubview(tableView)
        view.addSubview(clearButton)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -130)
        ])
        
        NSLayoutConstraint.activate([
            clearButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            clearButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70)
        ])
        
    }
}
