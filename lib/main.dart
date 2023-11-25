import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Freedombook',
      home:   MyHomePage(),
    );
  }
}

// ignore: must_be_immutable
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  InAppWebViewController? _webViewController;
  String url = "";
  var progressUP = 0;

  Future delay() async {
    await Future.delayed( const Duration(seconds: 3), () {
      setState(() {
        progressUP = 100;
      });
    });
  }

  @override
  void initState() {
    delay();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    double wt = MediaQuery.of(context).size.width;
    double ht = MediaQuery.of(context).size.height;

    return progressUP == 100
        ? Container(
            color: Colors.white,
            height: ht,
            width: wt,
            child: InAppWebView(
              initialUrlRequest: URLRequest(
                  url: Uri.parse("https://freedombook.palestinegpt.net/")),
              initialOptions: InAppWebViewGroupOptions(
                  crossPlatform: InAppWebViewOptions(
                javaScriptEnabled: true,
                allowFileAccessFromFileURLs: true,
                allowUniversalAccessFromFileURLs: true,
                cacheEnabled: true,
                javaScriptCanOpenWindowsAutomatically: true,
              )),
              onWebViewCreated: (  controller) {
                _webViewController = controller;
              },
            ),
          )
        : Container(
            height: ht,
            width: wt,
            color: const Color.fromARGB(255, 255, 255, 255),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(width: 200, image: AssetImage("Assets/pLogo.png")),
                SizedBox(height: 20),
                CupertinoActivityIndicator(
                  radius: 15,
                  color: Color.fromARGB(255, 29, 76, 31),
                )
              ],
            ),
          );
  }
}
