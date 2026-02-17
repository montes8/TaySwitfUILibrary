//
//  UILoading.swift
//  TaySwitfUILibrary
//
//  Created by Developer on 16/02/26.
//

import SwiftUI

public struct UILoading: View {
    @Environment(\.dismiss) var dismiss
    var nameGif : String = "loading_caja"
    var widthGif : CGFloat = 150
    var heightGif : CGFloat = 150
    var textLoad : String = uiEmpty
    var textColorLoad : Color = .uiGrey800
    var fontLoading : Font =  Font.uiMontM14
    var bgLoading : Color = Color.white.opacity(0.9)
    var marginTopText : CGFloat = 0
    
    public init(
        nameGif: String,
        widthGif: CGFloat = 150,
        heightGif: CGFloat = 150,
        textLoad:  String = uiEmpty,
        textColorLoad:  Color = .uiGrey800,
        fontLoading: Font = Font.uiMontM14,
        bgLoading: Color = Color.white.opacity(0.9),
        marginTopText: CGFloat = 0,
    ) {
        self.nameGif = nameGif
        self.widthGif = widthGif
        self.heightGif = heightGif
        self.textLoad = textLoad
        self.textColorLoad = textColorLoad
        self.bgLoading = bgLoading
        self.marginTopText = marginTopText
    }
    
    
    public var body: some View {
        ZStack {
            bgLoading
                .edgesIgnoringSafeArea(.all)
            VStack{
                if let gif = UIGifCache.shared.getGif(named: nameGif) {
                    UIGifInitView(animatedImage: gif)
                        .frame(width: widthGif, height: heightGif)
                }
                if(!textLoad.isEmpty){
                    Text(textLoad).font(fontLoading).padding(.top,marginTopText).foregroundColor(textColorLoad)
                }
            }
        }
    }
}


public class UIGifCache {
    @MainActor public static let shared = UIGifCache()
    private var cache = [String: UIImage]()
    
    private init() {}
    
    public func getGif(named name: String) -> UIImage? {
        if let cachedImage = cache[name] {
            return cachedImage
        }
        let image = UIGifCache.loadGif(named: name)
        cache[name] = image
        return image
    }
    
    private static func loadGif(named name: String) -> UIImage? {
        guard let path = Bundle.main.path(forResource: name, ofType: "gif"),
              let data = NSData(contentsOfFile: path) else { return nil }
        
        guard let source = CGImageSourceCreateWithData(data, nil) else { return nil }
        
        let count = CGImageSourceGetCount(source)
        var images = [UIImage]()
        var duration: Double = 0
        
        for i in 0 ..< count {
            guard let cgImage = CGImageSourceCreateImageAtIndex(source, i, nil) else { continue }
            images.append(UIImage(cgImage: cgImage))
            
            if let properties = CGImageSourceCopyPropertiesAtIndex(source, i, nil) as? [String: Any],
               let gifDict = properties[kCGImagePropertyGIFDictionary as String] as? [String: Any],
               let delay = gifDict[kCGImagePropertyGIFUnclampedDelayTime as String] as? Double ??
                gifDict[kCGImagePropertyGIFDelayTime as String] as? Double {
                duration += delay
            }
        }
        return UIImage.animatedImage(with: images, duration: duration)
    }
}

struct UIGifInitView: UIViewRepresentable {
    let animatedImage: UIImage
    
    func makeUIView(context: Context) -> UIView {
        let container = UIView()
        container.clipsToBounds = true
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = animatedImage
        container.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: container.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])
        
        return container
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}
