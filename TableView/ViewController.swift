//
//  ViewController.swift
//  TableView
//
//  Created by Арайлым Сермагамбет on 08.03.2024.
//

import UIKit
import SnapKit

struct Section {
    let name: String
    let options: [SettingType]
}

enum SettingType {
    case staticCell(model: Setting)
    case switchCell(model: SettingSwitch)
}

struct SettingSwitch {
    var name: String
    var icon: UIImage?
    var iconBackgroudColor: UIColor
    var iconNumber: UIImage?
    var title: String?
    var handler: (() -> Void)
    var isOn: Bool?
}

struct Setting {
    var name: String
    var icon: UIImage?
    var iconBackgroudColor: UIColor
    var iconNumber: UIImage?
    var title: String?
    var handler: (() -> Void)
    var isOn: Bool?
}

final class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
  
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifiter)
        table.register(SwitchTableViewCell.self, forCellReuseIdentifier: SwitchTableViewCell.identifiter)
        return table
    }()
    
    var models = [Section]()
    
    let searchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        title = "Настройка"
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
    }
    
    func updateSearchResults(for searchController: UISearchController){
        guard let text = searchController.searchBar.text else {
            return
        }
        print(text)
    }
    
    func configure() {
        models.append(Section(name: "General", options: [
            .switchCell(model: SettingSwitch(name: "Авиарежим",icon: .airplane, iconBackgroudColor: .systemOrange, handler: {
                
            }, isOn: true )),
            .staticCell(model: Setting(name: "Wi-fi",icon: UIImage(systemName: "wifi.square.fill"), iconBackgroudColor: .systemBlue, title: "Не подключено"){
            print("wifi")
        }),
            .staticCell(model: Setting(name: "Bluetooth", icon: .bluetooth, iconBackgroudColor: .systemBlue, title: "Вкл." ){
            print("Bluetooth")
        }),
            .staticCell(model: Setting(name: "Cотовая связь",icon: .radioTower, iconBackgroudColor: .systemGreen){
            print("Cотовая связь")
        }),
            .staticCell(model: Setting(name: "Режим модема",icon: .personalHotspot, iconBackgroudColor: .systemGreen){
            print("Режим модема")
        }),
            .switchCell(model: SettingSwitch(name: "VPN",icon: .vpn, iconBackgroudColor: .systemBlue, handler: {
                
            }, isOn: true ))
                                                         
]))
        models.append(Section(name: "General", options: [
            .staticCell(model: Setting(name: "Уведомления",icon: .notifications1, iconBackgroudColor: .systemRed){
            print("Уведомления")
        }),
                                                         
        .staticCell(model: Setting(name: "Звуки, тактильные сигналы",icon: .sounds, iconBackgroudColor: .systemPink){
            print("Звуки, тактильные сигналы")

        }),
        .staticCell(model: Setting(name: "Не беспокоить",icon: .focus, iconBackgroudColor: .systemPurple){
            print("Не беспокоиты")

        }),
        .staticCell(model: Setting(name: "Экранное время",icon: .screenTime, iconBackgroudColor: .systemPurple){
         print("Экранное время")

        })
                                                         
]))
        models.append(Section(name: "General", options: [
            .staticCell(model: Setting(name: "Основные",icon: .general, iconBackgroudColor: .systemGray, iconNumber: UIImage(systemName: "1.circle.fill")){
            print("Основныя")
        }),
            .staticCell(model: Setting(name: "Пунк управления",icon: .controlCemter, iconBackgroudColor: .systemGray){
            print("Пунк управления")
        }),
            .staticCell(model: Setting(name: "Экран и яркость",icon: .display, iconBackgroudColor: .systemBlue){
            print("Экран и яркость")
        }),
            .staticCell(model: Setting(name: "Экран Домой и библиотека приложений",icon: .home, iconBackgroudColor: .systemIndigo){
             print("Экран Домой и библиотека приложений")
        }),
            .staticCell(model: Setting(name: "Универсальный доступ",icon: .accessibility, iconBackgroudColor: .systemBlue){
        print("Универсальный доступ")
        }),
            .staticCell(model: Setting(name: "Обои",icon: .wallpaper, iconBackgroudColor: .systemCyan){
            print("Обои")
        }),
            .staticCell(model: Setting(name: "Ожидание",icon: .stanby, iconBackgroudColor: .black){
            print("Ожидание")
        }),
            .staticCell(model: Setting(name: "Siri и Поиск",icon: .siri, iconBackgroudColor: .black){
            print("Siri и Поиск")
        }),
            .staticCell(model: Setting(name: "Face ID и код-пароль",icon: .faceid, iconBackgroudColor: .green){
            print("Face ID и код-пароль")
        })
                                                         
]))
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].options.count
        
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section].options[indexPath.row]
        switch model.self {
        case .staticCell(let model):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifiter,
                                                           for: indexPath) as? CustomTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: model)
            return cell
        case .switchCell(let model):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SwitchTableViewCell.identifiter,
            for: indexPath) as? SwitchTableViewCell else {
                                        return UITableViewCell()
                                    }
            cell.configure(with: model)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let type = models[indexPath.section].options[indexPath.row]
        switch type.self {
        case .staticCell(let model):
            model.handler()
        case .switchCell(let model):
            model.handler()
        }
    }
}
