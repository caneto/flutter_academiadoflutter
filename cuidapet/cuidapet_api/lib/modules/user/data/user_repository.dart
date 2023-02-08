
import 'package:cuidapet_api/application/database/i_database_connection.dart';
import 'package:cuidapet_api/application/exceptions/database_exception.dart';
import 'package:cuidapet_api/application/exceptions/user_exists_exception.dart';
import 'package:cuidapet_api/application/exceptions/user_notfound_exception.dart';
import 'package:cuidapet_api/application/helpers/cripty_helper.dart';
import 'package:cuidapet_api/application/logger/i_logger.dart';
import 'package:cuidapet_api/entities/user.dart';
import 'package:cuidapet_api/modules/user/view_models/platform.dart';
import 'package:injectable/injectable.dart';
import 'package:mysql1/mysql1.dart';

import './i_user_repository.dart';

@LazySingleton(as: IUserRepository)
class UserRepository implements IUserRepository {
  final IDatabaseConnection connection;
  final ILogger log;

  UserRepository({required this.connection, required this.log});

  @override
  Future<User> createUser(User user) async {
    MySqlConnection? conn;
    try {
      conn = await connection.openConnection();
      final query = ''' 
        insert usuario(email, tipo_cadastro, img_avatar, senha, fornecedor_id, social_id)
        values(?,?,?,?,?,?)
      ''';

      final result = await conn.query(query, [
        user.email,
        user.registerType,
        user.imageAvatar,
        CriptyHelper.generateSha256Hash(user.password ?? ''),
        user.supplierId,
        user.socialKey
      ]);

      final userId = result.insertId;
      return user.copyWith(id: userId, password: '');
    } on MySqlException catch (e, s) {
      if (e.message.contains('usuario.email_UNIQUE')) {
        log.error('Usuario ja cadastrado na base de dados', e, s);
        throw UserExistsException();
      }
      log.error('Erro ao criar usuario', e, s);
      throw DatabaseException(message: 'Erro ao criar usuario', exception: e);
    } finally {
      await conn?.close();
    }
  }

  @override
  Future<User> loginWithEmailPassword(
      String email, String password, bool supplierUser) async {
    MySqlConnection? conn;

    try {
      conn = await connection.openConnection();
      var query = '''
        select * 
        from usuario 
        where 
          email = ? and 
          senha = ?
      ''';

      if (supplierUser) {
        query += ' and fornecedor_id is not null';
      } else {
        query += ' and fornecedor_id is null';
      }

      final result = await conn.query(query, [
        email,
        CriptyHelper.generateSha256Hash(password),
      ]);

      if (result.isEmpty) {
        log.error('usuario ou senha invalidos!!!!');
        throw UserNotfoundException(message: 'Usuário ou senha inválidos');
      } else {
        final userSqlData = result.first;
        return User(
            id: userSqlData['id'] as int,
            email: userSqlData['email'],
            registerType: userSqlData['tipo_cadastro'],
            iosToken: (userSqlData['ios_token'] as Blob?)?.toString(),
            androidToken: (userSqlData['android_token'] as Blob?)?.toString(),
            refreshToken: (userSqlData['refresh_token'] as Blob?)?.toString(),
            imageAvatar: (userSqlData['img_avatar'] as Blob?)?.toString(),
            supplierId: userSqlData['fornecedor_id']);
      }
    } on MySqlException catch (e, s) {
      log.error('Erro ao realizar login', e, s);
      throw DatabaseException(message: e.message);
    } finally {
      await conn?.close();
    }
  }

  @override
  Future<User> loginByEmailSocialKey(
      String email, String socialKey, String socialType) async {
    MySqlConnection? conn;
    try {
      conn = await connection.openConnection();

      final result =
          await conn.query('select * from usuario where email = ?', [email]);

      if (result.isEmpty) {
        throw UserNotfoundException(message: 'Usuário não encontrado');
      } else {
        final dataMysql = result.first;

        if (dataMysql['social_id'] == null ||
            dataMysql['social_id'] != socialKey) {
          await conn.query('''
            update usuario 
            set social_id = ?, tipo_cadastro = ? 
            where id = ?
          ''', [
            socialKey,
            socialType,
            dataMysql['id'],
          ]);
        }

        return User(
            id: dataMysql['id'] as int,
            email: dataMysql['email'],
            registerType: dataMysql['tipo_cadastro'],
            iosToken: (dataMysql['ios_token'] as Blob?)?.toString(),
            androidToken: (dataMysql['android_token'] as Blob?)?.toString(),
            refreshToken: (dataMysql['refresh_token'] as Blob?)?.toString(),
            imageAvatar: (dataMysql['img_avatar'] as Blob?)?.toString(),
            supplierId: dataMysql['fornecedor_id']);
      }
    } on MySqlException catch (e, s) {
      log.error('Erro ao realizar login com rede social', e, s);
      throw DatabaseException();
    } finally {
      await conn?.close();
    }
  }

  @override
  Future<void> updateUserDeviceTokenAndRefreshToken(User user) async {
    MySqlConnection? conn;
    try {
      conn = await connection.openConnection();

      final setParams = {};

      if (user.iosToken != null) {
        setParams.putIfAbsent('ios_token', () => user.iosToken);
      } else {
        setParams.putIfAbsent('android_token', () => user.androidToken);
      }

      final query = ''' 
        update usuario
        set 
          ${setParams.keys.elementAt(0)} = ?,
          refresh_token = ?
        where
          id = ?
      ''';
      await conn.query(
          query, [setParams.values.elementAt(0), user.refreshToken!, user.id!]);
    } on MySqlException catch (e, s) {
      log.error('Erro ao confirmar login', e, s);
      throw DatabaseException();
    } finally {
      await conn?.close();
    }
  }

  @override
  Future<void> updateRefreshToken(User user) async {
    MySqlConnection? conn;
    try {
      conn = await connection.openConnection();
      await conn.query('update usuario set refresh_token = ? where id = ?',
          [user.refreshToken!, user.id!]);
    } on MySqlException catch (e, s) {
      log.error('Erro ao atualizar refresh token', e, s);
      throw DatabaseException();
    } finally {
      await conn?.close();
    }
  }

  @override
  Future<User> findById(int id) async {
    MySqlConnection? conn;
    try {
      conn = await connection.openConnection();
      final result = await conn.query('''
        select 
          id, email, tipo_cadastro, ios_token, android_token,
          refresh_token, img_avatar, fornecedor_id
        from usuario
        where id = ?
      ''', [id]);

      if (result.isEmpty) {
        log.error('Usuário não encontrado com o id[$id]');
        throw UserNotfoundException(
            message: 'Usuário não encontrado com o id[$id]');
      } else {
        final dataMysql = result.first;
        return User(
            id: dataMysql['id'] as int,
            email: dataMysql['email'],
            registerType: dataMysql['tipo_cadastro'],
            iosToken: (dataMysql['ios_token'] as Blob?)?.toString(),
            androidToken: (dataMysql['android_token'] as Blob?)?.toString(),
            refreshToken: (dataMysql['refresh_token'] as Blob?)?.toString(),
            imageAvatar: (dataMysql['img_avatar'] as Blob?)?.toString(),
            supplierId: dataMysql['fornecedor_id']);
      }
    } on MySqlException catch (e, s) {
      log.error('Erro ao buscar usuario por id', e, s);
      throw DatabaseException();
    } finally {
      await conn?.close();
    }
  }

  @override
  Future<void> updateUrlAvatar(int id, String urlAvatar) async {
    MySqlConnection? conn;
    try {
      conn = await connection.openConnection();
      await conn.query(
          'update usuario set img_avatar = ? where id = ?', [urlAvatar, id]);
    } on MySqlException catch (e, s) {
      log.error('Erro ao atualizar o avatar', e, s);
      throw DatabaseException();
    } finally {
      await conn?.close();
    }
  }

  @override
  Future<void> updateDeviceToken(
      int id, String token, Platform platform) async {
    MySqlConnection? conn;

    try {
      conn = await connection.openConnection();
      var set = '';
      if(platform == Platform.ios) {
        set = 'ios_token = ?';
      }else {
        set = 'android_token = ?';
      }

      final query = 'update usuario set $set where id = ?';
      await conn.query(query, [token, id]);

    } on MySqlException catch(e,s) {
      log.error('Erro ao atualizar o device token', e, s);
      throw DatabaseException();
    } finally {
      await conn?.close();
    }
  }
}
