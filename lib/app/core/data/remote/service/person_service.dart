import 'package:dio/dio.dart';
import 'package:storeapp/app/core/data/remote/dto/person_data_model.dart';
import 'package:storeapp/app/core/data/remote/dto/product_data_model.dart';

final class PersonService {
  final Dio dio;
  final String _baseUrl =
      //"https://storeappdamo2024-default-rtdb.firebaseio.com";
      "https://storeappflu-default-rtdb.firebaseio.com";

  PersonService({required this.dio});

  Future<List<PersonDataModel>> getAll() async {
    final List<PersonDataModel> persons = [];

    try {
      final Response response = await dio.get("$_baseUrl/persons.json");

      if (response.data != null) {
        response.data.forEach((key, value) {
          String id = key;
          value.forEach((key, value) {
            persons.add(PersonDataModel.fromJson(id, key, value));
          });
        });
      }
    } catch (e) {
      throw Exception("Ha ocurrido un error obteniendo los datos: $e");
    }

    return persons;
  }

/*
  Future<PersonDataModel> get(String id) async {
    late final PersonDataModel personDataModel;
    try {
      final Response<Map<String, dynamic>> response = await dio.get(
        "$_baseUrl/persons/$id.json",
      );
      if (response.data != null) {
        personDataModel = PersonDataModel.fromJson(id, response.data!);
      }
    } catch (e) {}
    return personDataModel;
  }
  */

  Future<bool> add(PersonDataModel personDataModel) async {
    try {
      bool request = await dio
          .post(
            "$_baseUrl/persons/${personDataModel.id}.json",
            data: personDataModel.toJson(),
          )
          .then((onValue) => true)
          .catchError((onError) => false);
      await dio
          .post(
            "$_baseUrl/users/.json",
            data: personDataModel.toUserJson(),
          )
          .then((onValue) => true)
          .catchError((onError) => false);
      return request;
    } catch (e) {
      throw (Exception(e));
    }
    return false;
  }

  Future<bool> update(PersonDataModel personDataModel) async {
    try {
      await dio.put(
        "$_baseUrl/persons/${personDataModel.id}.json",
        data: personDataModel.toJson(),
      );
      return true;
    } catch (e) {
      throw (Exception(e));
    }
    return false;
  }

  Future<bool> delete(String id) async {
    try {
      await dio.delete("$_baseUrl/persons/$id.json");
      return true;
    } catch (e) {
      throw (Exception(e));
    }
    return false;
  }
}
