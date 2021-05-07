import 'dart:convert';

Messenger messengerFromJson(String str) => Messenger.fromJson(json.decode(str));

String messengerToJson(Messenger data) => json.encode(data.toJson());

class Messenger {
    Messenger({
        this.id,
        this.placa,
        this.name,
        this.mobil,
        this.email,
        this.passd,
    });

    String id;
    String placa;
    String name;
    String mobil;
    String email;
    String passd;

    factory Messenger.fromJson(Map<String, dynamic> json) => Messenger(
        id: json["id"],
        placa: json["placa"],
        name: json["name"],
        mobil: json["mobil"],
        email: json["email"],
        passd: json["passd"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "placa": placa,
        "name": name,
        "mobil": mobil,
        "email": email,
        "passd": passd,
    };
}
