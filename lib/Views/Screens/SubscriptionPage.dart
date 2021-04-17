import 'package:flutter/material.dart';

class SubscriptionPage extends StatefulWidget {
  SubscriptionPage({Key key}) : super(key: key);

  @override
  _SubscriptionPageState createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(child: Text("Subscription Page")),
      ),
    );
  }
}
