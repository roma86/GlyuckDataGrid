//
//  NSIndexPath+DataGrid.swift
//
//  Created by Vladimir Lyukov on 31/07/15.
//

import Foundation


/**
 Custom extension for NSIndexPath to support data grid view rows/columns. You should NOT used indexPath.row to access data grid view row index. Use indexPath.dataGridRow and indexPath.dataGridSection instead.
*/
public extension IndexPath {
    /// An index number identifying a column in a row of a data grid view. (read-only)
    var dataGridColumn: Int {
        return self.startIndex
    }

    /// An index number identifying a row in a data grid view. (read-only)
    var dataGridRow: Int {
        return self.startIndex
    }

    /// An index number for single-item indexPath
    var index: Int {
        return self.startIndex
    }
}
