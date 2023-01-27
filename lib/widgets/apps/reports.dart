import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReportsWidget extends ConsumerWidget {
  const ReportsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DecoratedBox(
        decoration: const BoxDecoration(color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: SelectionArea(
            child: ListView(
              children: [
                Text('Aplicacion de reportes, con interfaz basada en datos, implementada con flutter',
                    style: textTheme.titleLarge, textAlign: TextAlign.center),
                const SizedBox(height: 32),
                const Text(
                    'Esta es un a aplicacion, desarrollada para una empresa ecuatoriana, que desea facilitar la creacion de reportes, para sus clientes.\nLa aplicacion tiene una interfaz basada en datos, esto quiere decir que los controles, se crean dinamicamente, en base a los datos que se almacenan en la base de datos y se envian a traves de una api REST. Esto supone una gran ventaja para la empresa, ya que pueden crear diferentes reportes, sin necesidad de modificar el codigo fuente de la aplicacion. ',
                    //    style: textTheme.bodyLarge,
                    textAlign: TextAlign.justify),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.all(32),
                  child: DecoratedBox(
                    decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const Text(
                              'Por ejemplo: \n\nEl codigo a continuacion muestra el codigo que recibe la aplicacion para generar las columnas del reporte, se especifica el tipo de tado, etiqueta, si es numerico, la mascara de como debe lucir dicho numero en la interfaz.\n'),
                          Image.asset('assets/img/respuestaapi1.jpeg'),
                          const Text(
                              '\n\n Esto en cojuncion con la respuesta de otros endpoinst, puede visualizarse asi:\n'),
                          Image.asset('assets/img/interfaz1.jpeg'),
                        ],
                      ),
                    ),
                  ),
                ),
                const Text(
                    'La parte de la interfaz que permite seleccionar que reporte se desea generar, y la seleccion misma de cada uno de los diferentes parametros y sus tipos, se hacen basados en datos. Tanto si es un parametro de fecha, o un combo box junto a sus posibles opciones, o el texto que ingresa el usuario final y sus valores iniciales, junto a las validaciones que se deben realizar en cada uno de estos es basado en las datos que la aplicacion recibe.\n'),
                Image.asset('assets/img/interfaz2.jpeg'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
