//
//  ViewController.swift
//  ListApp
//
//  Created by Kader Kaya on 17.12.2024.
//

import UIKit

class ViewController: UIViewController{
    
    var data = [String]()
    var alertController = UIAlertController()
    @IBOutlet weak var tableView:UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    @IBAction func didRemoveBarButtonItemTapped( _ sender: UIBarButtonItem){
        presentAlert(title: "Uyarı",
                     message: "listedeki bütün öğeleri silmek istediğinize emin misiniz ?",
                     defaultButtonTitle:"Evet" ,
                     cancelButtonTitle: "vazgeç",
                     defaultButtonHandler: {_ in
             self.data.removeAll()
            self.tableView.reloadData()
        }
        )
        
    }
    @IBAction func didAddBarButtonItemTapped(_ sender:UIBarButtonItem) {
        presentAddAlert()
        
    }
    func presentAddAlert(){
        presentAlert(title: "yeni eleman ekle",
                     message: nil,
                     defaultButtonTitle: "Ekle",
                     cancelButtonTitle: "Vazgeç",
                     isTextFieldAvailable: true,
                     defaultButtonHandler: { _ in
            let text = self.alertController.textFields?.first?.text
            if text != "" {
                self.data.append((text)!)
                self.tableView.reloadData()
            }
            else{
                self.presentWarningAlert()
            }
        })
        
    }
    func presentWarningAlert(){
        presentAlert(title: "Uyarı",
                     message: "Liste Elemanı Boş Olamaz",
                     cancelButtonTitle: "Kapat")
    }
    func presentAlert(title:String?,
                      message:String?,
                      preferredStyle:UIAlertController.Style = .alert,
                      defaultButtonTitle:String? = nil,
                      cancelButtonTitle:String?,
                      isTextFieldAvailable: Bool = false,
                      defaultButtonHandler:((UIAlertAction) -> Void)? = nil
                      
                      
    ){
        alertController = UIAlertController(title: title,
                                            message: message,
                                            preferredStyle:preferredStyle)
        if defaultButtonTitle != nil {
            let defaultButton = UIAlertAction(title: defaultButtonTitle,
                                              style: .default,
                                              handler: defaultButtonHandler)
            alertController.addAction(defaultButton)
        }
        
        let cancelButton = UIAlertAction(title: cancelButtonTitle,
                                         style: .cancel)
        if isTextFieldAvailable {
            alertController.addTextField()
        }
     
        alertController.addAction(cancelButton)
        
        present(alertController, animated: true)
    }
}

extension ViewController :UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "defaultCell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .normal, title: "Sil") { _, _, _ in
            self.data.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
        let fixAction = UIContextualAction(style: .normal, title: "Düzenle"){ _, _, _ in
            self.presentAlert(title: "Düzenle",
                              message: nil,
                              defaultButtonTitle: "Düzenle",
                              cancelButtonTitle: "Vazgeç",
                              isTextFieldAvailable: true,
                              defaultButtonHandler: { _ in
                let text = self.alertController.textFields?.first?.text
                if text != "" {
                    self.data[indexPath.row] = text!
                    self.tableView.reloadData()
                }
                else{
                    self.presentWarningAlert()
                }
            })
        }
        deleteAction.backgroundColor = .systemRed
        
        
        
        let config =  UISwipeActionsConfiguration(actions: [deleteAction,fixAction])
        return config
    }
}
