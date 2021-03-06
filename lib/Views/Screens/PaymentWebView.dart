import 'dart:io';
import 'package:TrainnigInfo/ApiProvider/ApiProvider.dart';
import 'package:TrainnigInfo/Views/Utilities/AppRoutes.dart';
import 'package:TrainnigInfo/Views/Utilities/AppUrl.dart';
import 'package:TrainnigInfo/Views/Widget/WebAppbar.dart';
import 'package:TrainnigInfo/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class PaymentWebView extends StatefulWidget {
  PaymentWebView({Key key}) : super(key: key);

  @override
  _PaymentWebViewState createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {
  InAppWebViewController _webViewController;
  double progress = 0;

  var amount = Get.arguments[0];
  var pId = Get.arguments[1];
  var uId = Get.arguments[2];
  var duration = Get.arguments[3];

  Future<void> _onRefresh() async {
    if (_webViewController != null) {
      _webViewController.reload();
    }
    await Future.delayed(Duration(milliseconds: 1000));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_webViewController != null) {
          _webViewController.canGoBack().then(
            (value) {
              if (value) {
                _webViewController.goBack();
              } else {
                Get.back();
              }
            },
          );
        }
      },
      child: SafeArea(
        child: Scaffold(
          appBar: webAppbar("Subscription", _webViewController),
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.001, 0.6],
                colors: [Colors.black, Colors.grey[50]],
              ),
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(2.0),
                  child: progress < 1.0
                      ? LinearProgressIndicator(
                          value: progress,
                        )
                      : Container(),
                ),
                Expanded(
                  child: Container(
                    child: InAppWebView(
                      //initialHeaders: MyApiClient.header2(),
                      initialUrl: AppUrl.subscriptionUrl +
                          "?amount=${amount.toString()}&auth_id=${uId.toString()}&package_id=${pId.toString()}&duration=${duration.toString()}",
                      initialOptions: InAppWebViewGroupOptions(
                        crossPlatform: InAppWebViewOptions(
                            debuggingEnabled: true,
                            javaScriptCanOpenWindowsAutomatically: true,
                            useShouldOverrideUrlLoading: true),
                        android: AndroidInAppWebViewOptions(
                            supportMultipleWindows: true),
                      ),
                      onWebViewCreated: (InAppWebViewController controller) {
                        _webViewController = controller;
                      },
                      onLoadStart:
                          (InAppWebViewController controller, String url) {
                        _webViewController.getOptions().then(
                          (value) {
                            value.crossPlatform.useShouldInterceptAjaxRequest =
                                true;
                            value.crossPlatform
                                .javaScriptCanOpenWindowsAutomatically = true;
                            value.crossPlatform.debuggingEnabled = true;
                          },
                        );
                        print("onLoadStart" + url);
                        // if(url.contains("https://work.mshakhawat.com/"))
                        // {
                        //   Get.offAndToNamed(AppRoutes.USERHOMEPAGE);
                        // }
                      },
                      androidOnPermissionRequest:
                          (controller, origin, resources) async {
                        return PermissionRequestResponse(
                            resources: resources,
                            action: PermissionRequestResponseAction.GRANT);
                      },
                      onLoadStop: (InAppWebViewController controller,
                          String url) async {
                        print("onLoadStop" + url);
                        _webViewController
                            .getUrl()
                            .then((value) => print(value));
                        _webViewController.getOptions().then(
                          (value) {
                            value.crossPlatform.useShouldInterceptAjaxRequest =
                                true;
                            value.crossPlatform
                                .javaScriptCanOpenWindowsAutomatically = true;
                            value.crossPlatform.debuggingEnabled = true;
                          },
                        );
                        if (url == "https://work.mshakhawat.com/") {
                          print("Working");
                          userprefs.setBool("isNewCheck", false);
                          Get.offAndToNamed(AppRoutes.USERHOMEPAGE);
                        }
                      },
                      shouldOverrideUrlLoading:
                          (controller, shouldOverrideUrlLoadingRequest) async {
                        print("URL: ${shouldOverrideUrlLoadingRequest.url}");

                        if (Platform.isAndroid ||
                            shouldOverrideUrlLoadingRequest
                                    .iosWKNavigationType ==
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
                      onProgressChanged:
                          (InAppWebViewController controller, int progress) {
                        setState(
                          () {
                            this.progress = progress / 100;
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
