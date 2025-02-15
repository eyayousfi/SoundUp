import '../../../core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';

import '../../../data/models/user/auth/create_user.dart';
import '../../../service_locator.dart';
import '../../repository/auth/auth.dart';

class SignupUseCase implements UseCase<Either,CreateUserReq> {


  @override
  Future<Either> call({CreateUserReq ? params}) async {
    return sl<AuthRepository>().signup(params!);
  }

}