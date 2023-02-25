//
//  ViewController.swift
//  FetchRequests
//

import UIKit
import CoreData

final class ViewController: UIViewController {
    private func simpleFetch(with context: NSManagedObjectContext) {
        // Создаём запрос.
        // Укажем, что хотим получить записи Author и ответ привести к типу Author.
        let request = NSFetchRequest<Author>(entityName: "Author")
        // Выполняем запрос, используя контекст.
        // В результате получаем массив объектов Author.
        let authors = try! context.fetch(request)
        // Распечатаем в консоль имена и год автора.
        authors.forEach { print("\($0.name) \($0.age)") }
    }
    // Получим CoreData контейнер с базой данных.
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        return container
    }()

    private func idsFetch(with context: NSManagedObjectContext) {
        let request = NSFetchRequest<Author>(entityName: "Author")
        request.resultType = .managedObjectIDResultType

        let authors = try! context.execute(request) as! NSAsynchronousFetchResult<NSFetchRequestResult>
        print(authors.finalResult)

        // Возьмём идентификатор второго автора.
        // Предложенное приведение типа обосновано, так как в запросе к БД был запрошен именно этот тип `managedObjectIDResultType`.
        let id = authors.finalResult![1] as! NSManagedObjectID
        // Зная уникальный идентификатор объекта, получим его из контекста.
        let author = context.object(with: id) as! Author
        // Прочитаем значения имени и года.
        print("\(author.name) \(author.age)")
    }

    private func dictionaryFetch(with context: NSManagedObjectContext) {
        let request = NSFetchRequest<Book>(entityName: "Book")
        // Интересно получить только название книги
        request.propertiesToFetch = ["title"]
        // Ограничение на выдачу всего 3 записей
        request.fetchLimit = 3
        request.resultType = .dictionaryResultType
        let book = try! context.execute(request) as! NSAsynchronousFetchResult<NSFetchRequestResult>
        print(book.finalResult)
    }

    private func countFetch(with context: NSManagedObjectContext) {
        let request = NSFetchRequest<Author>(entityName: "Author")
        // Нам интересно лишь количество
        request.resultType = .countResultType

        let authors = try! context.execute(request) as! NSAsynchronousFetchResult<NSFetchRequestResult>

        print(authors.finalResult)
    }


    private func limitFetch(with context: NSManagedObjectContext) {

        let request = NSFetchRequest<Book>(entityName: "Book")
        request.returnsObjectsAsFaults = false
        request.fetchLimit = 2
        request.fetchOffset = 1

        let books = try! context.fetch(request)
        print(books)

    }

    private func sortFetch(with context: NSManagedObjectContext) {

        let request = NSFetchRequest<Book>(entityName: "Book")
        request.returnsObjectsAsFaults = false
        request.fetchLimit = 3
        // Выполним сортировку по году и по возрастанию
        request.sortDescriptors = [NSSortDescriptor(key: "year", ascending: true)]

        let books = try! context.fetch(request)
        print(books)

    }

    private func groupFetch(with context: NSManagedObjectContext) {

        let request = NSFetchRequest<Author>(entityName: "Author")
        request.resultType = .dictionaryResultType
        request.fetchLimit = 5
        request.propertiesToFetch = ["country", "name"]
        request.propertiesToGroupBy = [ "country", "name" ]

        let author = try! context.execute(request) as! NSAsynchronousFetchResult<NSFetchRequestResult>
        print(author.finalResult)
    }

    private func grouppedFetch(with context: NSManagedObjectContext) {

        let request = NSFetchRequest<Author>(entityName: "Author")
        request.resultType = .dictionaryResultType
        request.fetchLimit = 5
        request.propertiesToFetch = ["country", "name"]
            //request.propertiesToGroupBy = [ "country", "name" ]

        let author = try! context.execute(request) as! NSAsynchronousFetchResult<NSFetchRequestResult>
        print(author.finalResult)

    }
    private func predicateFetch(with context: NSManagedObjectContext) {
            // Делаем выборку объектов Book.
            let request = NSFetchRequest<Book>(entityName: "Book")
            // Заполняем поля результирующих объектов значениями.
            request.returnsObjectsAsFaults = false
            // Значения свойства year объекта Book должны находиться в пределах от 1999 до 2003.
            request.predicate = NSPredicate(format: "%K BETWEEN {%ld, %ld}", #keyPath(Book.year), 1999, 2003)
        // Выполняем запрос.
            let books = try! context.fetch(request)
            // Распечатываем результат.
            print(books)
    }

    private func predicateFetch2(with context: NSManagedObjectContext) {
            // Делаем выборку объектов Book.
            let request = NSFetchRequest<Book>(entityName: "Book")
            // Заполняем поля результирующих объектов значениями.
            request.returnsObjectsAsFaults = false
            // У значения свойства author объекта Book прочитать значение свойства country и сравнить его со строкой USA,
            // а также значение свойства year объекта Book должно быть меньше 1990.
            request.predicate = NSPredicate(format: "%K.%K == %@ AND %K < %ld",
                    // Книга с автором из США: author.country == USA
                    #keyPath(Book.author), #keyPath(Author.country), "USA",
                    // Книга выпущена до 1990: year < 1990
                    #keyPath(Book.year), 1990)
      // Выполняем запрос.
            let books = try! context.fetch(request)
            // Распечатываем результат.
            print(books)
    }

    private func predicateFetch3(with context: NSManagedObjectContext) {
            // Делаем выборку объектов Book.
            let request = NSFetchRequest<Book>(entityName: "Book")
            // Заполняем поля результирующих объектов значениями.
            request.returnsObjectsAsFaults = false
            // В поле title модели Book должно присутствовать слово Harry.
            request.predicate = NSPredicate(format: "%K CONTAINS[n] %@", #keyPath(Book.title), "Harry")
       // Выполняем запрос.
            let books = try! context.fetch(request)
            // Распечатываем результат.
            print(books)
    }

    // Подготовим данные с которыми будем работать на уроке.
    private func setupRecords(with context: NSManagedObjectContext) {
        
        // Для того чтобы каждый раз не добавлять новые записи выполняем проверку
        // существуют ли записи.
        let checkRequest = Book.fetchRequest()
        let result = try! context.fetch(checkRequest)
        if result.count > 0 { return }
        
        struct RawAuthor {
            let name: String
            let age: Int
            let country: String
        }
        
        // Добавляем авторов.
        let authors = [RawAuthor(name: "Stephen King", age: 1947, country: "USA"),
                       RawAuthor(name: "Joanne Rowling", age: 1965, country: "UK"),
                       RawAuthor(name: "George Martin", age: 1948, country: "USA")]
            .enumerated()
            .map { index, raw in
                let author = Author(context: context)
                author.authorId = Int32(index)
                author.age = Int16(raw.age)
                author.country = raw.country
                author.name = raw.name
                return author
            }
        
        struct RawBook {
            let title: String
            let author: Int
            let year: Int16
        }

        // Добавляем книжки.
        let _ = [RawBook(title: "Harry Potter and the Philosopher's Stone", author: 2, year: 1997),
                 RawBook(title: "Harry Potter and the Chamber of Secrets", author: 2, year: 1998),
                 RawBook(title: "Harry Potter and the Prisoner of Azkaban", author: 2, year: 1999),
                 RawBook(title: "Harry Potter and the Goblet of Fire", author: 2, year: 2000),
                 RawBook(title: "Harry Potter and the Order of the Phoenix", author: 2, year: 2003),
                 RawBook(title: "Harry Potter and the Half-Blood Prince", author: 2, year: 2005),
                 RawBook(title: "Harry Potter and the Deathly Hallows", author: 2, year: 2007),
                 RawBook(title: "Carrie", author: 2, year: 1974),
                 RawBook(title: "The Shining", author: 1, year: 1977),
                 RawBook(title: "Cujo", author: 1, year: 1981),
                 RawBook(title: "The Running Man", author: 1, year: 1982),
                 RawBook(title: "It", author: 1, year: 1986),
                 RawBook(title: "Needful Things", author: 1, year: 1991),
                 RawBook(title: "Insomnia", author: 1, year: 1994),
                 RawBook(title: "Cell", author: 1, year: 2006),
                 RawBook(title: "Bag of Bones", author: 1, year: 1998)]
            .enumerated()
            .map { index, raw in
                let book = Book(context: context)
                book.bookId = Int32(index)
                book.title = raw.title
                book.year = raw.year
                book.author = authors[raw.author]
                return book
            }
        
        try! context.save()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupRecords(with: persistentContainer.viewContext)
        
        // Here we operate
        predicateFetch3(with: persistentContainer.viewContext)
        grouppedFetch(with: persistentContainer.viewContext)
    }

}
