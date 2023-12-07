abstract class EntityDataSource<T> {
  Future<List<T>> fetchData();
  Future<T> create(T t);
  Future<T> fetchDataById(String id);
  Future<T> update(String id, T t);
  Future<T> delete(String id);
}
