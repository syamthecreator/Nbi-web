import '../../../core/services/base_service.dart';
import '../models/profile_model.dart';

abstract class ProfileService extends BaseService {
  ProfileService({super.client});

  Future<ProfileModel> getProfile();
  Future<bool> updateProfile(ProfileModel profile);
}

class ProfileServiceImpl extends ProfileService {
  ProfileServiceImpl({super.client});

  @override
  Future<ProfileModel> getProfile() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return ProfileModel.defaultProfile;
  }

  @override
  Future<bool> updateProfile(ProfileModel profile) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return true;
  }
}
