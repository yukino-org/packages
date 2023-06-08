import 'package:fubuki_vm/fubuki_vm.dart';
import 'package:tenka/tenka.dart';
import 'episode_stream.dart';
import 'episode_subtitle.dart';

class TenkaFubukiEpisodeSourceConvertable
    extends TenkaFubukiConvertable<EpisodeSource> {
  TenkaFubukiEpisodeSourceConvertable(super.converter);

  @override
  EpisodeSource convert(
    final FubukiCallFrame frame,
    final FubukiValue value,
  ) {
    final FubukiPrimitiveObjectValue casted = value.cast();
    final FubukiValue streams =
        casted.getNamedProperty(TenkaFubukiConverter.kStreams);
    final FubukiValue subtitles =
        casted.getNamedProperty(TenkaFubukiConverter.kSubtitles);

    return EpisodeSource(
      streams: converter.episodeStream.convertMany(frame, streams),
      subtitles: converter.episodeSubtitle.convertMany(frame, subtitles),
    );
  }
}

extension TenkaFubukiEpisodeSourceConverter on TenkaFubukiConverter {
  TenkaFubukiEpisodeSourceConvertable get episodeSource =>
      TenkaFubukiEpisodeSourceConvertable(this);
}
