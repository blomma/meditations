import Combine
import Foundation
import SwiftUI

struct QuestionView: View {
    var question: Question
    @Binding var rating: Rating

    var header: String

    var body: some View {
        VStack(alignment: .leading) {
            makeLabel(question.label)
                .padding(.vertical, 8)
            Picker(selection: $rating,
                   label: Text(question.label)) {
                ForEach(Rating.allCases, id: \.self) {
                    Text($0.title).tag($0)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .labelsHidden()
        }
    }

    private func makeLabel(_ text: String) -> some View {
        Text(LocalizedStringKey(text))
            .font(Font.system(.headline, design: .rounded))
            .fontWeight(.semibold)
            .lineLimit(2)
            .foregroundColor(.acText)
    }
}

struct QuestionView_Previews: PreviewProvider {
    @State static var q = Question(id: "test", label: "test")
    @State static var r: Rating = .one

    static var previews: some View {
        QuestionView(question: q, rating: $r, header: "test")
    }
}
