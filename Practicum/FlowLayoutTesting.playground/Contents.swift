import UIKit
import Foundation
import PlaygroundSupport

// Класс ячейки должен наследоваться от `UICollectionViewCell`.
// Ключевое слово final позволяет немного ускорить компиляцию и гарантирует, что от класса не будет никаких наследников.
final class ColorCell: UICollectionViewCell {

    // Идентификатор ячейки — используется для регистрации и восстановления:
    static let identifier = "ColorCell"

    // Конструктор:
    override init(frame: CGRect) {
        super.init(frame: frame)

        // Закруглим края для ячейки:
        contentView.layer.cornerRadius = 5
        contentView.layer.masksToBounds = true
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}

// Основной класс, в котором мы будем выполнять эксперименты;
// он же является `UICollectionViewDataSource`, поставщиком данных для коллекции:
final class SupplementaryCollection: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    private var colors = [UIColor]()
    private let collection: UICollectionView
    private let params: GeometricParams

    // Немного изменим сигнатуру конструктора
    init(using params: GeometricParams, collection: UICollectionView) {
        self.params = params
        self.collection = collection

        super.init()

        // Зарегистрируем ячейку в коллекции.
        // Это более правильный подход, потому что именно в классе SupplementaryCollection, в методе делегата получения ячейки, выполняется кастинг к классу ColorCell.
        collection.register(ColorCell.self, forCellWithReuseIdentifier: ColorCell.identifier)

        // Устанавливаем делегаты. Обратите внимание: сейчас мы устанавливаем self, то есть самих себя.
        collection.delegate = self
        collection.dataSource = self

        collection.reloadData()
    }

    func add(colors values: [UIColor]) {

        guard !values.isEmpty else { return }

        let count = colors.count
        colors = colors + values

        collection.performBatchUpdates {
            let indexes = (count..<colors.count).map { IndexPath(row: $0, section: 0) }
            collection.insertItems(at: indexes)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Удаляем из массива элемент с индексом
        let colorName = colors[indexPath.row].accessibilityName
        let indexes = colors.enumerated()
            .filter { $0.element.accessibilityName == colorName }
            .map { $0.offset }

        colors.remove(atOffsets: .init(indexes))

        collectionView.performBatchUpdates {
            collectionView.deleteItems(at: indexes.map { .init(row: $0, section: 0) })
        }
    }

    // MARK: - UICollectionViewDataSource

    // Количество элементов в коллекции будет равно длине массива.
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }

    // При отображении ячейки мы будем не выбирать любой цвет из всех доступных, а устанавливать тот, который записан в массиве по соответствующему индексу.

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorCell.identifier,

                                                           for: indexPath) as? ColorCell else {
            return UICollectionViewCell()
        }
        cell.prepareForReuse()
        cell.contentView.backgroundColor = colors[indexPath.row]
        return cell
    }

    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availableWidth = collectionView.frame.width - params.paddingWidth
        let cellWidth =  availableWidth / CGFloat(params.cellCount)
        return CGSize(width: cellWidth,
                      height: cellWidth * 2 / 3)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 10, left: params.leftInset, bottom: 10, right: params.rightInset)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        params.cellSpacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        params.cellSpacing
    }
}

struct GeometricParams {
    let cellCount: Int
    let leftInset: CGFloat
    let rightInset: CGFloat
    let cellSpacing: CGFloat
    // Параметр вычисляется уже при создании, что экономит время на вычислениях при отрисовке коллекции.
    let paddingWidth: CGFloat

    init(cellCount: Int, leftInset: CGFloat, rightInset: CGFloat, cellSpacing: CGFloat) {
        self.cellCount = cellCount
        self.leftInset = leftInset
        self.rightInset = rightInset
        self.cellSpacing = cellSpacing
        self.paddingWidth = leftInset + rightInset + CGFloat(cellCount - 1) * cellSpacing
    }
}

// Размеры для коллекции:
let size = CGRect(origin: CGPoint(x: 0, y: 0),
                  size: CGSize(width: 400, height: 400))
let view = UIView(frame: size)
// Указываем, какой Layout хотим использовать:
let layout = UICollectionViewFlowLayout()
layout.scrollDirection = .horizontal
let params = GeometricParams(cellCount: 3,
                             leftInset: 10,
                             rightInset: 10,
                             cellSpacing: 10)

let collection = UICollectionView(frame: size,
                                  collectionViewLayout: layout)
collection.backgroundColor = .white

collection.translatesAutoresizingMaskIntoConstraints = false
view.addSubview(collection)
let helper = SupplementaryCollection(using: params, collection: collection)

// Создадим стандартную кнопку с экшеном.
// Обратите внимание, что экземпляр helper удерживается по weak ссылке.
let addButton = UIButton(type: .roundedRect, primaryAction: UIAction(title: "Add color", handler: { [weak helper] _ in

    // Массив доступных цветов
    let colors: [UIColor] = [
        .black, .blue, .brown,
        .cyan, .green, .orange,
        .red, .purple, .yellow
    ]

    // Произвольно выберем два цвета из массива
    let selectedColors = (0..<2).map { _ in colors[Int.random(in: 0..<colors.count)] }
    // Добавим выбранные цвета в коллекцию через ранее созданный экземпляр helper
    helper?.add(colors: selectedColors)
}))
// Добавим кнопку в главное View
addButton.translatesAutoresizingMaskIntoConstraints = false
view.addSubview(addButton)

NSLayoutConstraint.activate([
    // Границы коллекции слева, справа и сверху совпадают с главным View
    collection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
    collection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
    collection.topAnchor.constraint(equalTo: view.topAnchor),
    // Высота — 80% от высоты главного View
    collection.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.8),
    // Границы кнопки слева, справа и снизу совпадают с главным View
    addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
    addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
    addButton.bottomAnchor.constraint(equalTo: view.bottomAnchor),
    // Высота кнопки 30
    addButton.heightAnchor.constraint(equalToConstant: 30)
])

PlaygroundPage.current.liveView = view

