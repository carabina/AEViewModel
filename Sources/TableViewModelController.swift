import UIKit

open class TableViewModelController: UITableViewController {
    
    // MARK: Properties
    
    open var model: Table?
    
    // MARK: Init
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customInit()
    }
    
    public override init(style: UITableViewStyle) {
        super.init(style: style)
        customInit()
    }
    
    public convenience init(style: UITableViewStyle, model: Table) {
        self.init(style: style)
        self.model = model
        customInit()
    }
    
    public convenience init() {
        self.init(style: .grouped)
        customInit()
    }
    
    // MARK: Lifecycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    // MARK: Abstract
    
    open func customInit() {}
    
    open func cell(forIdentifier identifier: String) -> TableCell {
        return .basic
    }
    
    open func updateCell(_ cell: TableViewModelCell, with item: Item) {
        cell.update(with: item)

        if let cell = cell as? TableCell.Button {
            cell.action = {
                self.handleEvent(.touchUpInside, with: item, sender: cell.button)
            }
        }

        if let cell = cell as? TableCell.Toggle {
            cell.action = {
                self.handleEvent(.valueChanged, with: item, sender: cell.toggle)
            }
        }
    }
    
    open func handleEvent(_ event: UIControlEvents, with item: Item, sender: Any) {
        print("This method is abstract and must be implemented by subclass")
    }
    
    // MARK: API
    
    public func item(from cell: TableViewModelCell) -> Item? {
        guard
            let tableViewCell = cell as? UITableViewCell,
            let indexPath = tableView.indexPath(for: tableViewCell),
            let item = model?.item(at: indexPath)
        else { return nil }
        return item
    }
    
    public func pushTable(from item: Item, in tvmc: TableViewModelController) {
        if let model = item.child as? Table {
            tvmc.model = model
            navigationController?.pushViewController(tvmc, animated: true)
        }
    }
    
    // MARK: Helpers
    
    private func configureTableView() {
        title = model?.title
        registerCells()
    }
    
    private func registerCells() {
        var uniqueIdentifiers: Set<String> = Set<String>()
        model?.sections.forEach { section in
            let sectionIdentifiers = section.items.flatMap({ $0.identifier })
            uniqueIdentifiers.formUnion(sectionIdentifiers)
        }
        uniqueIdentifiers.forEach { identifier in
            registerCell(with: identifier)
        }
    }
    
    private func registerCell(with identifier: String) {
        switch cell(forIdentifier: identifier) {
        case .basic:
            tableView.register(TableCell.Basic.self, forCellReuseIdentifier: identifier)
        case .subtitle:
            tableView.register(TableCell.Subtitle.self, forCellReuseIdentifier: identifier)
        case .leftDetail:
            tableView.register(TableCell.LeftDetail.self, forCellReuseIdentifier: identifier)
        case .rightDetail:
            tableView.register(TableCell.RightDetail.self, forCellReuseIdentifier: identifier)
        case .button:
            tableView.register(TableCell.Button.self, forCellReuseIdentifier: identifier)
        case .toggle:
            tableView.register(TableCell.Toggle.self, forCellReuseIdentifier: identifier)
        case .textInput:
            tableView.register(TableCell.TextInput.self, forCellReuseIdentifier: identifier)
        case .customClass(let cellClass):
            tableView.register(cellClass, forCellReuseIdentifier: identifier)
        case .customNib(let cellNib):
            tableView.register(cellNib, forCellReuseIdentifier: identifier)
        }
    }
    
}

// MARK: - UITableViewControllerDataSource

extension TableViewModelController {
    
    open override func numberOfSections(in tableView: UITableView) -> Int {
        return model?.sections.count ?? 0
    }
    
    open override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.sections[section].items.count ?? 0
    }
    
    open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = model?.item(at: indexPath) else {
            return UITableViewCell()
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: item.identifier, for: indexPath)
        if let cell = cell as? TableViewModelCell {
            updateCell(cell, with: item)
        }
        return cell
    }
    
    open override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return model?.sections[section].header
    }
    
    open override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return model?.sections[section].footer
    }
    
}

// MARK: - UITableViewControllerDelegate

extension TableViewModelController {
    
    open override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard
            let item = model?.item(at: indexPath),
            let cell = tableView.cellForRow(at: indexPath)
        else { return }
        
        if cell.selectionStyle != .none {
            handleEvent(.primaryActionTriggered, with: item, sender: cell)
        }
    }
    
}
