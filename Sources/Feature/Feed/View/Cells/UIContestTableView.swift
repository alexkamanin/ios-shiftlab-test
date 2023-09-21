import UIKit

final class UIContestTableView: UITableView {

    var cells: [Contest] = [] {
        didSet {
            reloadSections(IndexSet(integer: 0), with: .automatic)
        }
    }

    private var clickListener: ((Contest) -> Void)?

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init() {
        super.init(frame: .zero, style: .plain)

        dataSource = self
        delegate = self

        register(UIContestTableViewCell.self, forCellReuseIdentifier: "\(UIContestTableViewCell.self)")
    }

    func setSelectedListener(_ listener: @escaping (Contest) -> ()) {
        self.clickListener = listener
    }

    func removeSelectedListener() {
        self.clickListener = nil
    }
}

extension UIContestTableView: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cells.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellValue = cells[indexPath.item]
        guard let cellView = dequeueReusableCell(
            withIdentifier: "\(UIContestTableViewCell.self)",
            for: indexPath
        ) as? UIContestTableViewCell else {
            fatalError("is not supported")
        }
        cellView.setData(cellValue)
        return cellView
    }
}

extension UIContestTableView: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellValue = cells[indexPath.row]
        self.clickListener?(cellValue)
        self.deselectRow(at: indexPath, animated: false)
    }
}
