import SwiftUI

struct TaskTodo: View {
    @State var elementText: String = ""

    @State private var isHovered: Bool = false
    @State private var inEditMode: Bool = false
    @State private var buttonState: Double = 0

    var body: some View {
        ZStack {
            HStack{
                Image(systemName: buttonState == 0 ? "circle" : "circle.fill")
                    .foregroundColor(.accentColor)
                    .opacity(buttonState == 0 ? 1 : 0.8)
                    .onTapGesture {buttonState = buttonState == 0 ? 1 : 0}
                if inEditMode {
                    TextField("...", text: $elementText, onCommit: {inEditMode = false})
                        .opacity(buttonState == 0 ? 1 : 0.5)
                        .strikethrough(buttonState == 0 ? false : true)
                        .lineLimit(1)
                } else {
                    Text(elementText)
                        .opacity(buttonState == 0 ? 1 : 0.5)
                        .strikethrough(buttonState == 0 ? false : true)
                        .lineLimit(1)
                }
                Spacer()
                Image(systemName: "delete.left")
                    .padding(.trailing, 5)
                    .opacity(isHovered ? 1 : 0)
                    .onTapGesture {print("Delete item")}
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 10)
            .onHover(perform: {_hovered in isHovered = _hovered})
        }
        .onTapGesture(count: 2) {inEditMode = true}
    }
}

struct TaskTodoView_Previews: PreviewProvider {
    static var previews: some View {
        TaskTodo(elementText: "Generetic Task")
    }
}
