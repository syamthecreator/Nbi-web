import '../../../core/services/base_service.dart';
import '../models/class_division_model.dart';

abstract class ClassDivisionService extends BaseService {
  ClassDivisionService({super.client});

  Future<List<SchoolConfigModel>> fetchConfigsForInstitutions(List<String> institutionNames);
  Future<bool> saveClassDivisionConfig(String institutionId, String className, String division);
}

class ClassDivisionServiceImpl extends ClassDivisionService {
  ClassDivisionServiceImpl({super.client});

  @override
  Future<List<SchoolConfigModel>> fetchConfigsForInstitutions(List<String> institutionNames) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return institutionNames.asMap().entries.map((entry) {
      return SchoolConfigModel(
        id: 'cfg-${entry.key + 1}',
        name: entry.value,
      );
    }).toList();
  }

  @override
  Future<bool> saveClassDivisionConfig(String institutionId, String className, String division) async {
    await Future.delayed(const Duration(milliseconds: 150));
    return true;
  }
}
