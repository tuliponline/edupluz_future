import 'package:edupluz_future/core/models/courses/create_order_200_response.dart';
import 'package:edupluz_future/core/providers/user/user_provider.dart';
import 'package:edupluz_future/core/widgets/dialogs/info_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:logger/logger.dart';
import 'package:flutter/foundation.dart';

class PaymentScreen extends ConsumerStatefulWidget {
  final CreateOrder200Response order;
  final Function(bool success) onPaymentComplete;

  const PaymentScreen({
    super.key,
    required this.order,
    required this.onPaymentComplete,
  });

  @override
  ConsumerState<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends ConsumerState<PaymentScreen> {
  late final WebViewController _controller;
  final _logger = Logger();
  bool _hasSubmittedForm = false;
  String? paymentHtml;

  void _initHtml() {
    final userEmail = ref.watch(userProvider)?.data.email;
    paymentHtml = '''
 <html>
  <head>
    <title>EPAYLINK Testing</title>
    <style>
      input[type="submit"] { display: none; }
    </style>
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <form method="post" action="${widget.order.data.merchantUrl}">
    <input type="hidden" name="returnurl" value="${dotenv.env['PAY_SOLUTION_RETURN_URL']}">
      <input type="hidden" name="refno" value="${widget.order.data.referenceNo}" />
      <input type="hidden" name="merchantid" value="${widget.order.data.merchantId}" />
      <input type="hidden" name="customeremail" value="$userEmail" />
      <input type="hidden" name="channel" value="full" />
      <input type="hidden" name="cc" value="00" />
      <input type="hidden" name="productdetail" value="${widget.order.data.productName}" />
      <input type="hidden" name="total" value="${widget.order.data.price}" />
      <input type="submit" name="Submit" value="Confirm Order" />
    </form>
  </body>
</html>
    ''';
  }

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) {
            // Log the URL being navigated to
            _logger.d('Navigation request to: ${request.url}');

            // Handle return URL and payment status
            if (request.url
                .startsWith(dotenv.env['PAY_SOLUTION_RETURN_URL'] ?? '')) {
              final success = _parsePaymentResult(request.url);
              _logger.i('Payment result: $success');
              widget.onPaymentComplete(success);
              Navigator.of(context).pop();
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
          onPageStarted: (String url) {
            _logger.d('Page started loading: $url');
          },
          onPageFinished: (String url) {
            _logger.d('Page finished loading: $url');
            // Auto-submit form when page is loaded
            if (!_hasSubmittedForm) {
              _submitForm();
              _hasSubmittedForm = true;
            }
          },
          onWebResourceError: (WebResourceError error) {
            _logger.e('Web resource error: ${error.description}');
          },
        ),
      );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initHtml();
    _controller.loadHtmlString(paymentHtml!);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _submitForm() async {
    await _controller.runJavaScript('''
      const form = document.forms[0];
      if(form) {
        form.submit();
      }
    ''');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ชำระเงิน'),
      ),
      body: Column(
        children: [
          Expanded(
            child: WebViewWidget(controller: _controller),
          ),
        ],
      ),
      floatingActionButton: kDebugMode
          ? Row(
              children: [
                FloatingActionButton.extended(
                  onPressed: () async {
                    await showDialog(
                        context: context,
                        builder: (context) {
                          return InfoDialog(
                            testCenter: true,
                            callback: (value) {
                              Navigator.pop(context);
                            },
                            icon: Icons.check,
                            title: "ชำระเงินสำเร็จ",
                            detail: "ตอนนี้คุณสามารถเข้าดูคอร์สเรียนได้เลย",
                          );
                        });
                    widget.onPaymentComplete(true);
                    Navigator.of(context).pop();
                  },
                  label: const Text("Simulate Success"),
                  icon: const Icon(Icons.check),
                  tooltip: 'Simulate Success',
                ),
                const SizedBox(width: 10),
                FloatingActionButton.extended(
                  onPressed: () async {
                    await showDialog(
                        context: context,
                        builder: (context) {
                          return InfoDialog(
                            testCenter: true,
                            callback: (value) {
                              Navigator.pop(context);
                            },
                            icon: Icons.error,
                            title: "ชำระเงินล้มเหลว",
                            detail: "กรุณาลองใหม่อีกครั้ง",
                          );
                        });
                    widget.onPaymentComplete(false);
                    Navigator.of(context).pop();
                  },
                  label: const Text("Simulate Failed"),
                  icon: const Icon(Icons.error),
                  tooltip: 'Simulate Failed',
                ),
              ],
            )
          : null,
    );
  }

  bool _parsePaymentResult(String url) {
    // Parse URL parameters to check payment status
    _logger.d('Payment result URL: $url');
    // final uri = Uri.parse(url);
    // final status = uri.queryParameters['Status'];
    // _logger.d('Payment result Status: $status');
    // return status?.toUpperCase() == 'CP'; // CP means Complete
    return true;
  }
}
