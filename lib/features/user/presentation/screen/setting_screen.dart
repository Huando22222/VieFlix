import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  late WebViewController _controller;
  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onNavigationRequest: (NavigationRequest request) {
          return NavigationDecision.navigate;
        },
      ))
      ..loadRequest(
        Uri.parse(
            'https://player.phimapi.com/player/?url=https://s2.phim1280.tv/20230907/S7BVCpM0/index.m3u8'),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Video Player')),
      body: SafeArea(
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: WebViewWidget(
            controller: _controller,
          ),
        ),
      ),
    );
  }
}
