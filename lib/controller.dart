import 'package:get/get.dart';
import 'package:yaren_codeway/model.dart';
import 'package:video_player/video_player.dart';

class Controller extends GetxController {
  final stopwatch = Stopwatch();

  var stories = [
    [
      Story(
          "yaren07","https://source.unsplash.com/random/800x800/?img=1",StoryType.image, "https://source.unsplash.com/random/800x800/?img=2", 5 * 1000)
    ],
    [
      Story(
          "ayse","https://source.unsplash.com/random/800x800/?img=3",StoryType.image, "https://source.unsplash.com/random/800x800/?img=4", 5 * 1000),
      Story(
          "ayse","https://source.unsplash.com/random/800x800/?img=3",StoryType.image, "https://source.unsplash.com/random/800x800/?img=5", 5 * 1000)
    ],
    [
      Story(
          "ece","https://source.unsplash.com/random/800x800/?img=6",StoryType.image, "https://source.unsplash.com/random/800x800/?img=16", 5 * 1000),
      Story(
          "ece","https://source.unsplash.com/random/800x800/?img=6",StoryType.video,
          "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
          5 * 1000,
          VideoPlayerController.network(
              'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')),
      Story(
          "ece","https://source.unsplash.com/random/800x800/?img=6",StoryType.image, "https://source.unsplash.com/random/800x800/?img=14", 5 * 1000),
      Story(
          "ece","https://source.unsplash.com/random/800x800/?img=6",StoryType.image, "https://source.unsplash.com/random/800x800/?img=9", 5 * 1000)
    ],
    [
      Story(
          "mustafa","https://source.unsplash.com/random/800x800/?img=7",StoryType.video,
          "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
          5 * 1000,
          VideoPlayerController.network(
              'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'))
    ],
    [
      Story(
          "sevda","https://source.unsplash.com/random/800x800/?img=8",StoryType.image,
          "https://source.unsplash.com/random/800x800/?img=15",
          5 * 1000)
    ],
  ].obs;
  var currentStoryGroupId = 0.obs;
  var currentState = {
    "currentStoryId": 0,
    "currentTime": 0,
    "isPlaying": false,
  }.obs;

  var visitedStoriesIds = List.filled(5, 0).obs;

  stop() {
    if ((currentState["isPlaying"]! as bool) &&
        stories[currentStoryGroupId.value]
        [currentState["currentStoryId"] as int]
            .videoController !=
            null &&
        stories[currentStoryGroupId.value]
        [currentState["currentStoryId"] as int]
            .videoController!
            .value
            .isPlaying) {
      stories[currentStoryGroupId.value][currentState["currentStoryId"] as int]
          .videoController!
          .pause();
    }
    currentState["isPlaying"] = false;
    stopwatch.stop();
  }

  start([bool? notResetVideo]) {
    if (!(currentState["isPlaying"]! as bool) &&
        stories[currentStoryGroupId.value]
        [currentState["currentStoryId"] as int]
            .videoController !=
            null &&
        !stories[currentStoryGroupId.value]
        [currentState["currentStoryId"] as int]
            .videoController!
            .value
            .isPlaying) {
      if (notResetVideo == null)
        stories[currentStoryGroupId.value]
        [currentState["currentStoryId"] as int]
            .videoController!
            .seekTo(Duration.zero);
      stories[currentStoryGroupId.value][currentState["currentStoryId"] as int]
          .videoController!
          .play();
    }
    currentState["isPlaying"] = true;
    stopwatch.start();
  }

  leftTap() {
    if (currentState["currentStoryId"] == 0) {
      if (currentStoryGroupId.value == 0) {
        return false;
      } else {
        currentStoryGroupId.value = currentStoryGroupId.value - 1;
        currentState["currentStoryId"] =
            stories[currentStoryGroupId.value].length - 1;
        visitedStoriesIds[currentStoryGroupId.value] =
        currentState["currentStoryId"]! as int;
        stopwatch.reset();
        return true;
      }
    } else {
      currentState["currentStoryId"] =
          (currentState["currentStoryId"]! as int) - 1;
    }
    visitedStoriesIds[currentStoryGroupId.value] =
    currentState["currentStoryId"]! as int;
    stopwatch.reset();
    return false;
  }

  rightTap() {
    if (currentState["currentStoryId"] ==
        stories[currentStoryGroupId.value].length - 1) {
      if (currentStoryGroupId.value == stories.length - 1) {
        return false;
      } else {
        currentStoryGroupId.value = (currentStoryGroupId.value) + 1;
        currentState["currentStoryId"] = 0;
        visitedStoriesIds[currentStoryGroupId.value] =
        currentState["currentStoryId"]! as int;
        stopwatch.reset();
        return true;
      }
    } else {
      currentState["currentStoryId"] =
          (currentState["currentStoryId"]! as int) + 1;
    }
    visitedStoriesIds[currentStoryGroupId.value] =
    currentState["currentStoryId"]! as int;
    stopwatch.reset();
    return false;
  }

  leftSwipe() {
    if (currentStoryGroupId.value == 0) {
      return;
    } else {
      currentStoryGroupId.value = (currentStoryGroupId.value) - 1;
      currentState["currentStoryId"] =
      visitedStoriesIds[currentStoryGroupId.value];
    }
    stopwatch.reset();
  }

  rightSwipe() {
    if (currentStoryGroupId.value == stories.length - 1) {
      return;
    } else {
      currentStoryGroupId.value = (currentStoryGroupId.value) + 1;
      currentState["currentStoryId"] =
      visitedStoriesIds[currentStoryGroupId.value];
    }
    stopwatch.reset();
  }
}