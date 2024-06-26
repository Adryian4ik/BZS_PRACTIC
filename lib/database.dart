import 'package:postgres/postgres.dart';

class Database {
  late Future<Connection> connection;

  Database(String username, String password) {
    try{
      connection = Connection.open(
        Endpoint(
          host: '127.0.0.1',
          port: 5432,
          database: 'BZS',
          username: username,
          password: password,
        ),
        settings: const ConnectionSettings(sslMode: SslMode.disable));
        connection.then((val){
          val.execute("SELECT * FROM public.\"Tenant\"").then((val){

            List<Tenant> a  = List.generate(val.length, (index){
              List data = val[index];
              return Tenant(data[0], data[1], data[2], data[3], data[4]);
            });
            print(a[0].adress);
          });
        });
    }
    catch (e){
      throw "aboba";
    }
    
  }

  Future<List<Tenant>> getTenantList(){
    return Future(()async {
      var conn = await connection;
      var db_result = await conn.execute("SELECT * FROM public.\"Tenant\"");
      List<Tenant> result  = List.generate(db_result.length, (index){
              List data = db_result[index];
              return Tenant(data[0], data[1], data[2], data[3], data[4]);
            });
      return result;
    });
  }



  Future<Technic> addTechnic(Technic record){
    return Future(() async {
      var conn = await connection;
      var db_result = await conn.execute("INSERT INTO public.\"Tenant\" VALUES(${record.id}, \"${record.description}\")");
      print(db_result);
      return record;
    });
  }



}


interface class Tenant{
  String id;
  String fullName;
  String phoneNumber;
  String email;
  String adress;
  Tenant(this.id, this.fullName, this.phoneNumber, this.email, this.adress);
}

interface class Technic{
  String id;
  String description;
  Technic(this.id, this.description);
}

interface class Order{
  String id;
  String tenantId;
  String technicId;
  DateTime startDate;
  DateTime endDate;
  String status;
  Order(this.id, this.tenantId, this.technicId, this.startDate, this.endDate, this.status);
}


