import SwiftUI
import WebKit

struct ContentView: View {
    var body: some View {
        GeometryReader { geometry in
            WebView(url: URL(string: "https://m.youtube.com")!)
                .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .ignoresSafeArea() // إجبار الشاشة على الامتلاء بالكامل
    }
}

struct WebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        let configuration = WKWebViewConfiguration()
        configuration.allowsInlineMediaPlayback = true
        configuration.mediaTypesRequiringUserActionForPlayback = []
        configuration.allowsPictureInPictureMediaPlayback = true // السماح بوضع الصورة في الصورة
        
        // 🚀 الخدعة البرمجية: حقن كود يمنع يوتيوب من معرفة أن التطبيق في الخلفية
        let jsTrick = """
        Object.defineProperty(document, 'hidden', {value: false, writable: false});
        Object.defineProperty(document, 'visibilityState', {value: 'visible', writable: false});
        window.addEventListener('visibilitychange', e => e.stopImmediatePropagation(), true);
        """
        let script = WKUserScript(source: jsTrick, injectionTime: .atDocumentStart, forMainFrameOnly: false)
        configuration.userContentController.addUserScript(script)
        
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.scrollView.contentInsetAdjustmentBehavior = .never
        // إجبار يوتيوب على عرض نسخة الهاتف بشكل متناسق مع حجم الشاشة
        webView.customUserAgent = "Mozilla/5.0 (iPhone; CPU iPhone OS 15_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.0 Mobile/15E148 Safari/604.1"
        
        webView.load(URLRequest(url: url))
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {}
}
