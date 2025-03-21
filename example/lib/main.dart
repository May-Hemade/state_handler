import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:state_handler/state_handler.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ViewState _currentState = ViewState.loading;

  Future<bool> _isConnected() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  void _loadData() async {
    setState(() {
      _currentState = ViewState.loading;
    });

    bool isOnline = await _isConnected();

    if (!isOnline) {
      setState(() {
        _currentState = ViewState.networkError;
      });
      return;
    }

    Future.delayed(const Duration(seconds: 2), () {
      bool success = Random().nextBool();
      setState(() {
        _currentState = success ? ViewState.content : ViewState.error;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("State Handler Example")),
        body: StateHandler(
          state: _currentState,
          content: const Center(
            child: Text(
              "🎉 Content Loaded Successfully!",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          errorWidget: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error, size: 50, color: Colors.red),
                const SizedBox(height: 10),
                const Text(
                  "Oops! Something went wrong.",
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _loadData,
                  child: const Text("Retry"),
                ),
              ],
            ),
          ),
          networkErrorWidget: Center(
            child: Column(
              children: [
                const Icon(Icons.error, size: 50, color: Colors.red),
                const SizedBox(height: 10),
                const Text(
                  "Please check your network connection",
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _loadData,
                  child: const Text("Retry"),
                ),
              ],
            ),
          ),
          onRetry: _loadData,
        ),
      ),
    );
  }
}
