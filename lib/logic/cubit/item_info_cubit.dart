import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'item_info_state.dart';

class ItemInfoCubit extends Cubit<ItemInfoState> {
  ItemInfoCubit()
      : super(ItemInfoState(productName: 'testname', productPrice: 123.0));

  void setItem(String itemName, double price) => emit(ItemInfoState(
        productName: itemName,
        productPrice: price,
      ));
}
