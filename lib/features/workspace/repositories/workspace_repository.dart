import '../models/workspace_model.dart';
import '../services/workspace_service.dart';

abstract class WorkspaceRepository {
  Future<WorkspaceModel> createWorkspace(WorkspaceModel workspace);
  Future<bool> checkAvailability(String workspaceName);
}

class WorkspaceRepositoryImpl implements WorkspaceRepository {
  final WorkspaceService workspaceService;

  WorkspaceRepositoryImpl({WorkspaceService? service})
      : workspaceService = service ?? WorkspaceServiceImpl();

  @override
  Future<WorkspaceModel> createWorkspace(WorkspaceModel workspace) {
    return workspaceService.createWorkspace(workspace);
  }

  @override
  Future<bool> checkAvailability(String workspaceName) {
    return workspaceService.checkWorkspaceAvailability(workspaceName);
  }
}
