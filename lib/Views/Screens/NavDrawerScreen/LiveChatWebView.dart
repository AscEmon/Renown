import 'dart:async';
import 'dart:io';
import 'package:TrainnigInfo/ApiProvider/ApiProvider.dart';
import 'package:TrainnigInfo/Views/Utilities/AppUrl.dart';
import 'package:TrainnigInfo/Views/Widget/WebAppbar.dart';
import 'package:TrainnigInfo/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class LiveChatWebView extends StatefulWidget {
  LiveChatWebView({Key key}) : super(key: key);

  @override
  _LiveChatWebViewState createState() => _LiveChatWebViewState();
}

class _LiveChatWebViewState extends State<LiveChatWebView> {
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
          appBar: webAppbar("Live Chat", _webViewController),
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
                      initialUrl: AppUrl.liveChatUserUrl +
                          "?user_id=${userMap['data']['id']}",
                      initialOptions: InAppWebViewGroupOptions(
                        crossPlatform: InAppWebViewOptions(
                            useOnDownloadStart: true,
                            mediaPlaybackRequiresUserGesture: true,
                            cacheEnabled: false,
                            debuggingEnabled: true,
                            useShouldInterceptAjaxRequest: true,
                            useShouldInterceptFetchRequest: true,
                            useOnLoadResource: true,
                            javaScriptEnabled: true,
                            disableContextMenu: true,
                            javaScriptCanOpenWindowsAutomatically: true,
                            disableHorizontalScroll: false,
                            useShouldOverrideUrlLoading: true),
                        android: AndroidInAppWebViewOptions(
                            useOnRenderProcessGone: true,
                            useShouldInterceptRequest: true,
                            needInitialFocus: true,
                            networkAvailable: true,
                            clearSessionCache: true,
                            supportMultipleWindows: true),
                      ),
                      // onWebViewCreated: (InAppWebViewController controller) {
                      //   _webViewController = controller;
                      //   _webViewController.addJavaScriptHandler(
                      //       handlerName: 'handlerFoo',
                      //       callback: (args) {
                      //         // return data to JavaScript side!
                      //         return {'bar': 'bar_value', 'baz': 'baz_value'};
                      //       });

                      //   _webViewController.addJavaScriptHandler(
                      //       handlerName: 'handlerFooWithArgs',
                      //       callback: (args) {
                      //         print(args);
                      //         // it will print: [1, true, [bar, 5], {foo: baz}, {bar: bar_value, baz: baz_value}]
                      //       });

                      // },
                      onWebViewCreated: (InAppWebViewController controller) {
                        _webViewController = controller;

                        _webViewController.addJavaScriptHandler(
                            handlerName: 'testFunc',
                            callback: (args) {
                              print(args);
                            });

                        _webViewController.addJavaScriptHandler(
                            handlerName: 'testFuncArgs',
                            callback: (args) {
                              print(args);
                            });

                        _webViewController.addJavaScriptHandler(
                            handlerName: 'testFuncReturn',
                            callback: (args) {
                              print(args);
                              return '2';
                            });
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
                        // Timer.periodic(
                        //   Duration(seconds: 10),
                        //   (Timer timer) async {
                        //     await controller.reload();
                        //   },
                        // );

                        // var webMessageChannel = await controller.getMetaTags();
                        // var port1 = webMessageChannel
                        // var port2 = webMessageChannel.port2;

                        // // set the web message callback for the port1
                        // await port1.setWebMessageCallback((message) async {
                        //   print("Message coming from the JavaScript side: $message");
                        //   // when it receives a message from the JavaScript side, respond back with another message.
                        //  // await port1.postMessage(WebMessage(data: message! + " and back"));
                        // });
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
