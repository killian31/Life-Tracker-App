//
//  AddDataView.swift
//  Life Tracker
//
//  Created by Kiki on 10/11/2022.
//

import SwiftUI
import SwiftUIKit

let components: [String] = ["Argent", "Amour", "Amis", "Famille", "Études", "Emploi", "Équipements", "Logement", "Santé", "Sport", "Activité sexuelle", "Reconnaissance", "Bonheur"]
let icons: [String] = ["dollarsign.circle.fill", "heart.circle.fill", "person.3.fill", "figure.2.and.child.holdinghands", "studentdesk", "latch.2.case.fill", "macbook.and.iphone", "house.fill", "cross.fill", "dumbbell.fill", "18.circle.fill", "hands.clap.fill", "face.smiling"]

struct AddDataView: View {
    var body: some View {
        TabView {
            // Money view
            MoneyView()
            
            // Every other view
            ForEach((1...12), id: \.self) {
                ComponentView(title: components[$0], icon: icons[$0])
            }
        }
        .onAppear() {
            UIPageControl.appearance().currentPageIndicatorTintColor = .blue
            UIPageControl.appearance().pageIndicatorTintColor = .gray
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
    }
}

struct AddDataView_Previews: PreviewProvider {
    static var previews: some View {
        AddDataView()
    }
}

struct MoneyView: View {

    @State private var value = 0
    
    private var numberFormatter: NumberFormatter
    
    init(numberFormatter: NumberFormatter = NumberFormatter()) {
            self.numberFormatter = numberFormatter
            self.numberFormatter.numberStyle = .currency
            self.numberFormatter.maximumFractionDigits = 2
        }
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: icons[0])
                    .foregroundColor(.orange)
                    .imageScale(.large)
                Text(components[0])
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(/*@START_MENU_TOKEN@*/.orange/*@END_MENU_TOKEN@*/)
            }
            CurrencyTextField(numberFormatter: numberFormatter, value: $value)
                            .padding(20)
                            .overlay(RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color.gray.opacity(0.3), lineWidth: 2))
                            .frame(height: 100)
                        
                        Rectangle()
                            .frame(width: 0, height: 40)
        }
    }
}

struct ComponentView: View {
    @State var title: String
    @State var icon: String
    var body: some View {
        HStack {
            Image(systemName: self.icon)
                .foregroundColor(.orange)
                .imageScale(.large)
            Text(self.title)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(/*@START_MENU_TOKEN@*/.orange/*@END_MENU_TOKEN@*/)
        }
        
    }
}

struct CurrencyTextField: UIViewRepresentable {
    
    typealias UIViewType = CurrencyUITextField
    
    let numberFormatter: NumberFormatter
    let currencyField: CurrencyUITextField
    
    init(numberFormatter: NumberFormatter, value: Binding<Int>) {
        self.numberFormatter = numberFormatter
        currencyField = CurrencyUITextField(formatter: numberFormatter, value: value)
    }
    
    func makeUIView(context: Context) -> CurrencyUITextField {
        return currencyField
    }
    
    func updateUIView(_ uiView: CurrencyUITextField, context: Context) { }
}

class CurrencyUITextField: UITextField {
    
    @Binding private var value: Int
    private let formatter: NumberFormatter
    
    init(formatter: NumberFormatter, value: Binding<Int>) {
        self.formatter = formatter
        self._value = value
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        addTarget(self, action: #selector(resetSelection), for: .allTouchEvents)
        keyboardType = .numberPad
        textAlignment = .right
        sendActions(for: .editingChanged)
    }
    
    override func deleteBackward() {
        text = textValue.digits.dropLast().string
        sendActions(for: .editingChanged)
    }
    
    private func setupViews() {
        tintColor = .clear
        font = .systemFont(ofSize: 40, weight: .regular)
    }
    
    @objc private func editingChanged() {
        text = currency(from: decimal)
        resetSelection()
        value = Int(doubleValue * 100)
    }
    
    @objc private func resetSelection() {
        selectedTextRange = textRange(from: endOfDocument, to: endOfDocument)
    }
    
    private var textValue: String {
        return text ?? ""
    }

    private var doubleValue: Double {
      return (decimal as NSDecimalNumber).doubleValue
    }

    private var decimal: Decimal {
      return textValue.decimal / pow(10, formatter.maximumFractionDigits)
    }
    
    private func currency(from decimal: Decimal) -> String {
        return formatter.string(for: decimal) ?? ""
    }
}

extension StringProtocol where Self: RangeReplaceableCollection {
    var digits: Self { filter (\.isWholeNumber) }
}

extension String {
    var decimal: Decimal { Decimal(string: digits) ?? 0 }
}

extension LosslessStringConvertible {
    var string: String { .init(self) }
}
