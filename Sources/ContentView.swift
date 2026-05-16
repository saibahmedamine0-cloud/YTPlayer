import SwiftUI
import WebKit

struct ContentView: View {
    var body: some View {
        // استخدام الطريقة الأبسط والأكثر ضماناً لملء الشاشة
        WebView(url: URL(string: "https://m.youtube.com")!)
            .edgesIgnoringSafeArea(.all) 
    }
}

struct WebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        // إعدادات المتصفح المدمج الأساسية والمستقرة
        let configuration = WKWebViewConfiguration()
        configuration.allowsInlineMediaPlayback = true // ضروري لتشغيل الفيديو داخل التطبيق
        configuration.mediaTypesRequiringUserActionForPlayback = [] // يسمح ببدء التشغيل بسهولة
        
        // تم إزالة أكواد الجافا سكريبت التي تسببت في عطل الفيديوهات
        
        let webView = WKWebView(frame: .zero, configuration: configuration)
        
        // منع ظهور الحواف البيضاء عند التمرير لضمان مظهر "ملء الشاشة"
        webView.scrollView.contentInsetAdjustmentBehavior = .never
        webView.isOpaque = false
        webView.backgroundColor = .black // خلفية سوداء لتبدو أفضل
        
        // تحديد هوية المتصفح كآيفون قياسي لضمان تحميل يوتيوب بشكل صحيح
        webView.customUserAgent = "Mozilla/5.0 (iPhone; CPU iPhone OS 16_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.0 Mobile/15E148 Safari/604.1"
        
        webView.load(URLRequest(url: url))
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {}
}
