import UIKit

class TableViewCell: UITableViewCell {

    // MARK: - Initialization

    override init(style: CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupProperties()
        setupViewHierarchy()
        setupLayoutConstraints()
    }

    // MARK: Abstract

    /// Sets up the properties of `self`. Called automatically on `init()`
    func setupProperties() {}

    /// Sets up the view hierarchy of `self`. Called automatically on `init()`
    func setupViewHierarchy() {}

    /// Sets up the layout constraints of `self`. Called automatically on `init()`
    func setupLayoutConstraints() {}

    @available(*, unavailable, message: "Use init(style:reuseIdentifier) instead")
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TableViewCell: Reusable {}

