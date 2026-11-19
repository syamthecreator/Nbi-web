import 'dart:typed_data';

/// Strongly-typed Workspace entity.
class WorkspaceModel {
  final String institutionName;
  final String workspaceName;
  final String institutionType;
  final String institutionCode;
  final String? schoolLogoUrl;
  final Uint8List? schoolLogoBytes;
  final String adminFullName;
  final String adminDesignation;
  final String adminEmail;
  final String adminMobile;
  final String? createdDate;

  const WorkspaceModel({
    required this.institutionName,
    required this.workspaceName,
    required this.institutionType,
    required this.institutionCode,
    this.schoolLogoUrl,
    this.schoolLogoBytes,
    required this.adminFullName,
    required this.adminDesignation,
    required this.adminEmail,
    required this.adminMobile,
    this.createdDate,
  });

  WorkspaceModel copyWith({
    String? institutionName,
    String? workspaceName,
    String? institutionType,
    String? institutionCode,
    String? schoolLogoUrl,
    Uint8List? schoolLogoBytes,
    String? adminFullName,
    String? adminDesignation,
    String? adminEmail,
    String? adminMobile,
    String? createdDate,
  }) {
    return WorkspaceModel(
      institutionName: institutionName ?? this.institutionName,
      workspaceName: workspaceName ?? this.workspaceName,
      institutionType: institutionType ?? this.institutionType,
      institutionCode: institutionCode ?? this.institutionCode,
      schoolLogoUrl: schoolLogoUrl ?? this.schoolLogoUrl,
      schoolLogoBytes: schoolLogoBytes ?? this.schoolLogoBytes,
      adminFullName: adminFullName ?? this.adminFullName,
      adminDesignation: adminDesignation ?? this.adminDesignation,
      adminEmail: adminEmail ?? this.adminEmail,
      adminMobile: adminMobile ?? this.adminMobile,
      createdDate: createdDate ?? this.createdDate,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'institutionName': institutionName,
      'workspaceName': workspaceName,
      'institutionType': institutionType,
      'institutionCode': institutionCode,
      'schoolLogoUrl': schoolLogoUrl,
      'adminFullName': adminFullName,
      'adminDesignation': adminDesignation,
      'adminEmail': adminEmail,
      'adminMobile': adminMobile,
      'createdDate': createdDate,
    };
  }

  factory WorkspaceModel.fromJson(Map<String, dynamic> json) {
    return WorkspaceModel(
      institutionName: json['institutionName'] as String,
      workspaceName: json['workspaceName'] as String,
      institutionType: json['institutionType'] as String,
      institutionCode: json['institutionCode'] as String,
      schoolLogoUrl: json['schoolLogoUrl'] as String?,
      adminFullName: json['adminFullName'] as String,
      adminDesignation: json['adminDesignation'] as String,
      adminEmail: json['adminEmail'] as String,
      adminMobile: json['adminMobile'] as String,
      createdDate: json['createdDate'] as String?,
    );
  }
}
