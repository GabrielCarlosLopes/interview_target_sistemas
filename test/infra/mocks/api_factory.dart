import 'package:faker/faker.dart';

class ApiFactory {
  static Map makeAccountJson() => {
        "dispositivo": faker.randomGenerator.string(10),
        "codigo": faker.randomGenerator.string(10),
        "meio_envio": faker.randomGenerator.string(6),
        "user": {
          "registro": faker.guid.guid(),
          "senha": faker.internet.password(),
          "situacao": "A",
          "rg": faker.randomGenerator.integer(11).toString(),
          "datahora_modificacao": faker.date.toString(),
          "email_principal": faker.internet.email(),
          "number": faker.randomGenerator.integer(18, min: 11).toString(),
          "token": faker.guid.guid(),
          "host": faker.internet.httpsUrl()
        }
      };
  static String makeRecoverPasswordResponse() => 'sucesso';

  static Map makeOTPVerificationPhoneJson() =>
      {"codigo": faker.randomGenerator.integer(6).toString(), "envio": 0};

  static Map makeOTPVerificationMailJson() =>
      {"codigo": faker.randomGenerator.integer(6).toString(), "envio": 1};

  static List<Map> makeMonitoredLocationListJson() => [
        {
          "registro": faker.guid.guid(),
          "pc": faker.randomGenerator.string(6),
          "situacao": "A",
          "particao": faker.randomGenerator.integer(1).toString(),
          "interacao": "I",
          "armado": faker.randomGenerator.string(1),
          "ex_user_alarme": faker.randomGenerator.integer(6).toString(),
          "endereco": faker.address.streetAddress(),
          "cliente": faker.person.name(),
          "descricao": faker.randomGenerator.string(50),
        },
        {
          "registro": faker.guid.guid(),
          "pc": faker.randomGenerator.string(6),
          "situacao": "A",
          "particao": faker.randomGenerator.integer(1).toString(),
          "interacao": "I",
          "armado": faker.randomGenerator.string(1),
          "ex_user_alarme": faker.randomGenerator.integer(6).toString(),
          "endereco": faker.address.streetAddress(),
          "cliente": faker.person.name(),
          "descricao": faker.randomGenerator.string(50),
        }
      ];

  static Map makeInvalidJson() => {'invalid_key': 'invalid_value'};

  static List<Map> makeInvalidList() => [makeInvalidJson(), makeInvalidJson()];

  static Map makeZonesListJson() => {
        "resposta": "sucesso",
        "mensagem": [
          {
            "registro": faker.guid.guid(),
            "descricao": faker.randomGenerator.string(50),
            "auxiliar": faker.randomGenerator.string(1)
          },
          {
            "registro": faker.guid.guid(),
            "descricao": faker.randomGenerator.string(50),
            "auxiliar": faker.randomGenerator.string(1)
          }
        ]
      };
}
