import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sentinel/helpers/auth.dart'; // Update this import to match your project structure

// This will generate the mock class
@GenerateNiceMocks([MockSpec<FirebaseAuthServices>(), MockSpec<User>()])
import 'widget_test.mocks.dart';

void main() {
  late MockFirebaseAuthServices mockAuthServices;
  late MockUser mockUser;

  setUp(() {
    mockAuthServices = MockFirebaseAuthServices();
    mockUser = MockUser();
  });

  group('FirebaseAuthServices Tests', () {
    test('signInWithEmailAndPassword should call Firebase method', () async {
      // Arrange
      when(mockAuthServices.signInWithEmailAndPassword(
        email: 'test@example.com',
        password: 'password123',
      )).thenAnswer((_) async => {});

      // Act
      await mockAuthServices.signInWithEmailAndPassword(
        email: 'test@example.com',
        password: 'password123',
      );

      // Assert
      verify(mockAuthServices.signInWithEmailAndPassword(
        email: 'test@example.com',
        password: 'password123',
      )).called(1);
    });

    test('createUserWithEmailAndPassword should call Firebase method', () async {
      // Arrange
      when(mockAuthServices.createUserWithEmailAndPassword(
        email: 'test@example.com',
        password: 'password123',
      )).thenAnswer((_) async => {});

      // Act
      await mockAuthServices.createUserWithEmailAndPassword(
        email: 'test@example.com',
        password: 'password123',
      );

      // Assert
      verify(mockAuthServices.createUserWithEmailAndPassword(
        email: 'test@example.com',
        password: 'password123',
      )).called(1);
    });

    test('checkVerificationStatus should return correct value', () {
      // Arrange
      when(mockAuthServices.currentUser).thenReturn(mockUser);
      when(mockUser.emailVerified).thenReturn(true);
      when(mockAuthServices.checkVerificationStatus()).thenReturn(true);

      // Act
      final result = mockAuthServices.checkVerificationStatus();

      // Assert
      expect(result, true);
    });

    test('signOut should call Firebase method', () async {
      // Arrange
      when(mockAuthServices.signOut()).thenAnswer((_) async => {});

      // Act
      await mockAuthServices.signOut();

      // Assert
      verify(mockAuthServices.signOut()).called(1);
    });

    test('sendEmailVerification should call Firebase method', () async {
      // Arrange
      when(mockAuthServices.sendEmailVerification()).thenAnswer((_) async => {});

      // Act
      await mockAuthServices.sendEmailVerification();

      // Assert
      verify(mockAuthServices.sendEmailVerification()).called(1);
    });
  });
}