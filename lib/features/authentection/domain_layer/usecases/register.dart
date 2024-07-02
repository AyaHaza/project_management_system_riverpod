import '../../../../core/usecases/usecases.dart';
import '../../data_layer/models/user.dart';
import '../repository/user_repository.dart';

class RegisterUseCase implements UseCse<bool,UserModel>{
  final UserRepository userRepository;
  RegisterUseCase(this.userRepository);

  @override
  Future<bool> call(params) {
    return userRepository.register(params);
  }
}