import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:path/to/sample_repository.dart';

import 'login_util.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    await Firebase.initializeApp();
  });

  tearDown(() async {});

  Future<void> deleteDocAtFireStorage(String userId) async {
    final storageReference = FirebaseStorage.instance.ref();
    await storageReference
        .child('path/to/user/file')
        .delete();
  }

  group('sample repository test', () {
    testWidgets('happy case', (WidgetTester tester) async {
      // Login
      String _userId = await LoginUtil.login(tester);

      // Get Data
      SampleData sampleData = await SampleRepository.get();

      // Test
      expect(sampleData.get('sample'), 'sampleDataContent');

      // Delete Data Made By This Test
      await deleteDocAtFireStorage(_userId);
    });
  });
}

