import 'package:bloc/bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({String? initialMessage}) : super(HomeInitial());
  String? initialMessage;

  void init(String? initialMessage) {
    this.initialMessage = initialMessage;
    emit(HomeInitial(message: initialMessage));
  }
}
