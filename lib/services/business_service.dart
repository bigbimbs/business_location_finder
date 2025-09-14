import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../models/business.dart';
import '../services/storage_service.dart';

class AssetInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.path.startsWith('assets/')) {
      try {

        final jsonString = await rootBundle.loadString(options.path);
        final data = json.decode(jsonString);

    
        return handler.resolve(
          Response(
            requestOptions: options,
            data: data,
            statusCode: 200,
          ),
        );
      } catch (e) {
        return handler.reject(
          DioException(
            requestOptions: options,
            error: 'Failed to load asset: $e',
            type: DioExceptionType.unknown,
          ),
        );
      }
    }

    super.onRequest(options, handler);
  }
}

class BusinessService {
  final Dio _dio = Dio()..interceptors.add(AssetInterceptor());
  final StorageService _storageService = StorageService();

  Future<List<Business>> getBusinesses() async {
    try {
      final cachedBusinesses = await _storageService.getCachedBusinesses();
      if (cachedBusinesses.isNotEmpty) {
        return cachedBusinesses;
      }

      final response = await _dio.get('assets/data/businesses.json');
      final List<dynamic> jsonList = response.data;

      final businesses = jsonList
          .map((json) => Business.fromJson(json as Map<String, dynamic>))
          .toList();

      await _storageService.cacheBusinesses(businesses);

      return businesses;
    } catch (e) {
      throw Exception('Failed to load businesses: $e');
    }
  }

  Future<List<Business>> refreshBusinesses() async {
    await _storageService.clearCache();
    return getBusinesses();
  }
}