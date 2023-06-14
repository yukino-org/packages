import 'package:baize_vm/baize_vm.dart';
import 'package:tenka/tenka.dart';

class TenkaBaizeImageDescriberConvertable
    extends TenkaBaizeConvertable<ImageDescriber> {
  TenkaBaizeImageDescriberConvertable(super.converter);

  @override
  ImageDescriber convert(
    final BaizeCallFrame frame,
    final BaizeValue value,
  ) {
    final BaizePrimitiveObjectValue casted = value.cast();
    final BaizeStringValue url =
        casted.getNamedProperty(TenkaBaizeConverter.kUrl);
    final BaizePrimitiveObjectValue headers =
        casted.getNamedProperty(TenkaBaizeConverter.kHeaders);

    return ImageDescriber(
      url: url.value,
      headers: converter.headers.convert(frame, headers),
    );
  }
}

extension TenkaBaizeImageDescriberConverter on TenkaBaizeConverter {
  TenkaBaizeImageDescriberConvertable get imageDescriber =>
      TenkaBaizeImageDescriberConvertable(this);
}
