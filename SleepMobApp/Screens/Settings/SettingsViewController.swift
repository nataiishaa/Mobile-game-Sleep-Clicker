//
//  SettingsViewController.swift
//  SleepMobApp
//
//  Created by Наталья Захарова on 13.03.2024.
//


import UIKit


final class SettingsViewController: UIViewController {
    private let titleLabel = UILabel()
    private let  clouds = CloudStackView()
    private let ringSounds = UIImageView(image:UIImage(named: "soundActive"))
    private let ringNotification = UIImageView(image:UIImage(named: "soundActive"))
    private var soundOn = true
    private var notificationOn = true
    let koalaImageView = UIImageView(image: UIImage(named: "koalaTilt"))
   

 

    
    func configureUI(){
        view.addSubview(titleLabel)
        view.addSubview(clouds)
        view.addSubview(ringSounds)
        view.addSubview(ringNotification)
        configureTitleLable()
        configureBackButton()
        clouds.setWidth(390)
        clouds.setHeight(546)
        clouds.pinTop(to: titleLabel.bottomAnchor, 50)
        clouds.pinCenterX(to: view)
        clouds.soundCloud.addTarget(self, action: #selector(changeSound), for: .touchUpInside)
        clouds.notificationCloud.addTarget(self, action: #selector(changeNotifications), for: .touchUpInside)
        clouds.infoClous.addTarget(self, action: #selector(goToInfo), for: .touchUpInside)
        ringSounds.pinTop(to: clouds.topAnchor,20)
        ringSounds.pinCenterX(to: view,10)
        
        
        ringNotification.pinCenterX(to: view,10)
        ringNotification.pinCenterY(to: view.centerYAnchor,-13)
        
        koalaImageView.translatesAutoresizingMaskIntoConstraints = false // Убедитесь, что AutoresizingMask отключен
        view.addSubview(koalaImageView)
        // Установите констрейнты относительно правого верхнего угла вашего `yourView`
        koalaImageView.pinTop(to: view.safeAreaLayoutGuide.topAnchor, 10) // отступ сверху
        koalaImageView.pinLeft(to: view.leadingAnchor) // отступ справа

        // Установите конкретную высоту и ширину, если это необходимо
        koalaImageView.setHeight(100) // высота
        koalaImageView.setWidth(100) // ширина
        
    }
    
    @objc
    private func changeSound() {
        
        MusicPlayer.shared.toggleMusic()
        ringSounds.image = MusicPlayer.shared.isMusicPlaying() ? UIImage(named: "soundActive") : UIImage(named: "soundInactive")
    }
    
    
    @objc private func changeNotifications() {
        notificationOn.toggle()
        
        if notificationOn {
            scheduleNotification()
        } else {
            cancelAllNotifications()
        }
        
        // Обновление изображения
        ringNotification.image = notificationOn ? UIImage(named: "soundActive") : UIImage(named: "soundInactive")
    }
    
    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Напоминание"
        content.body = "Не забудьте проверить своих персонажей сегодня!"
        content.sound = UNNotificationSound.default
        
        // Например, через 10 секунд после нажатия
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        
        let request = UNNotificationRequest(identifier: "notification.id.01", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Ошибка при добавлении уведомления: \(error.localizedDescription)")
            }
        }
    }
    
    func cancelAllNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
    
    @objc private func goToInfo() {
        
    }
    
    
    override func viewDidLoad() {
        configureUI()
        self.view.backgroundColor = UIColor(hex: "0D4496") // Цвет фона
        
    }
    
    private func configureTitleLable() {
        // Настройка titleLabel
        let colorOne = #colorLiteral(red: 0.8433896899, green: 0.7258818746, blue: 0.7231372595, alpha: 1)
        let colorTwo = #colorLiteral(red: 1, green: 0.9568627451, blue: 0.9568627451, alpha: 1)
        
        titleLabel.attributedText = NSAttributedString(string: "Settings", attributes: [.strokeColor: colorTwo,
                                                                                       .foregroundColor: colorOne,
                                                                                       .strokeWidth: -3,
                                                                                       .font: UIFont.comicoro(size: 80)])
      
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.pinCenterX(to: view)
        titleLabel.pinTop(to: view.safeAreaLayoutGuide.topAnchor, 20)
        
        clouds.infoClous.addTarget(self, action: #selector(goToAboutDev), for: .touchUpInside)
    }
    
    private func configureBackButton() {
        let backButton = UIButton()
        backButton.setImage(UIImage(named: "back"), for: .normal)
        //backButton.setTitle("Back", for: .normal)
        backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        
        // Добавляем кнопку на view и отключаем autoresizing mask
        backButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backButton)
        
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25), // Отступ сверху от safe area
            backButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0), // Отступ справа от safe area
            backButton.widthAnchor.constraint(equalToConstant: 89), // Ширина кнопки
            backButton.heightAnchor.constraint(equalToConstant: 38) // Высота кнопки
        ])
    }
    
    @objc
    func backAction() {
        
        if let navController = navigationController, navController.viewControllers.first != self {
            navController.popViewController(animated: true)
        } else {
            
            dismiss(animated: true, completion: nil)
        }
    }
    
    
    @objc
    private func goToAboutDev() {
        if let navigationController = self.navigationController {
            
            let aboutDevVC = AboutDevViewController()
            
            navigationController.pushViewController(aboutDevVC, animated: true)
        } else {
            
            let aboutDevVC = AboutDevViewController()
            
            aboutDevVC.modalPresentationStyle = .fullScreen
            self.present(aboutDevVC, animated: true, completion: nil)
        }
        
    }
}
