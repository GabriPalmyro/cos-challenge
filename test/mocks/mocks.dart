import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements BaseClient {}

const carInfoResponse = '''{
  "id": 123123,
  "feedback": "Please modify the price.",
  "valuatedAt": "2023-01-05T14:08:40.456Z",
  "requestedAt": "2023-01-05T14:08:40.456Z",
  "createdAt": "2023-01-05T14:08:40.456Z",
  "updatedAt": "2023-01-05T14:08:42.153Z",
  "make": "Toyota",
  "model": "GT 86 Basis",
  "externalId": "DE003-018601450020008",
  "_fk_sellerUser": "25475e37-6973-483b-9b15-cfee721fc29f",
  "price": 150,
  "positiveCustomerFeedback": true,
  "_fk_uuid_auction": "3e255ad2-36d4-4048-a962-5e84e27bfa6e",
  "inspectorRequestedAt": "2023-01-05T14:08:40.456Z",
  "origin": "AUCTION",
  "estimationRequestId": "3a295387d07f"
}''';

const carInfoErrorResponse = '''{
  "id": 123123,
  "feedback": "Please modify the price.",
  "valuatedAt": "2023-01-05T14:08:40.456Z",
  "requestedAt": "2023-01-05T14:08:40.456Z",
  "createdAt": "2023-01-05T14:08:40.456Z",
  "updatedAt": "2023-01-05T14:08:42.153Z",
  "make": "Toyota",
  "model": "GT 86 Basis",
  "externalId": "DE003-018601450020008"
  "_fk_sellerUser": "25475e37-6973-483b-9b15-cfee721fc29f",
  "price": 150,
  "positiveCustomerFeedback": true,
  "_fk_uuid_auction": "3e255ad2-36d4-4048-a962-5e84e27bfa6e",
  "inspectorRequestedAt": "2023-01-05T14:08:40.456Z",
  "origin": "AUCTION",
  "estimationRequestId": "3a295387d07f"
}''';

const cachedResultResponse = '''
[
  {
    "id": 123123,
    "feedback": "Please modify the price.",
    "valuatedAt": "2023-01-05T14:08:40.456Z",
    "requestedAt": "2023-01-05T14:08:40.456Z",
    "createdAt": "2023-01-05T14:08:40.456Z",
    "updatedAt": "2023-01-05T14:08:42.153Z",
    "make": "Toyota",
    "model": "GT 86 Basis",
    "externalId": "DE003-018601450020008",
    "_fk_sellerUser": "25475e37-6973-483b-9b15-cfee721fc29f",
    "price": 150,
    "positiveCustomerFeedback": true,
    "_fk_uuid_auction": "3e255ad2-36d4-4048-a962-5e84e27bfa6e",
    "inspectorRequestedAt": "2023-01-05T14:08:40.456Z",
    "origin": "AUCTION",
    "estimationRequestId": "3a295387d07f"
  },
   {
    "id": 123123,
    "feedback": "Please modify the price.",
    "valuatedAt": "2023-01-05T14:08:40.456Z",
    "requestedAt": "2023-01-05T14:08:40.456Z",
    "createdAt": "2023-01-05T14:08:40.456Z",
    "updatedAt": "2023-01-05T14:08:42.153Z",
    "make": "Toyota",
    "model": "GT 86 Basis",
    "externalId": "DE003-018601450020008",
    "_fk_sellerUser": "25475e37-6973-483b-9b15-cfee721fc29f",
    "price": 150,
    "positiveCustomerFeedback": true,
    "_fk_uuid_auction": "3e255ad2-36d4-4048-a962-5e84e27bfa6e",
    "inspectorRequestedAt": "2023-01-05T14:08:40.456Z",
    "origin": "AUCTION",
    "estimationRequestId": "3a295387d07f"
  }
]
''';

const multipleOptionResponse = '''
[
    {
        "make": "Toyota",
        "model": "GT 86 Basis",
        "containerName": "DE - Cp2 2.0 EU5, 2012 - 2015",
        "similarity": 85,
        "externalId": "DE001-018601450020001"
    },
    {
        "make": "Toyota",
        "model": "GT 86 Basis",
        "containerName": "DE - Cp2 2.0 EU6, (EURO 6), 2015 - 2017",
        "similarity": 50,
        "externalId": "DE002-018601450020001"
    },
    {
        "make": "Toyota",
        "model": "GT 86 Basis",
        "containerName": "DE - Cp2 2.0 EU6, Basis, 2017 - 2020",
        "similarity": 0,
        "externalId": "DE003-018601450020001"
    }
]''';
