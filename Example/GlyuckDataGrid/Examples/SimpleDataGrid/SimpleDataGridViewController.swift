//
//  SimpleDataGridViewController.swift
//
//  Created by Vladimir Lyukov on 07/30/2015.
//

import UIKit
import GlyuckDataGrid


class SimpleDataGridViewController: UIViewController, DataGridViewDataSource, DataGridViewDelegate {
    let columnsTitles = ["Year", "Driver", "Age", "Team", "Engine", "Poles", "Wins", "Podiums", "Fastest\nlaps", "Points", "Clinched", "Points\nmargin"]
    let columns = ["season", "driver", "age", "team", "engine", "poles", "wins", "podiums", "fastest_laps", "points", "clinched", "point_margin"]
    let columnsWidths: [CGFloat] = [70, 150, 60, 120, 110, 70, 70, 95, 70, 75, 130, 70]
    var dataSource = f1stats

    @IBOutlet weak var dataGridView: DataGridView!
    override func viewDidLoad() {
        super.viewDidLoad()

        dataGridView.dataSource = self
        dataGridView.delegate = self
    }

    // MARK: DataGridViewDataSource

    func numberOfColumnsInDataGridView(dataGridView: DataGridView) -> Int {
        return columns.count
    }

    func numberOfRowsInDataGridView(dataGridView: DataGridView) -> Int {
        return dataSource.count
    }

    func dataGridView(dataGridView: DataGridView, titleForHeaderForColumn column: Int) -> String {
        return columnsTitles[column]
    }

    func dataGridView(dataGridView: DataGridView, textForCellAtIndexPath indexPath: NSIndexPath) -> String {
        let fieldName = columns[indexPath.dataGridColumn]
        return dataSource[indexPath.dataGridRow][fieldName]!
    }

    func dataGridView(dataGridView: DataGridView, viewForHeaderForColumn column: Int) -> DataGridViewColumnHeaderCell {
        let cell = dataGridView.dequeueReusableHeaderViewWithReuseIdentifier(DataGridView.ReuseIdentifiers.defaultColumnHeader, forColumn: column)
        cell.title = self.dataGridView(dataGridView, titleForHeaderForColumn: column)
        if column == 1 {
            cell.border.rightWidth = 1 / UIScreen.mainScreen().scale
            cell.border.rightColor = UIColor(white: 0.72, alpha: 1)
        } else {
            cell.border.rightWidth = 0
        }
        return cell
    }

    func dataGridView(dataGridView: DataGridView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = dataGridView.dequeueReusableCellWithReuseIdentifier(DataGridView.ReuseIdentifiers.defaultCell, forIndexPath: indexPath) as! DataGridViewContentCell
        cell.textLabel.text = self.dataGridView(dataGridView, textForCellAtIndexPath: indexPath)
        switch indexPath.dataGridColumn {
        case 0,2,5,6,7,8,9,11:
            cell.textLabel.textAlignment = .Right
        default:
            cell.textLabel.textAlignment = .Left
        }
        if indexPath.dataGridColumn == 1 {
            cell.border.rightWidth = 1 / UIScreen.mainScreen().scale
            cell.border.rightColor = UIColor(white: 0.72, alpha: 1)
        } else {
            cell.border.rightWidth = 0
        }
        return cell
    }

    // MARK: DataGridViewDelegate

    func dataGridView(dataGridView: DataGridView, widthForColumn column: Int) -> CGFloat {
        return columnsWidths[column]
    }

    func dataGridView(dataGridView: DataGridView, shouldFloatColumn column: Int) -> Bool {
        return column == 1
    }

    func dataGridView(dataGridView: DataGridView, shouldSortByColumn column: Int) -> Bool {
        return true
    }

    func dataGridView(dataGridView: DataGridView, didSortByColumn column: Int, ascending: Bool) {
        let columnName = columns[column]
        dataSource = f1stats.sort { ($0[columnName] < $1[columnName]) == ascending }
        dataGridView.reloadData()
    }
}
