import 'package:utilx/utils.dart';
import 'stream.dart';
import 'subtitle.dart';

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
  final List<EpisodeSubtitle> subtitles;

  JsonMap toJson() => <dynamic, dynamic>{
        'streams': streams.map((final EpisodeStream x) => x.toJson()).toList(),
        'subtitles':
            subtitles.map((final EpisodeSubtitle x) => x.toJson()).toList(),
      };
}
