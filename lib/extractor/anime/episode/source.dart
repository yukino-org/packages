import 'package:utilx/utils.dart';
import 'streams.dart';
import 'subtitles.dart';

class EpisodeSource {
  const EpisodeSource({
    required this.streams,
    required this.subtitles,
  });

  factory EpisodeSource.fromJson(final JsonMap json) => EpisodeSource(
        streams: castList(json['streams']),
        subtitles: castList(json['subtitles']),
      );

  final List<EpisodeStream> streams;
  final List<EpisodeSubtitles> subtitles;

  JsonMap toJson() => <dynamic, dynamic>{
        'streams': streams.map((final EpisodeStream x) => x.toJson()).toList(),
        'subtitles':
            subtitles.map((final EpisodeSubtitles x) => x.toJson()).toList(),
      };
}
