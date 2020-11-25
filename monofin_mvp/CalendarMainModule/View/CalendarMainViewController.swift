//
//  CalendarMainViewController.swift
//  monofin_mvp
//
//  Created by Sergey on 20.11.2020.
//

import UIKit
import JTAppleCalendar

class CalendarMainViewController: UIViewController {
    
    //MARK: - @IBOutlet
    
    @IBOutlet weak var calendarView: JTACMonthView!
    
    //MARK: - Variables
    var calendar = Calendar.current
    var numberOfRows = 6
    let formatter = DateFormatter()
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        calendarView.calendarDataSource = self
        calendarView.calendarDelegate = self
        calendarView.register(UINib.init(nibName: "CalendarCustomCell", bundle: Bundle.main), forCellWithReuseIdentifier: "CalendarCell")
        calendarView.scrollToDate(Date(), animateScroll: false)
        calendarView.scrollDirection = .horizontal
        calendarView.scrollingMode = .stopAtEachCalendarFrame
        super.viewDidLoad()
        
        
    }
    
}

//MARK: - Extension JTAppleCalendar

extension CalendarMainViewController: JTACMonthViewDataSource, JTACMonthViewDelegate {
    
    //MARK: - Configure calendar cell
    
    func handleCellConfiguration(cell: JTACDayCell?, cellState: CellState) {
        handleCellTextColor(veiw: cell, cellState: cellState)
        handleCellSelection(view: cell, cellState: cellState)
    }
    
    func handleCellTextColor(veiw: JTACDayCell?, cellState: CellState) {
        guard let myCustomCell = view as? CalendarCustomCell else { return }
        
        if cellState.isSelected {
            myCustomCell.dateLabel.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        } else {
            myCustomCell.dateLabel.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        }
    }
    
    func handleCellSelection(view: JTACDayCell?, cellState: CellState) {
        guard let myCustomCell = view as? CalendarCustomCell else {return }
        if cellState.isSelected {
            myCustomCell.selectedView.layer.cornerRadius =  13
            myCustomCell.selectedView.frame.size = myCustomCell.frame.size
            myCustomCell.selectedView.isHidden = false
        } else {
            myCustomCell.selectedView.isHidden = true
        }
    }
    
    
    func configureCell(view: JTACDayCell?, cellState: CellState, date: Date, indexPath: IndexPath) {
        
        guard let cell = view as? CalendarCustomCell else { return }
        cell.dateLabel.text = cellState.text
        if cellState.dateBelongsTo == .thisMonth {
            cell.dateLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
        else {
            cell.dateLabel.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        }
        if calendar.isDateInToday(date) {
            cell.dateLabel.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        }
        
        handleCellConfiguration(cell: cell, cellState: cellState)
        
    }
    
    //MARK: - Configure Calendar
    
    func configureCalendar(_ calendar: JTACMonthView) -> ConfigurationParameters {
        
        formatter.dateFormat = "yyyy MM dd"
        let startDate = formatter.date(from: "2019 01 01")!
        let endDate = Date()
        let parameters = ConfigurationParameters(
            startDate: startDate,
            endDate: endDate,
            numberOfRows: numberOfRows,
            calendar: .current,
            generateInDates: .forAllMonths,
            generateOutDates: .tillEndOfGrid,
            firstDayOfWeek: .monday,
            hasStrictBoundaries: true)
        
        return parameters
    }
    
    func calendar(_ calendar: JTACMonthView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTACDayCell {
        let customCell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "CalendarCell", for: indexPath) as! CalendarCustomCell
        configureCell(view: customCell, cellState: cellState, date: date, indexPath: indexPath)
        return customCell
    }
    
    func calendar(_ calendar: JTACMonthView, willDisplay cell: JTACDayCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        let customCell = cell as! CalendarCustomCell
        configureCell(view: customCell, cellState: cellState, date: date, indexPath: indexPath)
    }
    
    func calendar(_ calendar: JTACMonthView, didSelectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) {
        handleCellConfiguration(cell: cell, cellState: cellState)
    }
    func calendar(_ calendar: JTACMonthView, didDeselectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) {
        handleCellConfiguration(cell: cell, cellState: cellState)
    }
    
}
