import 'package:africa/Model/videos_model.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerView extends StatelessWidget {
  final List<Video> item;
  final int index;
  const VideoPlayerView({Key? key, required this.index, required this.item})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final videoPlayerController =
        VideoPlayerController.asset(item[index].video!);
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: 'Videos',
        middle: Text('${item[index].name}'),
      ),
      child: Stack(
        children: [
          const Align(), //Logo
          const Align(), //
          const Align(), //Controllers and seekbar
          FlickVideoPlayer(
            flickManager: FlickManager(
              videoPlayerController: videoPlayerController,
              onVideoEnd: () {
                // videoPlayerController.
                // Get.to(() => const WatchTabView());
              },
            ),
          ),
        ],
      ),
    );
  }
}
