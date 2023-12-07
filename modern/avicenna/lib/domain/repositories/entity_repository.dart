import 'package:avicenna/infrastructure/data_sources/entity_data_source.dart';

abstract class EntityRepository<T> {
  EntityDataSource<T> dataSource;

  EntityRepository(this.dataSource);

  // Retrieve all entities
  Future<List<T>> getAll();

  // Retrieve a single entity by ID
  Future<T?> getById(String id);

  // Create a new entity
  Future<void> create(T entity);

  // Update an existing entity
  Future<void> update(String id, T updatedEntity);

  // Delete an entity by ID
  Future<void> delete(String id);
}
