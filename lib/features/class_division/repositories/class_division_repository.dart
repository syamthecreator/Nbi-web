import '../models/class_division_model.dart';
import '../services/class_division_service.dart';

abstract class ClassDivisionRepository {
  Future<List<SchoolConfigModel>> getConfigs(List<String> institutionNames);
  Future<bool> saveConfig(String id, String className, String division);
}

class ClassDivisionRepositoryImpl implements ClassDivisionRepository {
  final ClassDivisionService service;

  ClassDivisionRepositoryImpl({ClassDivisionService? service})
      : service = service ?? ClassDivisionServiceImpl();

  @override
  Future<List<SchoolConfigModel>> getConfigs(List<String> institutionNames) {
    return service.fetchConfigsForInstitutions(institutionNames);
  }

  @override
  Future<bool> saveConfig(String id, String className, String division) {
    return service.saveClassDivisionConfig(id, className, division);
  }
}
