import 'package:avicenna_app/infrastructure/data_sources/remote/remote_data_source.dart';

abstract class EntityRepository<T> {
  abstract RemoteDataSource api;
  Future<List<T>> fetchEntities();
  Future<T> fetchEntity();
}
