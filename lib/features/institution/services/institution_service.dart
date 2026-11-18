import '../../../core/services/base_service.dart';
import '../models/institution_model.dart';

abstract class InstitutionService extends BaseService {
  InstitutionService({super.client});

  Future<List<InstitutionModel>> fetchInstitutions({String? query});
  Future<bool> toggleFollow(String institutionId, bool isFollowing);
}

class InstitutionServiceImpl extends InstitutionService {
  InstitutionServiceImpl({super.client});

  @override
  Future<List<InstitutionModel>> fetchInstitutions({String? query}) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return const [];
  }

  @override
  Future<bool> toggleFollow(String institutionId, bool isFollowing) async {
    await Future.delayed(const Duration(milliseconds: 150));
    return !isFollowing;
  }
}
