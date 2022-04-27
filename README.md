# AppricotTest

Тестовый проект по заданию компании Appricot.


## Общая информация
Приложение отображает на главном экране список персонажей сериала Рик и Морти. При выборе персонажа открывает 
окно с детальной информацией о выбранном персонаже.


## Технологии

:one: Проект реализован на Swift 5. Использовались только стандартные возможности, без подключения зависимостей.

:two: UIKit. Верстка Storyboard в Interface Builder. Верстка кодом не делалась. 

:three: Для загрузки данных в приложение использовалась URLSession и стандартные REST API https://rickandmortyapi.com/documentation/#rest

:four: Интерфейс реализован под утройство iPhone8Plus, просто потому что я такое использую для разработки.

:five: Парсинг json - JSONDecoder. Модель для парсинга в JsonModel.swift.

:six: Загрузка изображений стандартными средствами. 


## Что планировалось реализовать, но не сделано 
:x: Не добавлен ActivityIndicatorView. Поэтому, в случае лагов при загрузке, будет заметно. Будет добавлено потом

:x: Загрузка изображений реализована в двух контроллерах одинаково. Это не опитимально, надо бы переделать.

:x: Не сделаны иконки приложений.

:x: Не достаточно внимания уделено констрейнтам. С этим тоже еще предстоит позаниматься.

