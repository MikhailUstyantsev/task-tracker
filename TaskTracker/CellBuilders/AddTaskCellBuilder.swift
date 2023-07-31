

import Foundation

struct  AddTaskCellBuilder {
    
    func makeTitleSubtitleCellViewModel(_ type: TitleSubtitleCellViewModel.CellType, onCellUpdate: (() -> Void)? = nil) -> TitleSubtitleCellViewModel {
        switch type {
        case .text: return TitleSubtitleCellViewModel(
            title: "Заголовок",
            subtitle: "",
            placeholder: "Что будете делать?",
            type: .text, onCellUpdate: onCellUpdate)
        case .date: return TitleSubtitleCellViewModel(
            title: "Дата",
            subtitle: "",
            placeholder: "Выберите дату события", type: .date,
            onCellUpdate: onCellUpdate)
        }
    }
    
    
}
