import 'package:video_player/video_player.dart';

class UserModel {
  UserModel(
      this.stories, {
        required this.userName,
        required this.profilePhoto,
      });

  final List<Story> stories;
  final String userName;
  final String profilePhoto;
}
class Story {
  final String userName;
  final String profilePhoto;
  final StoryType type;
  final String url;
  int duration;
  VideoPlayerController? videoController;

  Story(this.userName, this.profilePhoto, this.type, this.url, this.duration, [this.videoController]);
}

enum StoryType {
  image,
  video,
}