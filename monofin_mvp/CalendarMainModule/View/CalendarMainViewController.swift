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
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var userAvatarImage: UIImageView!
    
    //MARK: - Variables
    var calendar = Calendar.current
    var user: UserInfo!
    var numberOfRows = 6
    let formatter = DateFormatter()
    var presenter: CalendarInProtocol!
//    var assemnblyBuilder: AssemblyBuilderProtocol!
//    var router: RouterInputProtocol!
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCalendarView()
        
        let blurEffect = UIBlurEffect(style: .dark)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = backImageView.bounds
        view.addSubview(blurredEffectView)
        let subViewCount = view.subviews.count
        view.exchangeSubview(at: 1, withSubviewAt: subViewCount-1)
        
        presenter.setUser()
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)]
        let addButton = UIBarButtonItem(image: .add, style: .plain, target: self, action: #selector(addTapped))
        navigationController?.viewControllers[0].navigationItem.rightBarButtonItem = addButton
        navigationController?.viewControllers[0].navigationItem.title =  "Главная"
        
        
    }
    
    @objc func addTapped() {
        presenter.addTapped()
    }
    
    func setupCalendarView() {
        calendarView.calendarDataSource = self
        calendarView.calendarDelegate = self
        calendarView.register(UINib.init(nibName: "CalendarCustomCell", bundle: Bundle.main), forCellWithReuseIdentifier: "CalendarCell")
        calendarView.scrollToDate(Date(), animateScroll: false)
        calendarView.scrollDirection = .horizontal
        calendarView.scrollingMode = .stopAtEachCalendarFrame
        calendarView.minimumInteritemSpacing = 0
        calendarView.minimumLineSpacing = 0
        calendarView.visibleDates{ (visibleDates) in
            self.setupViewsOfCalendar(from: visibleDates)
        }
        
    }
    
}

//MARK: - Extension JTAppleCalendar

extension CalendarMainViewController: JTACMonthViewDataSource, JTACMonthViewDelegate {
    
    //MARK: - Configure calendar year and month label
    
    func setupViewsOfCalendar(from visibleDates: DateSegmentInfo) {
        let date = visibleDates.monthDates.first!.date
        self.formatter.dateFormat = "yyyy"
        self.yearLabel.text = self.formatter.string(from: date)
        self.formatter.locale = Locale(identifier: "ru_RU")
        self.formatter.dateFormat = "LLLL"
        self.monthLabel.text = self.formatter.string(from: date)
    }
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
            myCustomCell.selectedView.layer.cornerRadius =  30
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
        addTapped()
        handleCellConfiguration(cell: cell, cellState: cellState)
    }
    func calendar(_ calendar: JTACMonthView, didDeselectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) {
        handleCellConfiguration(cell: cell, cellState: cellState)
    }
    func calendar(_ calendar: JTACMonthView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        setupViewsOfCalendar(from: visibleDates)
    }
    
}


extension CalendarMainViewController: CalendarOutProtocol {
    func success() {
        
    }
    
    func failure(error: Error) {
        
    }
    
    func setUser(user: UserInfo?) {
        print("curent user is: \(String(describing: user?.userName))")
    }
    
    
}
