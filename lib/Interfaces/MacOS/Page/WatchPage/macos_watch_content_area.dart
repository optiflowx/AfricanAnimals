import 'package:flutter/cupertino.dart';

class WatchContentArea extends StatelessWidget {
  const WatchContentArea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
          textAlign: TextAlign.center,
          'Video Player is currently unsupported on macOS.\nPlease try it on iOS/Android platform.'),
    );
  }
}
