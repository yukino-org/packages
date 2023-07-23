import 'package:beize_vm/beize_vm.dart';
import 'package:tenka/tenka.dart';

class TenkaBeizeImageDescriberConvertable
    extends TenkaBeizeConvertable<ImageDescriber> {
  TenkaBeizeImageDescriberConvertable(super.converter);

  @override
  ImageDescriber convert(
    final BeizeCallFrame frame,
    final BeizeValue value,
  ) {
    final BeizePrimitiveObjectValue casted = value.cast();
    final BeizeStringValue url =
        casted.getNamedProperty(TenkaBeizeConverter.kUrl);
    final BeizePrimitiveObjectValue headers =
        casted.getNamedProperty(TenkaBeizeConverter.kHeaders);

    return ImageDescriber(
      url: url.value,
      headers: converter.headers.convert(frame, headers),
    );
  }
}

extension TenkaBeizeImageDescriberConverter on TenkaBeizeConverter {
  TenkaBeizeImageDescriberConvertable get imageDescriber =>
      TenkaBeizeImageDescriberConvertable(this);
}
