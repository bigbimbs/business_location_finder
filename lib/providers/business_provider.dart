import 'package:flutter/foundation.dart';
import '../models/business.dart';
import '../services/business_service.dart';

class BusinessProvider with ChangeNotifier {
  final BusinessService _businessService = BusinessService();
  
  List<Business> _businesses = [];
  List<Business> _filteredBusinesses = [];
  bool _isLoading = false;
  String? _error;
  String _searchQuery = '';

  List<Business> get businesses => _filteredBusinesses;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String get searchQuery => _searchQuery;

  Future<void> loadBusinesses() async {
    _setLoading(true);
    _clearError();

    try {
      _businesses = await _businessService.getBusinesses();
      _filteredBusinesses = List.from(_businesses);
      notifyListeners();
    } catch (e) {
      _setError('Failed to load businesses: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  void searchBusinesses(String query) {
    _searchQuery = query;
    
    if (query.isEmpty) {
      _filteredBusinesses = List.from(_businesses);
    } else {
      _filteredBusinesses = _businesses.where((business) {
        return business.name.toLowerCase().contains(query.toLowerCase()) ||
               business.location.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    
    notifyListeners();
  }

  void clearSearch() {
    searchBusinesses('');
  }

  Future<void> retry() async {
    await loadBusinesses();
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _error = error;
    notifyListeners();
  }

  void _clearError() {
    _error = null;
    notifyListeners();
  }
}
