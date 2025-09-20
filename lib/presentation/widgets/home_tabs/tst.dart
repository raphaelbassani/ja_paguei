import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';

class ImportButton extends StatelessWidget {
  final Database db;
  const ImportButton({super.key, required this.db});

  Future<String?> _getExportPath() async {
    if (Platform.isAndroid) {
      // Pede permissão para ler armazenamento
      var status = await Permission.storage.request();
      if (!status.isGranted) return null;

      final dirs = await getExternalStorageDirectories(
        type: StorageDirectory.downloads,
      );
      if (dirs == null || dirs.isEmpty) return null;
      return "${dirs.first.path}/users_export.json";
    } else {
      // iOS → Documents
      final docs = await getApplicationDocumentsDirectory();
      return "${docs.path}/users_export.json";
    }
  }

  Future<void> _importJsonToDb(BuildContext context) async {
    try {
      final path = await _getExportPath();
      if (path == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "❌ Não foi possível acessar o arquivo.\n❌ Could not access the file.",
            ),
          ),
        );
        return;
      }

      final file = File(path);
      if (!await file.exists()) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "📂 Arquivo não encontrado em Downloads/Documents.\n📂 File not found.",
            ),
          ),
        );
        return;
      }

      // 1. Ler JSON
      String jsonString = await file.readAsString();
      List<dynamic> jsonData = jsonDecode(jsonString);

      // 2. Importar para o banco
      for (var item in jsonData) {
        await db.insert(
          "users",
          Map<String, dynamic>.from(item),
          conflictAlgorithm: ConflictAlgorithm.replace, // evita duplicados
        );
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("✅ Importação concluída!\n✅ Import completed!"),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("⚠️ Erro ao importar: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.upload),
      label: const Text("Importar do JSON"),
      onPressed: () => _importJsonToDb(context),
    );
  }
}
