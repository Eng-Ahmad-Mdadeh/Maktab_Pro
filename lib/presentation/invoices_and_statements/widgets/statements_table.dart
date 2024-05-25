// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:maktab/presentation/resources/app_colors.dart';

import '../../widgets/get_data_cell.dart';

class StatementsTable extends StatelessWidget {
  StatementsTable({super.key});

  final List<Map<String, String>> data = [
    {
      'date': 'خصم مبلغ مسترجع 31/12/2023 لحجز رقم 2903746 مكتب 1 - وحدة 1  ',
      'amount': '-3000.00',
      'balance': '-103.22',
    },
    {
      'date': 'خصم مبلغ مسترجع 31/12/2023 لحجز رقم 2903746 مكتب 1 - وحدة 1  ',
      'amount': '-3000.00',
      'balance': '-103.22',
    },
    {
      'date': 'خصم مبلغ مسترجع 31/12/2023 لحجز رقم 2903746 مكتب 1 - وحدة 1  ',
      'amount': '-3000.00',
      'balance': '-103.22',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      child: DataTable(
        dividerThickness: 0,
        dataRowMaxHeight: double.infinity,
        border: TableBorder.all(color: AppColors.softAsh, width: 0),
        dataTextStyle: Theme.of(context).textTheme.bodyLarge,
        columns: const <DataColumn>[
          DataColumn(
            label: Expanded(
              child: Text(
                'البيان والتاريخ',
              ),
            ),
          ),
          DataColumn(
            label: Expanded(
              child: Text(
                'المبلغ',
              ),
            ),
          ),
          DataColumn(
            label: Expanded(
              child: Text(
                'الرصيد',
              ),
            ),
          ),
        ],
        rows: List.generate(
          data.length,
          (index) => DataRow(
            cells: <DataCell>[
              getDataCell(
                text: data[index]['date'].toString(),
                textColor: AppColors.slateGray,
              ),
              getDataCell(
                text: data[index]['amount'].toString(),
                textColor: AppColors.deepOrange,
              ),
              getDataCell(
                text: data[index]['balance'].toString(),
                textColor: AppColors.forestTeal,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//   DataCell getDataCell({
//     required BuildContext context,
//     required String text,
//     required Color textColor,
//   }) {
//     return DataCell(
//       Padding(
//         padding: EdgeInsets.symmetric(vertical: 7.v),
//         child: Text(
//           text,
//           style:
//               Theme.of(context).textTheme.bodyLarge!.copyWith(color: textColor),
//         ),
//       ),
//     );
//   }
// }
