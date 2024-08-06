import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FillterNotifier extends StateNotifier<Map<Filter, bool>> {
  FillterNotifier()
      : super({
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegetarian: false,
          Filter.vegan: false,
        });

        void setFilter(Filter filter,bool isActive){
          state = {
            ...state,
            filter: isActive
          };
        }
}

final filtersProvider = StateNotifierProvider<FillterNotifier,Map<Filter,bool>>(
  (ref) {
    return FillterNotifier();
  },
);
