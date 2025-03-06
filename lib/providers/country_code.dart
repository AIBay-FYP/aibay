import 'package:flutter_riverpod/flutter_riverpod.dart';

final countryCodeProvider = StateProvider<String>((ref) {
  return 'PK';
});
