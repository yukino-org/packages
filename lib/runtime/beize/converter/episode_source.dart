import 'package:beize_vm/beize_vm.dart';
import 'package:tenka/tenka.dart';
import 'episode_stream.dart';
import 'episode_subtitle.dart';

class TenkaBeizeEpisodeSourceConvertable
    extends TenkaBeizeConvertable<EpisodeSource> {
  TenkaBeizeEpisodeSourceConvertable(super.converter);

  @override
  EpisodeSource convert(
    final BeizeCallFrame frame,
    final BeizeValue value,
  ) {
    final BeizePrimitiveObjectValue casted = value.cast();
    final BeizeValue streams =
        casted.getNamedProperty(TenkaBeizeConverter.kStreams);
    final BeizeValue subtitles =
        casted.getNamedProperty(TenkaBeizeConverter.kSubtitles);

    return EpisodeSource(
      streams: converter.episodeStream.convertMany(frame, streams),
      subtitles: converter.episodeSubtitle.convertMany(frame, subtitles),
    );
  }
}

extension TenkaBeizeEpisodeSourceConverter on TenkaBeizeConverter {
  TenkaBeizeEpisodeSourceConvertable get episodeSource =>
      TenkaBeizeEpisodeSourceConvertable(this);
}
