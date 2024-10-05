import 'package:bloc/bloc.dart';
import 'package:todoapp/models/userModel.dart';


class CurrentuserCubit extends Cubit<UserModel?> {
  CurrentuserCubit() : super(null);

  void updateUser({required UserModel usermodel}){
    emit(usermodel);
  }
}
