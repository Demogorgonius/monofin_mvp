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
    //MARK: - Configure calendar cell
    
    
    func handleCellConfiguration(cell: JTACDayCell?, cellState: CellState) {
        handleCellTextColor(veiw: cell, cellState: cellState)
        handleCellSelection(view: cell, cellState: cellState)
    }
    
    func handleCellTextColor(veiw: JTACDayCell?, cellState: CellState) {
        guard let myCustomCell = view as? CalendarCustomCell else { return }
        if cellState.isSelected {
            myCustomCell.dateLabel.textColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
        } else {
            myCustomCell.dateLabel.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        }
    }
    
    func handleCellSelection(view: JTACDayCell?, cellState: CellState) {
        guard let myCustomCell = view as? CalendarCustomCell else {return }
//        switch cellState.selectedPosition() {
//        case .full:
//            myCustomCell.backgroundColor = .green
//        case .left:
//            myCustomCell.backgroundColor = .yellow
//        case .right:
//            myCustomCell.backgroundColor = .red
//        case .middle:
//            myCustomCell.backgroundColor = .blue
//        case .none:
//            myCustomCell.backgroundColor = nil
//        }
        
        if cellState.isSelected {
            myCustomCell.selectedView.layer.cornerRadius =  13
            myCustomCell.selectedView.isHidden = false
        } else {
            myCustomCell.selectedView.isHidden = true
        }
    }
    
    
}

//MARK: - Extension JTAppleCalendar

extension CalendarMainViewController: JTACMonthViewDataSource, JTACMonthViewDelegate {
    
    
    func configureCell(view: JTACDayCell?, cellState: CellState, date: Date, indexPath: IndexPath) {
        guard let cell = view as? CalendarCustomCell else { return }
        cell.dateLabel.text = cellState.text
        if calendar.isDateInToday(date) {
            cell.dateLabel.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        } else {
            cell.dateLabel.textColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
        }
        handleCellConfiguration(cell: cell, cellState: cellState)
        
    }
    
    func configureCalendar(_ calendar: JTACMonthView) -> ConfigurationParameters {
        //        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        let startDate = formatter.date(from: "2019 01 01")!
        let endDate = Date()
        let parameters = ConfigurationParameters(
            startDate: startDate,
            endDate: endDate,
            numberOfRows: numberOfRows,
            calendar: .current,
            generateInDates: .forAllMonths,
            generateOutDates: .off,
            firstDayOfWeek: .monday,
            hasStrictBoundaries: true)
        
        return parameters
    }

    func calendar(_ calendar: JTACMonthView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTACDayCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "CalendarCell", for: indexPath) as! CalendarCustomCell
        cell.dateLabel.text = cellState.text
        return cell
    }
    
    func calendar(_ calendar: JTACMonthView, willDisplay cell: JTACDayCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
         let customCell = cell as! CalendarCustomCell
        configureCell(view: customCell, cellState: cellState, date: date, indexPath: indexPath)
    }
    
}
