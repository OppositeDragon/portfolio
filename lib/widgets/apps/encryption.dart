import 'dart:io';

import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:file_picker/file_picker.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final stringKeyProvider = StateProvider<String>((ref) {
  return 'Llave de cifrado de 32 caracters';
});

class EncrytionWidget extends ConsumerWidget {
  const EncrytionWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stringKey = ref.watch(stringKeyProvider);
    return DecoratedBox(
      decoration: const BoxDecoration(color: Colors.white70),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('KEY: '),
                Flexible(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 500),
                    child: TextFormField(
                      maxLength: 32,
                      initialValue: stringKey,
                      decoration: const InputDecoration(border: OutlineInputBorder()),
                      autovalidateMode: AutovalidateMode.always,
                      validator: (text) {
                        if (text == null || text.length != 32) {
                          return 'Debe tener 32 caracteres';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        if (value.length == 32) ref.read(stringKeyProvider.notifier).state = value;
                      },
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 4),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisExtent: 300),
                cacheExtent: 200,
                itemCount: 4,
                itemBuilder: (context, index) => SizedBox(
                  height: 200,
                  child: Card(
                    elevation: 16,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: ChildWidget(index, stringKey),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChildWidget extends StatefulWidget {
  const ChildWidget(this.index, this.stringKey, {super.key});
  final int index;
  final String stringKey;

  @override
  State<ChildWidget> createState() => _ChildWidgetState();
}

class _ChildWidgetState extends State<ChildWidget> {
  String plainText = 'Texto a ser encriptado';
  String encryptedText64 = '';
  String decryptedText = '';
  FilePickerResult? picked;
  encrypt.Encrypted? encriptedfile;
  String ext = '';
  final iv = encrypt.IV.fromLength(16);

  ///Descarga el archivo al directorio de descargas por defecto que usa el
  ///navegador
  void saveFileWeb(List<int> bytes, String estado) async {
    Uint8List bytes8 = Uint8List.fromList(bytes);
    final dtn = DateTime.now();
    await FileSaver.instance.saveFile(
      '$estado--${dtn.year}-${dtn.month}-${dtn.day}_${dtn.hour}-${dtn.minute}-${dtn.second}-${dtn.millisecond}',
      bytes8,
      ext,
    );
  }

  ///Guarda archivo en un carpeta seleccionada por el usuario
  ///
  ///Toma el reporte y el contenido del archivo como lista de bytes.
  ///Retorna una cadena con el directorio y nombre del archivo.
  Future<String> saveFile(List<int> bytes, String estado) async {
    final dtn = DateTime.now();
    String? path = await FilePicker.platform.getDirectoryPath();
    final file = File(
        '$path/$estado--${dtn.year}-${dtn.month}-${dtn.day}_${dtn.hour}-${dtn.minute}-${dtn.second}-${dtn.millisecond}.$ext');
    final finishedfile = await file.writeAsBytes(bytes);
    return finishedfile.path;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final key = encrypt.Key.fromUtf8(widget.stringKey);
    final encrypter = encrypt.Encrypter(
      encrypt.AES(key),
    );
    switch (widget.index) {
      case 0:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),
            Text('Encriptar texto', style: textTheme.titleLarge),
            const SizedBox(height: 16),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              initialValue: plainText,
              decoration: const InputDecoration(border: OutlineInputBorder()),
              maxLines: 3,
              onChanged: (value) {
                setState(() => plainText = value);
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Nada por encriptar';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            if (plainText.isNotEmpty)
              Expanded(
                child: SingleChildScrollView(
                  child: SelectableText(encrypter.encrypt(plainText, iv: iv).base64),
                ),
              ),
            const SizedBox(height: 4),
          ],
        );
      case 1:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Encriptar archivo', style: textTheme.titleLarge),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.upload_file),
              label: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Subir archivo y encriptar'),
              ),
              onPressed: () async {
                final FilePickerResult? picked = await FilePicker.platform.pickFiles(withData: true);
                if (picked != null) {
                  var nameParts = picked.files.first.name.split('.');
                  setState(() {
                    ext = nameParts.last;
                    encriptedfile = encrypter.encryptBytes(picked.files.first.bytes!.toList(), iv: iv);
                  });
                  if (kIsWeb) {
                    saveFileWeb(encriptedfile!.bytes, 'Encriptado');
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Archivo descargado'),
                          duration: Duration(milliseconds: 1500),
                        ),
                      );
                    }
                  } else {
                    try {
                      final filePath = await saveFile(encriptedfile!.bytes, 'Encriptado');
                      if (!mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Archivo guardado: $filePath'),
                          duration: const Duration(milliseconds: 2500),
                        ),
                      );
                    } catch (e) {
                      debugPrint(e.toString());
                    }
                  }
                } else {
                  setState(() {
                    ext = '';
                  });
                }
              },
            ),
            if (encriptedfile != null)
              Expanded(child: SingleChildScrollView(child: SelectableText(encriptedfile!.base64)))
          ],
        );
      case 2:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),
            Text('Desencriptar texto', style: textTheme.titleLarge),
            const SizedBox(height: 16),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: const InputDecoration(border: OutlineInputBorder(), hintText: 'Texto a desencriptar'),
              maxLines: 3,
              onChanged: (value) {
                setState(() => encryptedText64 = value);
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Nada por desencriptar';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            Builder(builder: (context) {
              try {
                return Expanded(
                  child: SingleChildScrollView(
                    child: SelectableText(encrypter.decrypt64(encryptedText64, iv: iv)),
                  ),
                );
              } catch (e) {
                return encryptedText64.isNotEmpty
                    ? Text('$e', style: const TextStyle(color: Colors.red, fontSize: 11))
                    : const SizedBox.shrink();
              }
            }),
            const SizedBox(height: 4),
          ],
        );
      case 3:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Desencriptar archivo', style: textTheme.titleLarge),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.upload_file),
              label: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Subir archivo encriptado'),
              ),
              onPressed: () async {
                final FilePickerResult? picked = await FilePicker.platform.pickFiles(withData: true);
                if (picked != null) {
                  var nameParts = picked.files.first.name.split('.');
                  setState(() => ext = nameParts.last);
                  final archivoDesencriptado =
                      encrypt.AES(key).decrypt(encrypt.Encrypted(picked.files.first.bytes!), iv: iv);
                  if (kIsWeb) {
                    saveFileWeb(archivoDesencriptado, 'Desencriptado');
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Archivo descargado'),
                          duration: Duration(milliseconds: 1500),
                        ),
                      );
                    }
                  } else {
                    try {
                      final filePath = await saveFile(archivoDesencriptado, 'Desencriptado');
                      if (!mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Archivo guardado: $filePath'),
                          duration: const Duration(milliseconds: 2500),
                        ),
                      );
                    } catch (e) {
                      debugPrint(e.toString());
                    }
                  }
                } else {
                  setState(() {
                    ext = '';
                  });
                }
              },
            ),
          ],
        );
      default:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('...${widget.index}'),
          ],
        );
    }
  }
}
