//
//  ViewController.swift
//  Randomizer
//
//  Created by Сергей Крутов on 05.10.2022.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet var minimumValueLabel: UILabel! //Лейбл минимального значения
    @IBOutlet var maximumValueLabel: UILabel! //Лейбл максимального значения
    @IBOutlet var randomValueLabel: UILabel! //Лейбл вывода результата случайного значения
    @IBOutlet var getRandomNumberButton: UIButton! //Кнопку добавляем для того, чтобы скруглить у нее углы в коде
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getRandomNumberButton.layer.cornerRadius = 10 //Скругление углов у кнопки
       
    }
    //Этот метод означает подготовку к переходу на второе окно по конкретному сигвею. Для передачи данных из тектовых полей берем значения из соответствующих аутлетов и передаем их. Для этого создаем экземпляр того класса View Controller, на который хотим перейти. Но тут нам нужен тот экземпляр класса, который создает сигвей (let settingsVC = segue.destination). Т.е. мы создаем экземпляр класса settingsVC (let settingsVC), затем обращаемся к сигвею со свойством destination. Свойство destination вернет нам экземпляр того View Controller, на который мы переходим. При этом destination всегда возвращает тип даннах UIViewController, но в этом классе нет аутлетов mimimalValue и maximumValue, поэтому мы приводим к типу SettingsViewController (as? SettingsViewController). Однако при этом у нас settingsVC станет опциональным. Поэтому извлекаем опционал при помощи guard (guard let settingsVC). фрагмент кода else { return } позволит нам выйти из кода, если не удастся создать экземпляр класса. Таким образом мы берем экземпляр класса, который создает сигвей и в этот экземпляр мы передаем данные
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else { return }
        settingsVC.minimumValue = minimumValueLabel.text
        settingsVC.maximumValue = maximumValueLabel.text
    }
    
//Создаем экшн кнопки генерации случайного числа
    @IBAction func getRandomNumberButtonTapped() {
        let minimumNumber = Int(minimumValueLabel.text ?? "") ?? 0 //Мы берем значение из лейбла "minimumValueLabel" из извлекаем из него число. Свойство "text" у нас опциональное, а "minimumNumber" у нас не опциональное свойство, поэтомц мы указываем (?? ""), что означает, если у нас будет nil, то мы просто передадим пустую строку. Если будет пустая строка, то мы не сможем сгенерировать из нее число, то строка (minimumValueLabel.text ?? "") вернет нам nil, но поскольку у нас свойство minimumNumber не опциональное, мы не можем принимать nil. Для этого мы указываем (?? 0), что означает верни нам 0, вмесо nil
        let maximumNumber = Int(maximumValueLabel.text ?? "") ?? 100
        randomValueLabel.text = Int.random(in: minimumNumber ... maximumNumber).formatted() //Берем значения minimumNumber и maximumNumber и помещаем их в диапазон для получения рандомного числа при помощи вызова функции random с типом Int (Int.random) и полученное число форматируем при помощи formatted() в текст и затем передаем это значение в лейбл randomValueLabel с параметром text (randomValueLabel.text)
    }
    
    //Далее создадим кнопку и по ней сделаем переход на другой экран, внутри которого можно будет менять значения для лейблов. 
    
    @IBAction func unwind(for segue: UIStoryboardSegue) {
        guard let settingsVC = segue.source as? SettingsViewController else { return }
        minimumValueLabel.text = settingsVC.minimumValueTF.text
        maximumValueLabel.text = settingsVC.maximumValueTF.text
    }
}

