import SwiftUI
struct CardView: View {
    var business: Business?
    var fetchedData :Place?
    
    var body: some View {
        VStack{
            HStack {
                // Image
                AsyncImage(url: business?.formattedImageUrl) { image in
                    image.resizable()
                } placeholder: {
                    Color.gray
                }
                .frame(width: 110, height: 110)
                .cornerRadius(10)
                .padding(4)

                // Labels
                VStack(alignment: .leading, spacing: 4) {
                    Text((business == nil ? fetchedData?.name ?? "no name" : business?.formattedName ) ?? "no names")
                    Text((business == nil ? fetchedData?.title ?? "no alias" : business?.formattedCategory ) ?? "no title")
                    HStack {
                        Text((business == nil ? String(fetchedData?.rating ?? 0.0) : business?.formattedRating  ) ?? "0.0")
                        Image(systemName:"star")
                    }
                }
                Spacer()
            }
           
        }
    }
}
