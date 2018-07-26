# SwiftFriendsListVK

iOS Swift Test Project with [VKiOSsdk](https://github.com/VKCOM/vk-ios-sdk)

## Swift iOS test-application "Tinkoff News"

## Task (ENG)

Test application Tinkoff News downloads news headlines from https://api.tinkoff.ru/v1/news API and display them in a tableView. The pull-to-refresh gesture updates the news list. 

By tap on the cell of the list, you can see full information on the selected news.

· One page = 20 news. Example: https://api.tinkoff.ru/v1/news?first=0&last=20

· On each cell there should be a counter (number), reflecting the number of transitions to details of this particular news.

· When you click on each news item, it should open a new screen and display the content (payload.content) downloaded from the API https://api.tinkoff.ru/v1/news_content?id= {payload [i] .id}.

· A clean interface with handling of all possible exceptions (for example, the absence of an Internet connection).

· The application is written in Swift. Without using third-party libraries / pods.

· News data and the view count should be cached using CoreData (special attention is given to implementing the CoreData stack and working with writing / reading data).

· Cached data is displayed before sending the update request.

· Cached data is also available after the application is restarted.

## Task (RUS)

Создать приложение "Тинькофф Новости", которое будет загружать из API https://api.tinkoff.ru/v1/news заголовки новостей банка и показывать их в виде списка. Жест pull-to-refresh приводит к обновлению списка новостей.

По тапу на ячейку списка осуществляется переход просмотру полной информации по выбранной новости.
 
· Загрузка должна быть постраничной (по 20 новостей). Пример: https://api.tinkoff.ru/v1/news?first=20&last=40

· На каждой ячейке должен быть счетчик (число), отражающий количество переходов к просмотру деталей этой конкретной новости.

· При нажатии на каждую новость, она должна открывать новый экран и показывать содержимое (payload.content) загруженное из API https://api.tinkoff.ru/v1/news_content?id={ payload[i].id}. 

· Чистый аккуратный интерфейс с обработкой всех возможных исключений (например, отсутствие интернет-соединения).

· Приложение написано на Swift. Без использования сторонних библиотек/подов.

· Данные о новостях и счетчик просмотров необходимо кэшировать, используя CoreData.

· Закэшированные данные отображаются перед отправлением запроса на обновление данных.

· Закэшированные данные доступны и после перезапуска приложения.

## Screenshots (iPhone 5S)

NewsListController            |  NewsDetailController
:-------------------------:|:-------------------------:
<img src="https://user-images.githubusercontent.com/19716289/43050016-23936e92-8e1b-11e8-8705-4d2ffde6ed17.png" width="50%"> | <img src="https://user-images.githubusercontent.com/19716289/43050018-26bb9e82-8e1b-11e8-865b-d2092849515f.png" width="50%">

* **Alex Kuzyaev** - [AlexKuzyaev](https://github.com/AlexKuzyaev)
