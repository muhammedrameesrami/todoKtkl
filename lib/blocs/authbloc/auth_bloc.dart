import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/blocs/comonCubit/currentuser_cubit.dart';

import '../../controller/authController.dart';
import '../../models/userModel.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthController _authController;
  AuthBloc({required AuthController controller}) : _authController=controller,
        super(AuthInitial()) {
    on<loginEvent>(loginbloc);
  }

  Future<void>loginbloc(loginEvent event,Emitter <AuthState> emit)async{
    emit(AuthLoading());
    try{
      final res=await _authController.login(email: event.email, password: event.password);
      res.fold((l) => emit(AuthFailure(error: l.message)), (r)  {
        return emit(AuthSuccess(model: r));
      },);
    }catch (e){
      return emit(AuthFailure(error: e.toString()));
    }
}
}
