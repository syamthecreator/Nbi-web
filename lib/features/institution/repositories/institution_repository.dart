import 'package:flutter/material.dart';
import '../models/institution_model.dart';
import '../services/institution_service.dart';

abstract class InstitutionRepository {
  Future<List<InstitutionModel>> getInstitutions({String? query});
  Future<bool> toggleFollow(String id, bool currentState);
  List<InstitutionModel> getDefaultInstitutions();
}

class InstitutionRepositoryImpl implements InstitutionRepository {
  final InstitutionService institutionService;

  InstitutionRepositoryImpl({InstitutionService? service})
      : institutionService = service ?? InstitutionServiceImpl();

  @override
  Future<List<InstitutionModel>> getInstitutions({String? query}) async {
    final remote = await institutionService.fetchInstitutions(query: query);
    if (remote.isNotEmpty) return remote;
    return getDefaultInstitutions();
  }

  @override
  Future<bool> toggleFollow(String id, bool currentState) {
    return institutionService.toggleFollow(id, currentState);
  }

  @override
  List<InstitutionModel> getDefaultInstitutions() {
    return const [
      InstitutionModel(
        id: '1',
        name: 'The Cambridge International School',
        location: 'Koramangala, 4th Block',
        city: 'Bangalore',
        pincode: '560034',
        badgeColor: Color(0xFF1E3A8A),
        crestAsset: 'assets/images/salford-crest.png',
        isFollowing: false,
      ),
      InstitutionModel(
        id: '2',
        name: 'Delhi Public School, R.K. Puram',
        location: 'Sector XII, R.K. Puram',
        city: 'New Delhi',
        pincode: '110022',
        badgeColor: Color(0xFF15803D),
        crestAsset: 'assets/images/salford-crest.png',
        isFollowing: false,
      ),
      InstitutionModel(
        id: '3',
        name: 'St. Xavier\'s Collegiate School',
        location: '30, Mother Teresa Sarani',
        city: 'Kolkata',
        pincode: '700016',
        badgeColor: Color(0xFFB45309),
        crestAsset: 'assets/images/salford-crest.png',
        isFollowing: false,
      ),
      InstitutionModel(
        id: '4',
        name: 'National Public School, Indiranagar',
        location: '12th Main Road, HAL II Stage',
        city: 'Bangalore',
        pincode: '560008',
        badgeColor: Color(0xFF6D28D9),
        crestAsset: 'assets/images/salford-crest.png',
        isFollowing: false,
      ),
      InstitutionModel(
        id: '5',
        name: 'The Cathedral & John Connon School',
        location: '6, Purshottamdas Thakurdas Marg',
        city: 'Mumbai',
        pincode: '400001',
        badgeColor: Color(0xFFBE123C),
        crestAsset: 'assets/images/salford-crest.png',
        isFollowing: false,
      ),
      InstitutionModel(
        id: '6',
        name: 'Bhavan\'s Vidya Mandir, Elamakkara',
        location: 'Elamakkara Road',
        city: 'Kochi',
        pincode: '682026',
        badgeColor: Color(0xFF0F766E),
        crestAsset: 'assets/images/salford-crest.png',
        isFollowing: false,
      ),
    ];
  }
}
