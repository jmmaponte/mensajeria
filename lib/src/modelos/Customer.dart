// To parse this JSON data, do
////     final customer = customerFromJson(jsonString);
import 'dart:convert';
Customer customerFromJson(String str) => Customer.fromJson(json.decode(str));
String customerToJson(Customer data) => json.encode(data.toJson());
// clase
class Customer {
    String id;
    String name;
    String mobil;
    String email;
    String passd;
// constructor
    Customer({
        this.id,
        this.name,
        this.mobil,
        this.email,
        this.passd,
    });
// metodo qtev recibe un mapa  y nos retorna el cliente
    factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id:       json["id"],
        name:     json["name"],
        mobil:    json["mobil"],
        email:    json["email"],
        passd:    json["passd"],
    );
// toma los los campos y los transforma a json con los datoa que contenga
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "mobil": mobil,
        "email": email,
        "passd": passd,
    };

  
}
