//
//  DetailView.swift
//  TMDBMovie
//
//  Created by Ahmad Ilyas on 27/06/21.
//

import SwiftUI
import SwiftUIX


struct DetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var movie:MovieServices?
    @State var reviews:[Review]?
    @State var pages = 0
    @State var detailOverview:String
    @State var detailPoster:String
    var movieID:String?
    var movieTitle:String?
    
    var body: some View {
        ZStack{
            if let imageName = detailPoster, let imageUrl = ApiCall.imageHost + imageName {
                AsyncImage(url: URL(string: imageUrl)!,
                           placeholder: { Text("Loading ...") },
                           image: { Image(uiImage: $0).resizable() })
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .width(UIScreen.main.bounds.width)
                    .edgesIgnoringSafeArea(.all)
                    .scaledToFill()
            }
            VisualEffectBlurView(blurStyle: .dark){
                VStack(alignment:.leading, spacing: 0){
                    Spacer()
                        .frame(maxWidth: .infinity, maxHeight: 40)
                    Text(movieTitle!)
                        .font(.system(.largeTitle, design: .rounded))
                        .foregroundColor(.white)
                        .padding()
                        .onAppear()
                    if let imageName = detailPoster, let imageUrl = ApiCall.imageHost + imageName {
                        AsyncImage(url: URL(string: imageUrl)!,
                                   placeholder: { Text("Loading ...") },
                                   image: { Image(uiImage: $0).resizable() })
                            .frame(maxWidth: 150, maxHeight: 180)
                            .width(UIScreen.main.bounds.width)
                            .edgesIgnoringSafeArea(.all)
                            .scaledToFill()
                    }
                    Text(detailOverview)
                        .font(.system(.subheadline, design: .rounded))
                        .foregroundColor(.systemGray3)
                        .padding()
                    
                    if pages > 0 {
                        Text("\(String(pages)) Reviews:")
                            .font(.system(.subheadline, design: .rounded))
                            .foregroundColor(.systemGray3)
                            .padding()
                    }
                    
                    List {
                        
                        ForEach(0..<pages, id: \.hashValue) { index in
                            
                            if let review:Review = reviews![index] as Review {
                                let author:AuthorDetails = review.authorDetails! as  AuthorDetails
//                                LazyHStack{
//                                    if let imageName = author.posterPath, let imageUrl = ApiCall.imageHost + imageName {
//                                        AsyncImage(url: URL(string: imageUrl)!,
//                                                   placeholder: { Text("Loading ...") },
//                                                   image: { Image(uiImage: $0).resizable() })
//                                            .frame(idealHeight: 120) // 2:3 aspect ratio
//                                            .width(90)
//                                    }
//                                    LazyVStack(alignment:.leading, spacing: 0) {
//                                        Text(author.username!)
//                                            .font(.system(.headline, design: .rounded))
//                                            .foregroundColor(Color.white)
//                                            .frame(maxWidth: .infinity, alignment: .leading)
//                                            .padding(10)
//                                        LazyHStack(spacing: 0) {
//                                            Image(systemName: "star.fill")
//                                                .foregroundColor(.systemYellow)
//                                                .frame(idealHeight: 20)
//                                                .width(20)
//                                                .padding(2)
////                                            Text(String(revie.content!))
////                                                .font(.system(.subheadline))
////                                                .foregroundColor(Color.white)
////                                                .padding()
//                                        }.padding(5)
//                                        Spacer()
//                                    }.frame(width: UIScreen.main.bounds.width-120)
//                                    Spacer()
//                                }
                                let comment = String(review.content!).prefix(100)
                                let message = "\(review.author!) - \(comment)..."
                                Text(message)
                                    .font(.system(.subheadline, design: .rounded))
                                    .foregroundColor(.systemGray2)
                            }else{
                                Text("")
                            }
                                                            
                        }
                        .listRowBackground(Color.almostClear)
                    }
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
            .onAppear()
            
        }
        .navigationTitle("")
        .navigationBarHidden(false)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "arrow.left")
                .foregroundColor(.white)
        }))
        .onAppear {
            if self.movie == nil {
                ApiCall().fetchMovieDetail(movieID: movieID!) { (item) in
                    self.movie = item
                    self.detailOverview = item.overview!
                }
            }
            
            ApiCall().fetchMovieReviews(movieID: movieID!) { (item) in
                self.reviews = (item as ReviewServices).results
                self.pages = reviews!.count
            }
        }
    }
}



struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView( detailOverview: "", detailPoster: "", movieID: "", movieTitle: "")
    }
}
