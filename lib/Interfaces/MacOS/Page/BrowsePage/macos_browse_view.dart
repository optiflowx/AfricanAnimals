import 'package:africa/Interfaces/MacOS/Page/BrowsePage/browse_content_area.dart';
import 'package:africa/Interfaces/MacOS/Page/BrowsePage/browse_sidebar.dart';
import 'package:flutter/cupertino.dart';
import 'package:macos_ui/macos_ui.dart';

class MacOSBrowseView extends StatelessWidget {
  const MacOSBrowseView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MacosWindow(
      sidebar: Sidebar(
          builder: (context, scrollController) {
            return BrowseSideBar(scrollController: scrollController);
          },
          minWidth: 350),
      child: const BrowseContentArea(),
    );
  }
}
