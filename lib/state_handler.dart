import 'package:flutter/material.dart';
import 'package:state_handler/offline_game.dart';

enum ViewState { loading, content, error, networkError }

class StateHandler extends StatelessWidget {
  final ViewState state;
  final Widget content;
  final Widget? loadingWidget;
  final Widget? errorWidget;
  final Widget? networkErrorWidget;
  final VoidCallback? onRetry;

  const StateHandler({
    Key? key,
    required this.state,
    required this.content,
    this.loadingWidget,
    this.errorWidget,
    this.networkErrorWidget,
    this.onRetry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (state) {
      case ViewState.loading:
        return loadingWidget ??
            const Center(child: CircularProgressIndicator());
      case ViewState.error:
        return errorWidget ??
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("An error occurred"),
                  const SizedBox(height: 8),
                  if (onRetry != null)
                    ElevatedButton(
                      onPressed: onRetry,
                      child: const Text("Retry"),
                    ),
                ],
              ),
            );
      case ViewState.networkError:
        return networkErrorWidget ??
            Center(
              child: CustomPaint(painter: OfflineGame()),

              // child: Column(
              //   mainAxisSize: MainAxisSize.min,
              //   children: [
              //     const Text("No internet connection"),
              //     const SizedBox(height: 8),
              //     if (onRetry != null)
              //       ElevatedButton(
              //         onPressed: onRetry,
              //         child: const Text("Retry"),
              //       ),
              //   ],
              // ),
            );
      case ViewState.content:
        return content;
    }
  }
}
