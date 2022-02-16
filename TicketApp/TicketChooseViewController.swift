//
//  ViewController.swift
//  TicketApp
//
//  Created by Mustafa Pekdemir on 11.02.2022.
//

import UIKit
import ALBusSeatView

class TicketChooseViewController: UIViewController {
    
    var ticketList: [TicketModel] = []
    
    @IBOutlet var gradiendView: GradientView!
    @IBOutlet weak var busSeat: ALBusSeatView!
    
    @IBOutlet weak var keeptChairButton: UIButton! {
        didSet {
            self.keeptChairButton.isHidden = true
        }
    }
    
    @IBOutlet weak var dateInput: UITextField! {
        didSet {
            self.dateInput.placeholder = "DD/MM/YYYY HH:mm"
            self.dateInput.keyboardType = .numberPad
        }
    }
    
    @IBOutlet weak var buyButton: UIButton! {
        didSet {
            self.buyButton.tintColor = UIColor(hexString: "#141e30")
            self.buyButton.isHidden = true
        }
    }
    
    @IBOutlet weak var nameTextField: UITextField! {
        didSet {
            self.nameTextField.placeholder = "Name"
        }
    }
    
    @IBOutlet weak var surnameTextField: UITextField! {
        didSet {
            self.surnameTextField.placeholder = "Surname"
        }
    }
    
    @IBOutlet weak var accountIDTextField: UITextField! {
        didSet {
            self.accountIDTextField.placeholder = "123456"
            self.accountIDTextField.keyboardType = .numberPad
        }
    }
    
    var chairList: [ChairModel] = []
    
    var selectedChair: ChairModel = ChairModel(isBuy: false, isKeep: false, chairID: -1)
    var dataManager = SeatDataManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        busSeat.config = ExampleSeatConfig()
        busSeat.delegate = dataManager
        busSeat.dataSource = dataManager
        
        let mock = MockSeatCreater()
        let first = mock.create(count: 45)
        let second = mock.create(count: 45)
        dataManager.seatList = [first]
        busSeat?.reload()

        self.dateInput.delegate = self
    }
    
    
    @IBOutlet weak var datePicker: UIDatePicker! {
        didSet {
            self.datePicker.isHidden = false
        }
    }
    
    @IBAction func datePickerValueChanged(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        self.dateInput.text = dateFormatter.string(from: datePicker.date)
    }
    
    func addChair() {
        for chairId in 1...45 {
            chairList.append(ChairModel(isBuy: false, isKeep: false, chairID: chairId))
        }
    }
    
    @IBAction func keeptChairButtonTapped(_ sender: Any) {
        if(!self.selectedChair.isBuyOrKeep()) {
            let dialogMessage = UIAlertController(title: "Dikkat",
                                                  message: "\(self.chairList[self.selectedChair.chairID - 1].chairID) numaralı koltuğu ayırmak istiyor musunuz ?",
                                                  preferredStyle: .alert)
            let ok = UIAlertAction(title: "Ayır",
                                   style: .default,
                                   handler: {(action) -> Void in
                self.chairList[self.selectedChair.chairID - 1].isKeep = true
            })
            let cancel = UIAlertAction(title: "Kapat",
                                   style: .cancel,
                                   handler: {_ in })
            
            dialogMessage.addAction(ok)
            dialogMessage.addAction(cancel)
            
            self.present(dialogMessage, animated: true, completion: nil)
        } else {
            let dialogMessage = UIAlertController(title: "Dikkat",
                                                  message: "Satın almak istediğiniz koltuk satın alınmış veya ayrılmış !",
                                                  preferredStyle: .alert)
            let ok = UIAlertAction(title: "Tamam",
                                   style: .default,
                                   handler: {_ in })
            dialogMessage.addAction(ok)
            self.present(dialogMessage, animated: true, completion: nil)
        }
    }
    
    @IBAction func buyButtonTapped(_ sender: Any) {
        if(!self.selectedChair.isBuyOrKeep()) {
            let dialogMessage = UIAlertController(title: "Dikkat",
                                                  message: "\(self.chairList[self.selectedChair.chairID - 1].chairID) numaralı koltuğu satın almak istiyor musunuz ?",
                                                  preferredStyle: .alert)
            let buy = UIAlertAction(title: "Satın Al",
                                   style: .default,
                                   handler: { (action) -> Void in
                if(self.dateInput.text == "") {
                    let dialogMessage = UIAlertController(title: "Dikkat",
                                                          message: "Tarih alanı boş bırakılamaz !",
                                                          preferredStyle: .alert)
                    let cancel = UIAlertAction(title: "Kapat",
                                               style: .cancel) {_ in }
                    dialogMessage.addAction(cancel)
                    self.present(dialogMessage, animated: true, completion: nil)
                } else {
                    if let inputDate = self.dateInput.text {
                        let dateFormatter = DateFormatter()
                        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
                        if let date = dateFormatter.date(from: inputDate) {
                            let components = date.get(.day, .month, .year, .hour, .minute)
                            if let day = components.day,
                               let month = components.month,
                               let year = components.year,
                               let hour = components.hour,
                               let minute = components.minute{
                                let dateModel = DateModel(day: day,
                                                          mounth: month,
                                                          year: year)
                                let timeModel = TimeModel(hour: hour,
                                                          minute: minute)
                                print("Alınacak Koltuk: \(self.chairList[self.selectedChair.chairID - 1].chairID)")
                                if(self.nameTextField.text == "" ||
                                   self.surnameTextField.text == "" ||
                                   self.accountIDTextField.text == "") {
                                    let dialogMessage = UIAlertController(title: "Dikkat",
                                                                          message: "Müşteri bilgileri boş bırakamaz !",
                                                                          preferredStyle: .alert)
                                    let cancel = UIAlertAction(title: "Kapat",
                                                               style: .cancel) {_ in }
                                    dialogMessage.addAction(cancel)
                                    self.present(dialogMessage, animated: true, completion: nil)
                                } else {
                                    let name = self.nameTextField.text ?? "Default"
                                    let surname = self.surnameTextField.text ?? "Default"
                                    if let accountID: Int = Int(self.accountIDTextField.text ?? "0") {
                                        let traveller = TravellerModel(name: name,
                                                                       surname: surname,
                                                                       id: accountID)
                                        let ticket: TicketModel = TicketModel(traveller: traveller,
                                                                              date: dateModel,
                                                                              time: timeModel,
                                                                              chair: self.chairList[self.selectedChair.chairID - 1])
                                        print("Bilet: \(ticket.printTicket())")
                                        self.chairList[self.selectedChair.chairID - 1].isBuy = true
                                        let vc = UIStoryboard.init(name: "Main",
                                                                   bundle: Bundle.main)
                                            .instantiateViewController(withIdentifier: "TicketListViewController") as? TicketListViewController
                                        self.ticketList.append(ticket)
                                        vc?.ticketList = self.ticketList
                                        self.navigationController?.pushViewController(vc!, animated: true)
                                    } else {
                                        let dialogMessage = UIAlertController(title: "Dikkat",
                                                                              message: "Müşteri numarası doğru formatta değil !",
                                                                              preferredStyle: .alert)
                                        let cancel = UIAlertAction(title: "Kapat",
                                                                   style: .cancel) {_ in }
                                        dialogMessage.addAction(cancel)
                                        self.present(dialogMessage, animated: true, completion: nil)
                                    }
                                }
                            } else {
                                let dialogMessage = UIAlertController(title: "Dikkat",
                                                                      message: "Tarih doğru formatta değil !",
                                                                      preferredStyle: .alert)
                                let cancel = UIAlertAction(title: "Kapat",
                                                           style: .cancel) {_ in }
                                dialogMessage.addAction(cancel)
                                self.present(dialogMessage, animated: true, completion: nil)
                            }
                        } else {
                            let dialogMessage = UIAlertController(title: "Dikkat",
                                                                  message: "Tarih doğru formatta değil !",
                                                                  preferredStyle: .alert)
                            let cancel = UIAlertAction(title: "Kapat",
                                                       style: .cancel) {_ in }
                            dialogMessage.addAction(cancel)
                            self.present(dialogMessage, animated: true, completion: nil)
                        }
                    } else {
                        let dialogMessage = UIAlertController(title: "Dikkat",
                                                              message: "Tarih alanı alınamadı !",
                                                              preferredStyle: .alert)
                        let cancel = UIAlertAction(title: "Kapat",
                                                   style: .cancel) {_ in }
                        dialogMessage.addAction(cancel)
                        self.present(dialogMessage, animated: true, completion: nil)
                    }
                }
            })
            let cancel = UIAlertAction(title: "Kapat",
                                       style: .cancel) { (action) -> Void in
                print("Kapat tıklandı !")
            }
            dialogMessage.addAction(buy)
            dialogMessage.addAction(cancel)
            self.present(dialogMessage, animated: true, completion: nil)
        } else {
            let dialogMessage = UIAlertController(title: "Dikkat",
                                                  message: "Satın almak istediğiniz koltuk satın alınmış veya ayrılmış !",
                                                  preferredStyle: .alert)
            let ok = UIAlertAction(title: "Tamam",
                                   style: .default,
                                   handler: {_ in })
            dialogMessage.addAction(ok)
            self.present(dialogMessage, animated: true, completion: nil)
        }
    }
    
}



extension TicketChooseViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        self.selectedChair = self.chairList[indexPath.row]
        self.keeptChairButton.isHidden = false
        self.buyButton.isHidden = false
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChairCollectionViewCell",
                                                              for: indexPath) as? ChairCollectionViewCell {
            cell.isSelected = true
        }
        print("Tıklandı: \(self.selectedChair.chairID)")
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChairCollectionViewCell",
                                                                 for: indexPath) as? ChairCollectionViewCell else {
            return UICollectionViewCell()
            
        }
        cell.setCell(chair: self.chairList[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return self.chairList.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}

extension TicketChooseViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1.0, left: 1.0, bottom: 1.0, right: 1.0)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widht = (collectionView.frame.width / 10) - 10
        let height = (collectionView.frame.height / 4) - 10
        return CGSize(width: widht, height: height)
    }
    
}

extension TicketChooseViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {

        if textField.text?.count == 1 {
            textField.placeholder = "DD/MM/YYYY HH:mm"
            
        }
        if (textField.text?.count == 2) || (textField.text?.count == 5) {
            if !(string == "") {
                self.dateInput.text = textField.text! + "/"
            }
            
        } else if (textField.text?.count == 10) {
            if !(string == "") {
                self.dateInput.text = textField.text! + " "
            }
            
        } else if (textField.text?.count == 13) {
            if !(string == "") {
                self.dateInput.text = textField.text! + ":"
            }
        }
        
        return !(textField.text!.count > 15 && (string.count) > range.length)
        
    }
}

