import 'package:webview_flutter/webview_flutter.dart';

extension WebViewControllerExtension on WebViewController {
  Future<void> setScrollListener(Function(double? position) onScroll) async {
    await runJavaScript('''
      window.addEventListener('scroll', function() {
        window.flutter_inappwebview.callHandler('onScroll', window.pageYOffset);
      });
    ''');

    addJavaScriptChannel(
      'onScroll',
      onMessageReceived: (JavaScriptMessage message) {
        final scrollPosition = double.tryParse(message.message);
        onScroll(scrollPosition);
      },
    );
  }
}
