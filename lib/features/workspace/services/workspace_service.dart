import '../../../core/services/base_service.dart';
import '../models/workspace_model.dart';

abstract class WorkspaceService extends BaseService {
  WorkspaceService({super.client});

  Future<WorkspaceModel> createWorkspace(WorkspaceModel workspace);
  Future<bool> checkWorkspaceAvailability(String workspaceName);
}

class WorkspaceServiceImpl extends WorkspaceService {
  WorkspaceServiceImpl({super.client});

  @override
  Future<WorkspaceModel> createWorkspace(WorkspaceModel workspace) async {
    await Future.delayed(const Duration(milliseconds: 700));
    return workspace.copyWith(
      createdDate: DateTime.now().toIso8601String(),
    );
  }

  @override
  Future<bool> checkWorkspaceAvailability(String workspaceName) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return true;
  }
}
