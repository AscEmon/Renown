import 'dart:io';
import 'package:TrainnigInfo/ApiProvider/ApiProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';




class PaymentWebView extends StatefulWidget {
  PaymentWebView({Key key}) : super(key: key);

  @override
  _PaymentWebViewState createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {
  InAppWebViewController _webViewController;
  double progress = 0;

  Future<void> _onRefresh() async {
    if (_webViewController != null) {
      _webViewController.reload();
    }
    await Future.delayed(Duration(milliseconds: 1000));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: InAppWebView(
          initialHeaders: MyApiClient.header2(),
          // initialUrl: AppUrl.buyCreditUrl,
          initialOptions: InAppWebViewGroupOptions(
            crossPlatform: InAppWebViewOptions(
                debuggingEnabled: true,
                javaScriptCanOpenWindowsAutomatically: true,
                useShouldOverrideUrlLoading: true),
            android: AndroidInAppWebViewOptions(supportMultipleWindows: true),
          ),
          onWebViewCreated: (InAppWebViewController controller) {
            _webViewController = controller;
          },
          onLoadStart: (InAppWebViewController controller, String url) {
            _webViewController.getOptions().then(
              (value) {
                value.crossPlatform.useShouldInterceptAjaxRequest = true;
                value.crossPlatform.javaScriptCanOpenWindowsAutomatically =
                    true;
                value.crossPlatform.debuggingEnabled = true;
              },
            );
            print("onLoadStart" + url);
          },
          androidOnPermissionRequest: (controller, origin, resources) async {
            return PermissionRequestResponse(
                resources: resources,
                action: PermissionRequestResponseAction.GRANT);
          },
          onLoadStop: (InAppWebViewController controller, String url) async {
            print("onLoadStop" + url);
            _webViewController.getUrl().then((value) => print(value));
            _webViewController.getOptions().then(
              (value) {
                value.crossPlatform.useShouldInterceptAjaxRequest = true;
                value.crossPlatform.javaScriptCanOpenWindowsAutomatically =
                    true;
                value.crossPlatform.debuggingEnabled = true;
              },
            );
          },
          shouldOverrideUrlLoading:
              (controller, shouldOverrideUrlLoadingRequest) async {
            print("URL: ${shouldOverrideUrlLoadingRequest.url}");

            if (Platform.isAndroid ||
                shouldOverrideUrlLoadingRequest.iosWKNavigationType ==
                    IOSWKNavigationType.LINK_ACTIVATED) {
              controller.loadUrl(
                  url: shouldOverrideUrlLoadingRequest.url,
                  headers: MyApiClient.header2());
              return ShouldOverrideUrlLoadingAction.CANCEL;
            }
            return ShouldOverrideUrlLoadingAction.ALLOW;
          },
          onConsoleMessage: (InAppWebViewController controller,
              ConsoleMessage consoleMessage) {
            print("console message: ${consoleMessage.message}");
          },
          onProgressChanged: (InAppWebViewController controller, int progress) {
            setState(
              () {
                this.progress = progress / 100;
              },
            );
          },
        ),
      ),
    );
  }
}
