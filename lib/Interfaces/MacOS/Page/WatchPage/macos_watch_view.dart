import 'package:flutter/cupertino.dart';
import 'package:macos_ui/macos_ui.dart';

import 'macos_watch_content_area.dart';
import 'macos_watch_siderbar.dart';

class MacOsWatchView extends StatelessWidget {
  const MacOsWatchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MacosWindow(
      sidebar: Sidebar(
          builder: (context, scrollController) {
            return WatchSideBar(scrollController: scrollController);
          },
          minWidth: 325),
      child: const WatchContentArea(),
    );
  }
}
