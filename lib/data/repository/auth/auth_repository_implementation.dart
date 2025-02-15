
import 'package:dartz/dartz.dart';
import 'package:sptify/data/sources/auth/auth_firebase_service.dart';

import '../../../domain/repository/auth/auth.dart';
import '../../../service_locator.dart';
import '../../models/user/auth/create_user.dart';
import '../../models/user/auth/signin_user_req.dart';

class AuthRepositoryImpl extends AuthRepository{
  @override
  Future<Either> signin(SigninUserReq signinUserReq) async {
    return await sl<AuthFirebaseService>().signin(signinUserReq);
  }

  @override
  Future<Either> signup(CreateUserReq createUserReq) async {
     return await sl<AuthFirebaseService>().signup(createUserReq) ;
  }
  @override
  Future<Either> getUser() async {
    return await sl<AuthFirebaseService>().getUser();
  }


}