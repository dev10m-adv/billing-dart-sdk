// import 'package:http/http.dart' show Response;
// import 'package:http/testing.dart';
// import 'package:test/test.dart';
// import 'package:billing_sdk/billing_sdk.dart';

// void main() {
//   group('HealthService', () {
//     test('check() returns HealthStatus', () async {
//       final client = MockClient((_) async => Response(
//             '{"status":"ok","timestamp":"2026-05-14T00:00:00Z"}',
//             200,
//             headers: {'content-type': 'application/json'},
//           ));

//       final billing = BillingClient(baseUrl: 'http://test', httpClient: client);
//       final health = await billing.health.check();

//       expect(health.status, equals('ok'));
//       expect(health.timestamp, contains('2026'));
//       billing.dispose();
//     });
//   });

//   group('ProductService', () {
//     test('list() parses list correctly', () async {
//       final client = MockClient((_) async => Response(
//             '{"data":[{"id":1,"name":"Pro","isActive":true},'
//             '{"id":2,"name":"Enterprise","isActive":true}]}',
//             200,
//             headers: {'content-type': 'application/json'},
//           ));

//       final billing = BillingClient(baseUrl: 'http://test', httpClient: client);
//       final products = await billing.products.list();

//       expect(products.length, equals(2));
//       expect(products.first.name, equals('Pro'));
//       billing.dispose();
//     });
//   });

//   group('BillingApiException', () {
//     test('is thrown on 4xx responses', () async {
//       final client = MockClient((_) async => Response(
//             '{"message":"Not found"}',
//             404,
//             headers: {'content-type': 'application/json'},
//           ));

//       final billing = BillingClient(baseUrl: 'http://test', httpClient: client);

//       expect(
//         () => billing.products.get(999),
//         throwsA(
//           isA<BillingApiException>()
//               .having((e) => e.statusCode, 'statusCode', 404)
//               .having((e) => e.message, 'message', 'Not found'),
//         ),
//       );
//       billing.dispose();
//     });
//   });

//   group('PromoCodeService', () {
//     test('validate() returns raw map', () async {
//       final client = MockClient((_) async => Response(
//             '{"success":true,"data":{"valid":true,"discountType":"percent","discountValue":20}}',
//             200,
//             headers: {'content-type': 'application/json'},
//           ));

//       final billing = BillingClient(baseUrl: 'http://test', httpClient: client);
//       final result = await billing.promoCodes.validate('SAVE20');

//       expect(result['success'], isTrue);
//       billing.dispose();
//     });
//   });
// }
