import 'package:baize_vm/baize_vm.dart';
import 'package:tenka/tenka.dart';
import 'episode_stream.dart';
import 'episode_subtitle.dart';

class TenkaBaizeEpisodeSourceConvertable
    extends TenkaBaizeConvertable<EpisodeSource> {
  TenkaBaizeEpisodeSourceConvertable(super.converter);

  @override
  EpisodeSource convert(
    final BaizeCallFrame frame,
    final BaizeValue value,
  ) {
    final BaizePrimitiveObjectValue casted = value.cast();
    final BaizeValue streams =
        casted.getNamedProperty(TenkaBaizeConverter.kStreams);
    final BaizeValue subtitles =
        casted.getNamedProperty(TenkaBaizeConverter.kSubtitles);

    return EpisodeSource(
      streams: converter.episodeStream.convertMany(frame, streams),
      subtitles: converter.episodeSubtitle.convertMany(frame, subtitles),
    );
  }
}

extension TenkaBaizeEpisodeSourceConverter on TenkaBaizeConverter {
  TenkaBaizeEpisodeSourceConvertable get episodeSource =>
      TenkaBaizeEpisodeSourceConvertable(this);
}
