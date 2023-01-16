import 'package:fubuki_vm/fubuki_vm.dart';
import 'package:tenka/tenka.dart';

class TenkaFubukiImageDescriberConvertable
    extends TenkaFubukiConvertable<ImageDescriber> {
  TenkaFubukiImageDescriberConvertable(super.converter);

  @override
  ImageDescriber convert(
    final FubukiCallFrame frame,
    final FubukiValue value,
  ) {
    final FubukiPrimitiveObjectValue casted = value.cast();
    final FubukiStringValue url =
        casted.getNamedProperty(TenkaFubukiConverter.kUrl);
    final FubukiPrimitiveObjectValue headers =
        casted.getNamedProperty(TenkaFubukiConverter.kHeaders);

    return ImageDescriber(
      url: url.value,
      headers: converter.headers.convert(frame, headers),
    );
  }
}

extension TenkaFubukiImageDescriberConverter on TenkaFubukiConverter {
  TenkaFubukiImageDescriberConvertable get imageDescriber =>
      TenkaFubukiImageDescriberConvertable(this);
}
