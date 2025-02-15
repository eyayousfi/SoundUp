
import 'package:dartz/dartz.dart';

import '../../../data/models/user/auth/create_user.dart';
import '../../../data/models/user/auth/signin_user_req.dart';

abstract class AuthRepository {

  Future<Either> signup(CreateUserReq createUserReq);

  Future<Either> signin(SigninUserReq signinUserReq);
  Future<Either> getUser();


}