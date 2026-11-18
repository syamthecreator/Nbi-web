import 'package:flutter/material.dart';

/// Strongly-typed Institution entity matching select-institution.html
class InstitutionModel {
  final String id;
  final String name;
  final String location;
  final String city;
  final String pincode;
  final Color badgeColor;
  final String crestAsset;
  final bool isFollowing;

  const InstitutionModel({
    required this.id,
    required this.name,
    required this.location,
    required this.city,
    required this.pincode,
    required this.badgeColor,
    this.crestAsset = 'assets/images/salford-crest.png',
    this.isFollowing = false,
  });

  InstitutionModel copyWith({
    String? id,
    String? name,
    String? location,
    String? city,
    String? pincode,
    Color? badgeColor,
    String? crestAsset,
    bool? isFollowing,
  }) {
    return InstitutionModel(
      id: id ?? this.id,
      name: name ?? this.name,
      location: location ?? this.location,
      city: city ?? this.city,
      pincode: pincode ?? this.pincode,
      badgeColor: badgeColor ?? this.badgeColor,
      crestAsset: crestAsset ?? this.crestAsset,
      isFollowing: isFollowing ?? this.isFollowing,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'city': city,
      'pincode': pincode,
      'crestAsset': crestAsset,
      'isFollowing': isFollowing,
    };
  }

  factory InstitutionModel.fromJson(Map<String, dynamic> json) {
    return InstitutionModel(
      id: json['id'] as String,
      name: json['name'] as String,
      location: json['location'] as String,
      city: json['city'] as String,
      pincode: json['pincode'] as String,
      badgeColor: const Color(0xFF1E3A8A),
      crestAsset: json['crestAsset'] as String? ?? 'assets/images/salford-crest.png',
      isFollowing: json['isFollowing'] as bool? ?? false,
    );
  }
}
