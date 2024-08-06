import 'package:flutter_riverpod/flutter_riverpod.dart';

class IconStateNotifier extends StateNotifier<bool> {
  IconStateNotifier() : super(true);

  void toggle() {
    state = !state;
  }
}

final iconStateProvider = StateNotifierProvider<IconStateNotifier, bool>((ref) {
  return IconStateNotifier();
});
