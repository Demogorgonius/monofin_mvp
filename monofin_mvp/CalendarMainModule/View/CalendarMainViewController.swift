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
        super.viewDidLoad()
        self.calendarView.register(UINib.init(nibName: "CalendarCustomCell", bundle: nil), forCellWithReuseIdentifier: "CalendarCell")
        self.calendarView.scrollToDate(Date(), animateScroll: false)
        self.calendarView.scrollDirection = .horizontal
        self.calendarView.scrollingMode = .stopAtEachCalendarFrame
        self.calendarView.calendarDataSource = self
        self.calendarView.calendarDelegate = self
        
        
    }
    //MARK: - Configure calendar cell
    
    func configureCell(view: JTACDayCell?, cellState: CellState) {
        guard let cell = view as? CalendarCustomCell else { return }
        cell.dateLabel.text = cellState.text
        handleCellTextColor(cell: cell, cellState: cellState)
    }
    
    func handleCellTextColor(cell: CalendarCustomCell, cellState: CellState) {
        if cellState.dateBelongsTo == .thisMonth {
            cell.dateLabel.textColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
        } else {
            cell.dateLabel.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        }
    }
    
    
}

//MARK: - Extension JTAppleCalendar

extension CalendarMainViewController: JTACMonthViewDataSource {
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
}

extension CalendarMainViewController: JTACMonthViewDelegate {
    
    func calendar(_ calendar: JTACMonthView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTACDayCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "CalendarCell", for: indexPath) as! CalendarCustomCell
        cell.dateLabel.text = cellState.text
        return cell
    }
    
    func calendar(_ calendar: JTACMonthView, willDisplay cell: JTACDayCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        configureCell(view: cell, cellState: cellState)
    }
    
}
