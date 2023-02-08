import 'package:cuidapet_api/application/exceptions/database_exception.dart';
import 'package:cuidapet_api/application/logger/i_logger.dart';
import 'package:cuidapet_api/entities/category.dart';
import 'package:cuidapet_api/entities/supplier.dart';
import 'package:cuidapet_api/entities/supplier_service.dart';
import 'package:injectable/injectable.dart';
import 'package:mysql1/mysql1.dart';

import 'package:cuidapet_api/application/database/i_database_connection.dart';
import 'package:cuidapet_api/dtos/supplier_nearby_me_dto.dart';

import './i_supplier_repository.dart';

@LazySingleton(as: ISupplierRepository)
class SupplierRepository implements ISupplierRepository {
  IDatabaseConnection connection;
  ILogger log;

  SupplierRepository({
    required this.connection,
    required this.log,
  });

  @override
  Future<List<SupplierNearbyMeDTO>> findNearByPosition(
      double lat, double lng, int distance) async {
    MySqlConnection? conn;

    try {
      conn = await connection.openConnection();
      final query = ''' 
        SELECT f.id, f.nome, f.logo, f.categorias_fornecedor_id,
          (6371 *
            acos(
                            cos(radians($lat)) *
                            cos(radians(ST_X(f.latlng))) *
                            cos(radians($lng) - radians(ST_Y(f.latlng))) +
                            sin(radians($lat)) *
                            sin(radians(ST_X(f.latlng)))
                )) AS distancia
            FROM fornecedor f
            HAVING distancia <= $distance
            Order by distancia;
      ''';

      final result = await conn.query(query);
      return result
          .map(
            (f) => SupplierNearbyMeDTO(
                id: f['id'],
                name: f['nome'],
                logo: (f['logo'] as Blob?)?.toString(),
                distance: f['distancia'],
                categoryId: f['categorias_fornecedor_id']),
          )
          .toList();
    } on MySqlException catch (e, s) {
      log.error('Erro ao buscar fornecedores perto de mim', e, s);
      throw DatabaseException();
    } finally {
      await conn?.close();
    }
  }

  @override
  Future<Supplier?> findById(int id) async {
    MySqlConnection? conn;

    try {
      conn = await connection.openConnection();
      final query = '''
        select 
          f.id, f.nome, f.logo, f.endereco, f.telefone, ST_X(f.latlng) as lat, ST_Y(f.latlng) as lng,
          f.categorias_fornecedor_id, c.nome_categoria, c.tipo_categoria
        from fornecedor as f
          inner join categorias_fornecedor as c on (f.categorias_fornecedor_id = c.id)
        where 
          f.id = ?
      ''';
      final result = await conn.query(query, [id]);

      if (result.isNotEmpty) {
        final dataMysql = result.first;
        return Supplier(
          id: dataMysql['id'],
          name: dataMysql['nome'],
          logo: (dataMysql['logo'] as Blob?).toString(),
          address: dataMysql['endereco'],
          phone: dataMysql['telefone'],
          lat: dataMysql['lat'],
          lng: dataMysql['lng'],
          category: Category(
              id: dataMysql['categorias_fornecedor_id'],
              name: dataMysql['nome_categoria'],
              type: dataMysql['tipo_categoria']),
        );
      }
    } on MySqlException catch (e, s) {
      log.error('Erro ao buscar fornecedor', e, s);
      throw DatabaseException();
    } finally {
      await conn?.close();
    }
  }

  @override
  Future<List<SupplierService>> findServicesBySupplierId(int supplierId) async {
    MySqlConnection? conn;

    try {
      conn = await connection.openConnection();
      final result = await conn.query('''
        select id, fornecedor_id, nome_servico, valor_servico
        from fornecedor_servicos
        where fornecedor_id = ?
      ''', [supplierId]);

      if (result.isEmpty) {
        return [];
      }

      return result
          .map((s) => SupplierService(
                id: s['id'],
                supplierId: s['fornecedor_id'],
                name: s['nome_servico'],
                price: s['valor_servico'],
              ))
          .toList();
    } on MySqlException catch (e, s) {
      log.error('Erro ao buscar os servicos de um fornecedor', e, s);
      throw DatabaseException();
    } finally {
      await conn?.close();
    }
  }

  @override
  Future<bool> checkUserEmailExists(String email) async {
    MySqlConnection? conn;

    try {
      conn = await connection.openConnection();
      final result = await conn
          .query('select count(*) from usuario where email = ?', [email]);

      final dataMysql = result.first;
      return dataMysql[0] > 0;
    } on MySqlException catch (e, s) {
      log.error('Erro ao verificar se login existe', e, s);
      throw DatabaseException();
    } finally {
      await conn?.close();
    }
  }

  @override
  Future<int> saveSupplier(Supplier supplier) async {
    MySqlConnection? conn;

    try {
      conn = await connection.openConnection();
      final result = await conn.query('''
        insert into fornecedor(nome, logo, endereco, telefone, latlng, categorias_fornecedor_id)
        values (?,?,?,?,ST_GeomFromText(?),?)
      ''', [
        supplier.name,
        supplier.logo,
        supplier.address,
        supplier.phone,
        'POINT(${supplier.lat ?? 0} ${supplier.lng ?? 0})',
        supplier.category?.id
      ]);

      return result.insertId ?? 0;
    } on MySqlException catch (e, s) {
      log.error('Erro ao cadastrar novo fornecedor', e, s);
      throw DatabaseException();
    } finally {
      await conn?.close();
    }
  }

  @override
  Future<Supplier> update(Supplier supplier) async {
    MySqlConnection? conn;

    try {
      conn = await connection.openConnection();
      await conn.query('''
        update fornecedor
          set
            nome = ?,
            logo = ?,
            endereco = ?,
            telefone = ?,
            latlng = ST_GeomFromText(?),
            categorias_fornecedor_id = ?
        where
          id = ?
      ''', [
        supplier.name,
        supplier.logo,
        supplier.address,
        supplier.phone,
        'POINT(${supplier.lat} ${supplier.lng})',
        supplier.category?.id,
        supplier.id
      ]);

      Category? category;
      final categoryId = supplier.category?.id;
      if (categoryId != null) {
        final resultCategory = await conn.query(
            'select * from categorias_fornecedor where id = ?',
            [categoryId]);

        var categoryData = resultCategory.first;
        category = Category(
          id: categoryData['id'],
          name: categoryData['nome_categoria'],
          type: categoryData['tipo_categoria'],
        );
      }

      return supplier.copyWith(category: category);
    } on MySqlException catch (e, s) {
      log.error('Erro ao atualizar dados do fornecedor', e, s);
      throw DatabaseException();
    } finally {
      await conn?.close();
    }
  }
}
