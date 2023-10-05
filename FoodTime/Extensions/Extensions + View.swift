//
//  Extensions + View.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 19.09.23.
//

import SwiftUI
import Combine

extension View {
    
    func skeletons(_ direction: Axis, count: Int, lenght: CGFloat, cornerRadius: CGFloat = 12) -> some View {
        return Group {
            if direction == .horizontal {
                HStack {
                    ForEach(0..<count, id: \.self) { _ in
                        SkeletonView(cornerRadius: cornerRadius)
                            .frame(height: lenght)
                    }
                }
            } else {
                VStack {
                    ForEach(0..<count, id: \.self) { _ in
                        SkeletonView(cornerRadius: cornerRadius)
                            .frame(width: lenght)
                    }
                }
            }
        }
    }
    
    func endEditing(_ force: Bool) {
            UIApplication.shared.windows.forEach { $0.endEditing(force)}
        }
}

struct ScrollManagerView: UIViewRepresentable {
    
    @Binding var indexPathToSetVisible: IndexPath?
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        guard let indexPath = indexPathToSetVisible else { return }
        let superview = uiView.findViewController()?.view
        
        if let tableView = superview?.subview(of: UITableView.self) {
            if tableView.numberOfSections > indexPath.section &&
                tableView.numberOfRows(inSection: indexPath.section) > indexPath.row {
                tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
            }
        }
        
        DispatchQueue.main.async {
            self.indexPathToSetVisible = nil
        }
    }
}

extension UIView {
    
    func subview<T>(of type: T.Type) -> T? {
        return subviews.compactMap { $0 as? T ?? $0.subview(of: type) }.first
    }
    
    func findViewController() -> UIViewController? {
        if let nextResponder = self.next as? UIViewController {
            return nextResponder
        } else if let nextResponder = self.next as? UIView {
            return nextResponder.findViewController()
        } else {
            return nil
        }
    }
}

extension Binding {
    
    func onUpdate(_ closure: @escaping () -> Void) -> Binding<Value> {
        Binding(get: {
            wrappedValue
        }, set: { newValue in
            wrappedValue = newValue
            closure()
        })
    }
}
