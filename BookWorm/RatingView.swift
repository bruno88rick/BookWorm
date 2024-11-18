//
//  RatingView.swift
//  BookWorm
//
//  Created by Bruno Oliveira on 29/05/24.
//

import SwiftUI

struct RatingView: View {
    @Binding var rating: Int
    
    var label = ""
    var maximumRating = 5
    
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")
    
    var offColor = Color.gray
    var onColor = Color.yellow
    
    var body: some View {
        HStack {
            if label.isEmpty == false {
                Text(label)
            }
            
            ForEach(1..<maximumRating + 1, id: \.self) { number in
                Button {
                    rating = number
                } label: {
                    image(for: number)
                        .foregroundStyle(number > rating ? offColor : onColor)
                }
                //we can do this for accessibility:
                /*
                .accessibilityLabel("\(number == 1 ? "1 Star" : "\(number) stars")")
                //Now we can make VoiceOver add a second trait, .isSelected, if the star is already highlighted
                .accessibilityAddTraits(number > rating ? [] : [.isSelected])
            */
            }
        }
        //We can disable the whole "tap the row to trigger its buttons" behavior with an extra modifier attached to the whole HStack:
        .buttonStyle(.plain)
        //we can do better for accessibility rather than above on the button
        .accessibilityElement()
        .accessibilityLabel(label)
        .accessibilityValue(rating == 1 ? "1 Star" : "\(rating) stars")
        .accessibilityAdjustableAction {   direction in
        
            switch direction {
            case .increment:
                if rating < maximumRating { rating += 1 }
            case .decrement:
                if rating > 1 { rating -= 1 }
            default:
                break
            }
            
        }
    }
    
    func image(for number: Int) -> Image {
        if number > rating {
            offImage ?? onImage
        } else {
            onImage
        }
    }
}

#Preview {
    RatingView(rating: .constant(3), offImage: Image(systemName: "star"))
}
