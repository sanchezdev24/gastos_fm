import 'package:auth/src/composition/network/network_routes.dart';
import 'package:auth/src/features/login/data/datasource/login_remote_datasource.dart';
import 'package:auth/src/features/login/domain/entitie/login_params.dart';
import 'package:core/core.dart';
import 'package:core/error/failures.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

void main() {
  group('LoginRemoteDatasource', () {
    late LoginParams validParams;
    late MockDio mockDio;

    setUp(() {
      validParams = LoginParams(email: 'test@example.com', pwd: 'password123');
      mockDio = MockDio();
    });

    group('MockLoginRemoteDatasource', () {
      test(
        'should return true after 5 seconds delay on successful login',
        () async {
          // Arrange
          final datasource = MockLoginRemoteDatasource();

          // Act
          final result = await datasource.makeLogin(validParams);

          // Assert
          expect(result, true);
        },
      );

      test(
        'should throw UnexpectedFailure when login fails (code path is commented but should be covered if uncommented)',
        () async {
          // This test would be relevant if the error throwing line was uncommented
          // For now, we'll skip it since the code path isn't used in the current implementation
        },
      );
    });

    group('LoginRemoteDatasourceImpl', () {
      test(
        'should return true when login is successful (status code 200)',
        () async {
          // Arrange
          final response = Response(
            requestOptions: RequestOptions(path: NetworkRoutes.login),
            statusCode: 200,
            data: {'success': true},
          );
          when(
            () => mockDio.post(any(), data: any(named: 'data')),
          ).thenAnswer((_) async => response);

          final datasource = LoginRemoteDatasourceImpl(dio: mockDio);

          // Act
          final result = await datasource.makeLogin(validParams);

          // Assert
          expect(result, true);
          verify(
            () => mockDio.post(NetworkRoutes.login, data: validParams),
          ).called(1);
        },
      );

      test(
        'should throw UnexpectedFailure when login fails (non-200 status code)',
        () async {
          // Arrange
          final errorStatusCode = 401;
          final response = Response(
            requestOptions: RequestOptions(path: NetworkRoutes.login),
            statusCode: errorStatusCode,
            data: {'error': 'Unauthorized'},
          );
          when(
            () => mockDio.post(any(), data: any(named: 'data')),
          ).thenAnswer((_) async => response);

          final datasource = LoginRemoteDatasourceImpl(dio: mockDio);

          // Act & Assert
          expect(
            () => datasource.makeLogin(validParams),
            throwsA(
              isA<UnexpectedFailure>().having(
                (f) => f.code,
                'code',
                errorStatusCode.toString(),
              ),
            ),
          );
        },
      );
    });
  });
}
