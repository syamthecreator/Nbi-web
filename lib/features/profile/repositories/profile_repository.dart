import '../models/profile_model.dart';
import '../services/profile_service.dart';

abstract class ProfileRepository {
  Future<ProfileModel> getProfile();
  Future<bool> saveProfile(ProfileModel profile);
}

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileService service;

  ProfileRepositoryImpl({ProfileService? service})
      : service = service ?? ProfileServiceImpl();

  @override
  Future<ProfileModel> getProfile() {
    return service.getProfile();
  }

  @override
  Future<bool> saveProfile(ProfileModel profile) {
    return service.updateProfile(profile);
  }
}
