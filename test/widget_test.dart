import 'package:biodata/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('menampilkan seluruh informasi biodata', (tester) async {
    await tester.pumpWidget(const BiodataApp());

    expect(find.text('BIODATA DIRI'), findsOneWidget);
    expect(find.text(namaLengkap), findsWidgets);
    expect(find.text(nim), findsWidgets);
    expect(find.text(kelas), findsWidgets);
    expect(find.text(tempatTanggalLahir), findsOneWidget);
    expect(find.text('Tempat, Tanggal Lahir'), findsOneWidget);
  });
}
