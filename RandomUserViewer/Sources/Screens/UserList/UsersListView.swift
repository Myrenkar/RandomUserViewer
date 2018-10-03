import UIKit

final class UsersListView: View {

    // MARK: Subviews

    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = UIView(frame: .zero)

        return tableView
    }()


    // MARK: Overrides

    override func setupViewHierarchy() {
        super.setupViewHierarchy()
        addSubview(tableView)
    }

    override func setupLayoutConstraints() {
        super.setupLayoutConstraints()

        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

}
