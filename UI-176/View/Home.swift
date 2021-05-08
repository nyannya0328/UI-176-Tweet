//
//  Home.swift
//  UI-176
//
//  Created by にゃんにゃん丸 on 2021/05/08.
//

import SwiftUI

struct Home: View {
    @State var offset : CGFloat = 0
    @Environment(\.colorScheme) var scheme
    @State var selected = "Tweets"
    @Namespace var animation
    
    @State var tabBarOffset : CGFloat = 0
    
    @State var titleOffset : CGFloat = 0
    var body: some View {
        ScrollView(.vertical, showsIndicators: false, content: {
            VStack(spacing:15){
                
                GeometryReader{proxy ->AnyView in
                    
                    let minY = proxy.frame(in: .global).minY
                    
                    DispatchQueue.main.async {
                        self.offset = minY
                    }
                    
                    return AnyView(
                    
                        ZStack{
                            
                            Image(uiImage: #imageLiteral(resourceName: "p1"))
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: getRect().width, height: minY > 0 ? 180 + minY : 180)
                                .cornerRadius(0)
                            
                            
                            BlurView()
                                .opacity(BlurViewopcity())
                            
                            VStack(spacing:5){
                                
                                
                                Text("KING")
                                    .fontWeight(.bold)
                                
                                Text("199 Tweet")
                                    .font(.title2)
                                
                            }
                            .foregroundColor(.green)
                            .offset(y: 120)
                            .offset(y: titleOffset > 100 ? 0 : -getTitleoffset())
                            .opacity(titleOffset < 100 ? 1 : 0)
                            
                            
                            
                            
                            
                        }
                        .clipped()
                        .frame(height: minY  > 0 ? 180 + minY : nil)
                        .offset(y: minY > 0 ? -minY : -minY < 80 ? 0 : -minY - 80)
                      
                       
                    )
                    
                }
                .frame(height: 180)
                .zIndex(1)
                
                VStack{
                    
                    
                    HStack{
                        
                        Image(uiImage: #imageLiteral(resourceName: "logo"))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 60, height: 60)
                            .padding(8)
                            .background(scheme == .dark ? Color.black : Color.white)
                            .clipShape(Circle())
                            .offset(y: -offset < 0 ? getOffset() - 20 : -20)
                            .scaleEffect(getScale())
                        
                        Spacer()
                        
                        
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            Text("Edite Profile")
                                .foregroundColor(.blue)
                                .padding(.vertical,10)
                                .padding(.horizontal)
                                .background(
                                    Capsule()
                                        .stroke(Color.blue,lineWidth: 2)
                                
                                )
                            
                        })
                        
                    }
                    .padding(.top,-25)
                    .padding(.bottom, -10)
                    
                    
                    VStack(alignment: .leading, spacing: 8, content: {
                        Text("Pari")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                        
                        Text("@Pari")
                            .foregroundColor(.gray)
                        
                        Text("The lion is a species in the family Felidae and a member of the genus Panthera. It has a muscular, deep-chested body, short, rounded head, round ears, and a hairy tuft at the end of its tail. It is sexually dimorphic; adult male lions have a prominent mane.")
                        
                        HStack(spacing:8){
                            
                            Text("15")
                                .fontWeight(.semibold)
                                .foregroundColor(.primary)
                            
                            Text("Followers")
                              
                                .foregroundColor(.gray)
                                .padding(.leading,10)
                            
                            Text("17")
                                .fontWeight(.semibold)
                                .foregroundColor(.primary)
                                .padding(.leading,10)
                            
                            Text("Followings")
                               
                                .foregroundColor(.gray)
                            
                            
                            
                            
                            
                        }
                        
                        
                        
                    })
                    .overlay(
                    
                    
                        GeometryReader{reader -> Color in
                            
                            let minY = reader.frame(in: .global).minY
                            
                            DispatchQueue.main.async {
                                self.titleOffset = minY
                            }
                            
                            
                            return Color.clear
                            
                            
                        }
                        .frame(width: 0, height:0)
                        ,alignment: .top
                    )
                    
                    
                    VStack(spacing:0){
                        
                        
                        ScrollView(.horizontal, showsIndicators: false, content: {
                            
                            HStack(spacing:0){
                                
                                
                                
                                TabButton(title: "Tweets", selected: $selected, animation: animation)
                                
                                TabButton(title: "Tweets & Likes", selected: $selected, animation: animation)
                                
                                TabButton(title: "Media", selected: $selected, animation: animation)
                                
                                TabButton(title: "Likes", selected: $selected, animation: animation)
                            }
                            
                            
                        })
                        
                        Divider()
                        
                    }
                    .padding(.top,30)
                    .background(scheme == .dark ? Color.black : Color.white)
                    .offset(y: tabBarOffset < 90 ? -tabBarOffset + 90 : 0)
                    .overlay(
                        GeometryReader{reader -> Color in
                            
                            
                            let minY = reader.frame(in:.global).minY
                            
                            DispatchQueue.main.async {
                                self.tabBarOffset = minY
                            }
                            
                            return Color.clear
                            
                            
                            
                            
                        }
                        .frame(width: 0, height: 0)
                        ,alignment: .top
                    
                    
                    )
                    .zIndex(1)
                    
                    
                    VStack{
                        
     
                        
                        TweetView(tweet: "The beautifull Women. I got lucky 😄😄😄😄😄", tweetimage: "p2")
                        
                        Divider()
                        
                        ForEach(1...20,id:\.self){_ in
                            
                            TweetView(tweet: sampleText)
                            
                            Divider()
                                .foregroundColor(.primary)
                            
                        }
                      
                        
                    }
                    .padding(.top)
                    .zIndex(0)
                    
                    
                }
                .padding(.horizontal)
                .zIndex(-offset > 80 ? 0 : 1)
                
                
                
                
                
            }
        })
        .ignoresSafeArea(.all, edges: .top)
    }
    
    func getTitleoffset()->CGFloat{
        
        let progress = 20 / titleOffset
        
        let offset = 60 * (progress > 0 && progress <= 1 ? progress : 1)
        return offset
        
    }
    
    func getOffset()->CGFloat{
        let progress = (-offset / 80) * 20
        
        return progress <= 20 ? progress : 20
        
    }
    func getScale()->CGFloat{
        
        let progress = -offset / 80
        
        
        let scale = 1.8 - (progress < 1.0 ? progress : 1)
        
        return scale < 1 ? scale : 1
        
    }
    
    func BlurViewopcity()->Double{
        
        let progress = -(offset + 80) / 150
        
        return Double(-offset > 80 ? progress : 0)
        
        
    }
    
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
            .preferredColorScheme(.dark)
          
    }
}

extension View{
    
    func getRect()->CGRect{
        
        return UIScreen.main.bounds
    }
    
}

struct TabButton : View {
    
    var title : String
    @Binding var selected : String
    var animation : Namespace.ID
    var body: some View{
       
            
            
            Button(action: {
                
                withAnimation{
                    
                    selected = title
                }
                
            }, label: {
                LazyVStack{
                    
                    Text(title)
                        .fontWeight(.semibold)
                        .foregroundColor(selected == title ? .blue : .gray)
                        .padding(.horizontal)
                    
                    if selected == title{
                        
                        Capsule()
                            .fill(Color.blue)
                            .frame(height: 1.2)
                            .matchedGeometryEffect(id: "TAB", in: animation)
                        
                    }
                    else{
                        
                        
                        Capsule()
                            .fill(Color.clear)
                            .frame(height: 1.2)
                           
                    }
                }
                
            })
            
        
    }
}



struct TweetView: View {
    var tweet : String
    var tweetimage : String?
    var body: some View {
        HStack(alignment:.top){
            
            
            Image(uiImage: #imageLiteral(resourceName: "logo"))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 60, height: 60)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 10, content: {
                
                
                
                (
                    Text("Pari ")
                        +
                        Text("@king")
                    
                )
                
                Text(tweet)
                    .font(.caption)
                    .frame(maxHeight: 150, alignment: .top)
                
                if let image = tweetimage{
                    
                    GeometryReader{proxy in
                        
                        
                        Image(image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: proxy.frame(in: .global).width, height: 250)
                            .cornerRadius(15)
                        
                    }
                    .frame(height: 250)
                }
                
            })
            
            
            
            
            
        }
    }
}

var sampleText = "19世紀後半、建築技術の進歩や新素材の開発、産業革命による工業力の増加や総体としての富の増大によって、先進各国において相次いで高層建築が建設され、国家の威信をかけて高さ競争が繰り広げられていた。1647年から200年以上にわたって世界でもっとも高い建築物はフランス・ストラスブールのストラスブール大聖堂（高さ142m）であったが、1874年にはドイツ帝国・ハンブルクの聖ニコライ教会が147mとなってそれにとってかわり、それ以降、この地位は数年ごとに交代を繰り返すようになった。1876年にはフランス・ルーアンのルーアン大聖堂が151m、1880年にはドイツ・ケルンのケルン大聖堂が完成して157mとなった。ここまでの高さ競争はすべて教会の尖塔であったが、1884年にはアメリカのワシントンD.C.に高さ169mのワシントン記念塔が完成し、これが世界でもっとも高い建造物となっていた。しかしいずれの建造物も高さは140mから160m台に過ぎなかった。"
