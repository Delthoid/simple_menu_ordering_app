import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'cart_count_state.dart';

class CartCountCubit extends Cubit<CartCountState> {
  CartCountCubit() : super(CartCountState(count: 0));

  void addCartCount(int count) =>
      emit(CartCountState(count: state.count + count));
}
