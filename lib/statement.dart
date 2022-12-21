import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'dart:math' as math;

class Statement extends StatefulWidget {
  const Statement({Key key}) : super(key: key);

  @override
  State<Statement> createState() => _StatementState();
}

// ListView(
// children: [
// StatementDatePage(),
// TablePage(),
// ],
// ),
class _StatementState extends State<Statement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Statement",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        body: NestedScrollView(
      physics: NeverScrollableScrollPhysics(),
      headerSliverBuilder: (context, isScolled) {
        return [

          SliverAppBar(
            collapsedHeight:
                AppDimension.padding(figPadding: 800, context: context), // 500
            expandedHeight:
                AppDimension.padding(figPadding: 800, context: context), // 500
            flexibleSpace: Column(
              children: [

                StatementDatePage(),
              ],
            ),
          )
        ];
      },
      body: TablePage(),
    ));
  }
}



// StatementDatePage Components ---------------------------------------------------------------------

class StatementDatePage extends StatefulWidget {
  const StatementDatePage({Key key}) : super(key: key);

  @override
  State<StatementDatePage> createState() => _StatementDatePageState();
}

class _StatementDatePageState extends State<StatementDatePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: AppDimension.padding(figPadding: 12, context: context),
        ),
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
          ),
          padding: EdgeInsets.all(
              AppDimension.padding(figPadding: 12, context: context)),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DateTimeCard(),

              AppCustomTextLebel(
                lebel: "STATEMENT DATE :",
                bold: true,
                fontSize:
                    AppDimension.fontSize(figmaFontSize: 16, context: context),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  "20-11-200   TO   30-11-2022",
                  style: TextStyle(
                      color: Color(0xFF0B4461),
                      fontSize: AppDimension.fontSize(
                          figmaFontSize: 16, context: context),
                      fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(
                height: AppDimension.padding(figPadding: 16, context: context),
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: AppDimension.gridViewRatio(76, 158),
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0,
                ),
                itemCount: dailyList.length,
                itemBuilder: (context, index) => CustomGridItemWidget(
                  image: dailyList[index].image,
                  title: dailyList[index].title,
                  amount: dailyList[index].amount,
                  color: dailyList[index].color,
                ),
              ),

              // Row of 3 boxes
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: CustomGridItemWidget(
                      // width: AppDimension.padding(figPadding: 93, context: context),
                      // height: AppDimension.padding(figPadding: 83, context: context),
                      title: "Merchant Balance",
                      amount: "5920",
                      color: Color(0xffF8CBAD),
                    ),
                  ),
                  CustomGridItemWidget(
                    // width: AppDimension.padding(figPadding: 93, context: context),
                    // height: AppDimension.padding(figPadding: 83, context: context),
                    title: "Total Merchant Withdraw",
                    amount: "0",
                    color: Color(0xffF8CBAD),
                  ),
                  CustomGridItemWidget(
                    // width: AppDimension.padding(figPadding: 93, context: context),
                    // height: AppDimension.padding(figPadding: 83, context: context),
                    title: "Total Merchant Withdraw",
                    amount: "19370",
                    color: Color(0xffF8CBAD),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}

// Table Components ----------------------------------------------------------------------------------

class TablePage extends StatefulWidget {
  @override
  State<TablePage> createState() => _TablePageState();
}

class _TablePageState extends State<TablePage> {
  // const TablePage({Key key}) : super(key: key);
  List<Transaction> transactions;
  TransactionDataSource transactionDataSource;

  @override
  void initState() {
    transactions = getTransactionData();
    transactionDataSource = TransactionDataSource(transactions);
    super.initState();
  }

  int conter = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SfDataGridTheme(
      data: SfDataGridThemeData(
        gridLineColor: Colors.white60, gridLineStrokeWidth: 1.0,
        // rowHoverColor: Colors.yellow,
        // rowHoverTextStyle: TextStyle(
        //   color: Colors.red,
        //   fontSize: 14,
        // )
      ),
      child: SfDataGrid(
        source: transactionDataSource,
        frozenColumnsCount: 1,
        footerFrozenColumnsCount: 2,
        columns: [

          GridColumn(
              columnName: 'date',
              label: Container(
                color: Color(0xFF0B4461),
                padding: EdgeInsets.symmetric(horizontal: 6.0),
                alignment: Alignment.centerRight,
                child: Text(
                  'Date & Time',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              )),

          // ignore: deprecated_member_use
          GridColumn(
              columnName: 'Invoice No',
              label: Container(
                color: Color(0xFF0B4461),
                padding: EdgeInsets.symmetric(horizontal: 6.0),
                alignment: Alignment.centerRight,
                child: Text(
                  'Invoice No',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              )),
          GridColumn(
              columnName: 'customerName',
              label: Container(
                color: Color(0xFF0B4461),
                padding: EdgeInsets.symmetric(horizontal: 6.0),
                alignment: Alignment.centerRight,
                child: Text(
                  'Cus. Name',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              )),
          GridColumn(
              columnName: 'serviceType',
              label: Container(
                color: Color(0xFF0B4461),
                padding: EdgeInsets.symmetric(horizontal: 6.0),
                alignment: Alignment.centerRight,
                child: Text(
                  'Del service type',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              )),
          GridColumn(
              columnName: 'paymentType',
              label: Container(
                color: Color(0xFF0B4461),
                padding: EdgeInsets.symmetric(horizontal: 6.0),
                alignment: Alignment.centerRight,
                child: Text(
                  'Payment Type',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              )),
          GridColumn(
              columnName: 'cashRec',
              label: Container(
                color: Color(0xFF0B4461),
                padding: EdgeInsets.symmetric(horizontal: 6.0),
                alignment: Alignment.centerRight,
                child: Text(
                  'Cash Rec & collect AMT',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              )),
          GridColumn(
              columnName: 'withdrawCharges',
              label: Container(
                color: Color(0xFF0B4461),
                padding: EdgeInsets.symmetric(horizontal: 6.0),
                alignment: Alignment.centerRight,
                child: Text(
                  'W/D for charges',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              )),
          GridColumn(
              columnName: 'balance',
              width: 60,
              label: Container(
                color: Color(0xFF0B4461),
                padding: EdgeInsets.symmetric(horizontal: 6.0),
                alignment: Alignment.centerRight,
                child: Text(
                  'Balance',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              )),
          GridColumn(
              columnName: 'withdraw',
              width: 60,
              label: Container(
                color: Color(0xFF0B4461),
                padding: EdgeInsets.symmetric(horizontal: 6.0),
                alignment: Alignment.centerRight,
                child: Text(
                  'W/D By MER',
                  maxLines: 2,
                  // overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              )),
        ],
      ),
    );
  }
}

// table input
List<Transaction> getTransactionData() {
  return [
    Transaction('12.12.12', 45114244, 'Md.Sohal', 'Express Delivery',
        'Cash/Bkash', 700, 800, 5920, 4180),
    Transaction('12.12.12', 45114244, 'Md.Sohal', 'Express Delivery',
        'Cash/Bkash', 700, 800, 5920, 4180),
    Transaction('12.12.12', 45114244, 'Md.Sohal', 'Express Delivery',
        'Cash/Bkash', 700, 800, 5920, 4180),
    Transaction('12.12.12', 45114244, 'Md.Sohal', 'Express Delivery',
        'Cash/Bkash', 700, 800, 5920, 4180),
    Transaction('12.12.12', 45114244, 'Md.Sohal', 'Express Delivery',
        'Cash/Bkash', 700, 800, 5920, 4180),
    Transaction('12.12.12', 45114244, 'Md.Sohal', 'Express Delivery',
        'Cash/Bkash', 700, 800, 5920, 4180),
    Transaction('12.12.12', 45114244, 'Md.Sohal', 'Express Delivery',
        'Cash/Bkash', 700, 800, 5920, 4180),
    Transaction('12.12.12', 45114244, 'Md.Sohal', 'Express Delivery',
        'Cash/Bkash', 700, 800, 5920, 4180),
    Transaction('12.12.12', 45114244, 'Md.Sohal', 'Express Delivery',
        'Cash/Bkash', 700, 800, 5920, 4180),
    Transaction('12.12.12', 45114244, 'Md.Sohal', 'Express Delivery',
        'Cash/Bkash', 700, 800, 5920, 4180),
    Transaction('12.12.12', 45114244, 'Md.Sohal', 'Express Delivery',
        'Cash/Bkash', 700, 800, 5920, 4180),
    Transaction('12.12.12', 45114244, 'Md.Sohal', 'Express Delivery',
        'Cash/Bkash', 700, 800, 5920, 4180),
    Transaction('12.12.12', 45114244, 'Md.Sohal', 'Express Delivery',
        'Cash/Bkash', 700, 800, 5920, 4180),
    Transaction('12.12.12', 45114244, 'Md.Sohal', 'Express Delivery',
        'Cash/Bkash', 700, 800, 5920, 4180),
    Transaction('12.12.12', 45114244, 'Md.Sohal', 'Express Delivery',
        'Cash/Bkash', 700, 800, 5920, 4180),
    Transaction('12.12.12', 45114244, 'Md.Sohal', 'Express Delivery',
        'Cash/Bkash', 700, 800, 5920, 4180),
    Transaction('12.12.12', 45114244, 'Md.Sohal', 'Express Delivery',
        'Cash/Bkash', 700, 800, 5920, 4180),
    Transaction('12.12.12', 45114244, 'Md.Sohal', 'Express Delivery',
        'Cash/Bkash', 700, 800, 5920, 4180),
    Transaction('12.12.12', 45114244, 'Md.Sohal', 'Express Delivery',
        'Cash/Bkash', 700, 800, 5920, 4180),
    Transaction('12.12.12', 45114244, 'Md.Sohal', 'Express Delivery',
        'Cash/Bkash', 700, 800, 5920, 4180),
    Transaction('12.12.12', 45114244, 'Md.Sohal', 'Express Delivery',
        'Cash/Bkash', 700, 800, 5920, 4180),
    Transaction('12.12.12', 45114244, 'Md.Sohal', 'Express Delivery',
        'Cash/Bkash', 700, 800, 5920, 4180),
    Transaction('12.12.12', 45114244, 'Md.Sohal', 'Express Delivery',
        'Cash/Bkash', 700, 800, 5920, 4180),
    Transaction('12.12.12', 45114244, 'Md.Sohal', 'Express Delivery',
        'Cash/Bkash', 700, 800, 5920, 4180),
  ];
}

class TransactionDataSource extends DataGridSource {
  int count = -1;
  TransactionDataSource(List<Transaction> transactions) {
    dataGridRows = transactions
        .map<DataGridRow>((dataGridRow) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'date', value: dataGridRow.date),
              DataGridCell<int>(
                  columnName: 'invoiceNo', value: dataGridRow.invoiceNo),
              DataGridCell<String>(
                  columnName: 'customerName', value: dataGridRow.customerName),
              DataGridCell<String>(
                  columnName: 'serviceType', value: dataGridRow.serviceType),
              DataGridCell<String>(
                  columnName: 'paymentType', value: dataGridRow.paymentType),
              DataGridCell<int>(
                  columnName: 'cashRec', value: dataGridRow.cashRec),
              DataGridCell<int>(
                  columnName: 'withdrawCharges',
                  value: dataGridRow.withdrawCharges),
              DataGridCell<int>(
                  columnName: 'balance', value: dataGridRow.balance),
              DataGridCell<int>(
                  columnName: 'withdraw', value: dataGridRow.withdraw),
            ]))
        .toList();
  }

  List<DataGridRow> dataGridRows;
  @override
  List<DataGridRow> get rows => dataGridRows;
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    count++;
    // final colorRow=Color(0xffD9E1F2);
    return DataGridRowAdapter(
        color: Colors.white60, //Color(0xffD9E1F2),

        cells: row.getCells().map<Widget>((dataGridCell) {
          Color getRowColor() {
            if ((dataGridCell.columnName == 'balance' && count % 2 == 0) ||
                (dataGridCell.columnName == 'invoiceNo' && count % 2 == 0) ||
                (dataGridCell.columnName == 'serviceType' && count % 2 == 0) ||
                (dataGridCell.columnName == 'cashRec' && count % 2 == 0) ||
                (dataGridCell.columnName == 'invoiceNo' && count % 2 == 0) ||
                (dataGridCell.columnName == 'invoiceNo' && count % 2 == 0) ||
                (dataGridCell.columnName == 'invoiceNo' && count % 2 == 0)) {
              return Color(0xffE3E3E3);
            }

            if ((dataGridCell.columnName == 'balance') ||
                (dataGridCell.columnName == 'invoiceNo') ||
                (dataGridCell.columnName == 'serviceType') ||
                (dataGridCell.columnName == 'cashRec') ||
                (dataGridCell.columnName == 'invoiceNo') ||
                (dataGridCell.columnName == 'invoiceNo') ||
                (dataGridCell.columnName == 'invoiceNo')) {
              return Color(0xffE3E3E3);
            }

            if (count % 2 == 0) {
              return Colors.white60;
            } else {
              return Color(0xffD9E1F2);
            }
          }

          //

          return Container(
              color: getRowColor(),
              padding: EdgeInsets.symmetric(horizontal: 6.0),

              // alignment: (dataGridCell.columnName == 'id' ||
              //     dataGridCell.columnName == 'salary')
              //     ? Alignment.centerRight
              //     : Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  dataGridCell.value.toString(),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  // style: getTextStyle(),
                  style: TextStyle(
                      color: Color(0xFF0B4461),
                      fontSize: 12,
                      fontWeight: FontWeight.w700),
                ),
              ));
        }).toList());
  }
}

class Transaction {
  // final String date;
  final String date;
  final int invoiceNo;
  final String customerName;
  final String serviceType;
  final String paymentType;
  final int cashRec;
  final int withdrawCharges;
  final int balance;
  final int withdraw;

  Transaction(
      this.date,
      this.invoiceNo,
      this.customerName,
      this.serviceType,
      this.paymentType,
      this.cashRec,
      this.withdrawCharges,
      this.balance,
      this.withdraw);

//

}

class DateData {
  final String date;
  final String colunmName;
  DateData({@required this.date, @required this.colunmName});
}

class InvoiceNoData {
  final int invoiceNo;
  final String colunmName;
  InvoiceNoData({@required this.invoiceNo, @required this.colunmName});
}

class CustomerNameData {
  final String customerName;
  final String colunmName;
  CustomerNameData({@required this.customerName, @required this.colunmName});
}

class ServiceTypeData {
  final String serviceType;
  final String colunmName;
  ServiceTypeData({@required this.serviceType, @required this.colunmName});
}

class PaymentTypeData {
  final String paymentType;
  final String colunmName;
  PaymentTypeData({@required this.paymentType, @required this.colunmName});
}

class CashRecData {
  final int cashRec;
  final String colunmName;
  CashRecData({@required this.cashRec, @required this.colunmName});
}

class WithdrawChargesData {
  final int withdrawCharges;
  final String colunmName;
  WithdrawChargesData(
      {@required this.withdrawCharges, @required this.colunmName});
}

class BalanceData {
  final int balance;
  final String colunmName;
  BalanceData({@required this.balance, @required this.colunmName});
}

class WithdrawData {
  final int withdraw;
  final String colunmName;
  WithdrawData({@required this.withdraw, @required this.colunmName});
}

// App Dimensions -----------------------------------------------------

class AppDimension {
  static const double FIGMA_SCREEN_SIZE = 360.0;
  static const double FIGMA_SCREEN_SIZE_HIGHT = 800.0;

  ///get responsive width in pixel size from given figma pixel
  static double width(
      {@required double figmaWidth, @required BuildContext context}) {
    final size = MediaQuery.of(context).size;
    final aspectRatio = figmaWidth / FIGMA_SCREEN_SIZE;

    return size.width * aspectRatio;
  }

  ///get responsive height in pixel size from given figma pixel
  static double height(
      {@required double figmaHeight, @required BuildContext context}) {
    final size = MediaQuery.of(context).size;
    final aspectRatio = figmaHeight / FIGMA_SCREEN_SIZE;

    return size.width * aspectRatio;
  }

  ///get responsive circleImageRadius in pixel size from given figma pixel
  static double circleImageRadius(
      {@required double figImageWidth, @required BuildContext context}) {
    final size = MediaQuery.of(context).size;
    final radius = figImageWidth / 2;
    final aspectRatio = radius / FIGMA_SCREEN_SIZE;
    return aspectRatio * size.width;
  }

  ///get responsive padding in pixel size from given figma pixel
  static double padding(
      {@required double figPadding, @required BuildContext context}) {
    final size = MediaQuery.of(context).size;
    final aspectRatio = figPadding / FIGMA_SCREEN_SIZE;

    return aspectRatio * size.width;
  }

  ///get responsive left padding in pixel size from given figma pixel
  static double left(
      {@required double figPadding, @required BuildContext context}) {
    final size = MediaQuery.of(context).size;
    final aspectRatio = figPadding / FIGMA_SCREEN_SIZE;

    return aspectRatio * size.width;
  }

  ///get responsive right padding in pixel size from given figma pixel
  static double right(
      {@required double figPadding, @required BuildContext context}) {
    final size = MediaQuery.of(context).size;
    final aspectRatio = figPadding / FIGMA_SCREEN_SIZE;

    return aspectRatio * size.width;
  }

  ///get responsive bottom padding in pixel size from given figma pixel
  static double bottom(
      {@required double figPadding, @required BuildContext context}) {
    final size = MediaQuery.of(context).size;
    final aspectRatio = figPadding / FIGMA_SCREEN_SIZE;

    return aspectRatio * size.width;
  }

  ///get responsive top padding in pixel size from given figma pixel
  static double top(
      {@required double figPadding, @required BuildContext context}) {
    final size = MediaQuery.of(context).size;
    final aspectRatio = figPadding / FIGMA_SCREEN_SIZE;

    return aspectRatio * size.width;
  }

  ///get responsive fontSize in pixel size from given figma pixel
  static double fontSize(
      {@required double figmaFontSize, @required BuildContext context}) {
    final size = MediaQuery.of(context).size;
    final aspectRatio = figmaFontSize / FIGMA_SCREEN_SIZE;

    return aspectRatio * size.width;
  }

  //Grid
  static double gridViewRatio(double comhight, double comWidth) {
    return comWidth / comhight;
  }

  ///get responsive pixel size from given pixel
  static double getResponsivePixelSize(
      {@required double figmaPixelSize, @required BuildContext context}) {
    final size = MediaQuery.of(context).size;
    final ratio = figmaPixelSize / FIGMA_SCREEN_SIZE;
    return ratio * size.width;
  }

  ///get responsive based on figma hight
  static double sizeWithHight(
      {@required double figmaSize, @required BuildContext context}) {
    final size = MediaQuery.of(context).size;
    final aspectRatio = figmaSize / FIGMA_SCREEN_SIZE_HIGHT;

    return size.height * aspectRatio;
  }
}

// Others --------------------------------------------------------------

// ignore: must_be_immutable
class AppCustomTextLebel extends StatelessWidget {
  String lebel;
  double fontSize;
  bool bold;
  double padding;
  double height;
  double width;
  Color color;
  bool lebelUnderline;

  AppCustomTextLebel(
      {@required this.lebel,
      @required this.fontSize,
      this.bold = false,
      this.padding,
      this.width,
      this.height,
      this.color,
      this.lebelUnderline,
      Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return lebelUnderline == true
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$lebel",
                style: TextStyle(
                    fontSize: fontSize,
                    fontWeight:
                        bold == false ? FontWeight.normal : FontWeight.w500,
                    color: textColor),
              ),
              Padding(
                padding: EdgeInsets.only(top: padding),
                child: Container(
                  height: height,
                  width: width,
                  color: color,
                ),
              )
            ],
          )
        : Text(
            "$lebel",
            style: TextStyle(
                fontSize: fontSize,
                fontWeight: bold == false ? FontWeight.normal : FontWeight.w500,
                color: textColor),
          );
  }
}

Color blueChip = Color(0xFF0D99FF);
Color pinkChip = Color(0xFFFF6666);
Color buttonColor = Color(0xFFED3E3E);
Color yollowChip = Color(0xFFE5B628);
Color greenChip = Color(0xFF33CC66);
Color dashBackground = Color(0xFFf1f4f6);
Color textColor = Color(0xFF0B4461);
Color iconColor = Color(0xFF0B4461);
Color defgrayTextColor = Color(0xFF666666);
Color textlightbalack = Color(0xFF454545);

Color shadowColor1 = Color(0xff0B4461);
Color shadowColor2 = Color(0xff0B4461);

final List<DailyActivityModel> dailyList = [
  DailyActivityModel(
      color: Color(0xffBDD7EE), amount: "5000", title: "Total Collection"),
  DailyActivityModel(
      color: Color(0xffBDD7EE), amount: "5000", title: "Total Collection"),
  DailyActivityModel(
      color: Color(0xffC6E0B4), amount: "3", title: "Total Parcel Complete"),
  DailyActivityModel(
      color: Color(0xffC6E0B4), amount: "30", title: "Total Parcel Complete"),
  DailyActivityModel(
      color: Color(0xffFFE699), amount: "1", title: "Total Parcel Return"),
  DailyActivityModel(
      color: Color(0xffFFE699), amount: "6", title: "Total Parcel Return"),
  DailyActivityModel(
      color: Color(0xffC6E0B4), amount: "140", title: "Total Delivery Charges"),
  DailyActivityModel(
      color: Color(0xffC6E0B4),
      amount: "1810",
      title: "Total Delivery Charges"),
  // DailyActivityModel(image: "assets/images/group3.png", amount: "10", title: "Waiting Pickup"),
  // DailyActivityModel(image: "assets/images/group10.png", amount: "5000 ৳", title: "Total Collect Amount"),
];

class DailyActivityModel {
  String title;
  String image;
  String amount;
  Color color;

  DailyActivityModel({this.image, this.amount, this.title, this.color});
}

class CustomGridItemWidget extends StatelessWidget {
  double width;
  double height;
  String title;
  String image;
  String amount;
  Color color;
  CustomGridItemWidget(
      {@required this.image,
        @required this.width,
        @required this.height,
      @required this.title,
      @required this.amount,
      @required this.color,
      Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      height: AppDimension.height(figmaHeight: height!=null?height:86, context: context),
      width: AppDimension.width(figmaWidth: width != null?width:106, context: context), // 158
      color: color != null ? color : Colors.white,
      boxShadow: containerShadow,
      paddingHorizontal: AppDimension.padding(figPadding: 2, context: context),
      paddingVertical:
          AppDimension.sizeWithHight(figmaSize: 7, context: context),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize:
                    AppDimension.fontSize(figmaFontSize: 13, context: context),
                fontWeight: FontWeight.w500),
            maxLines: 3,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: AppDimension.padding(figPadding: 3, context: context),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              // Image.asset(
              //   image,
              //   height: AppDimension.getResponsivePixelSize(figmaPixelSize: 24,context: context),
              //   width: AppDimension.getResponsivePixelSize(figmaPixelSize: 24,context: context),
              //   fit: BoxFit.fill,
              // ),
              Text(
                amount,
                style: TextStyle(
                    fontSize: AppDimension.fontSize(
                        figmaFontSize: 14, context: context),
                    fontWeight: FontWeight.w700),
              ),
            ],
          ),
          SizedBox(
            height: AppDimension.padding(figPadding: 10, context: context),
          ),
        ],
      ),
    );
  }
}

class CustomContainer extends StatelessWidget {
  double height;
  double width;
  double borderRadius;
  Color color;
  List<BoxShadow> boxShadow;
  double elevation;
  double paddingHorizontal;
  double paddingVertical;
  Widget child;

  CustomContainer(
      {@required this.height,
      @required this.width,
      @required this.boxShadow,
      @required this.child,
      //if this container is inside a  container then use this proparty and give that container width;
      this.color = Colors.white,
      this.borderRadius = 10,
      this.elevation = 0,
      this.paddingHorizontal = 0,
      this.paddingVertical = 0,
      Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Container(
        // width: AppDimension.backgroundConWidth(width, size.width),
        width: width,
        height: height,
        padding: EdgeInsets.symmetric(
            vertical: AppDimension.padding(
                figPadding: paddingVertical, context: context),
            horizontal: AppDimension.padding(
                figPadding: paddingVertical, context: context)),
        decoration: BoxDecoration(
          boxShadow: boxShadow,
          borderRadius: BorderRadius.circular(borderRadius),
          color: color,
        ),
        child: child,
      ),
    );
  }
}

final List<BoxShadow> containerShadow = [
  BoxShadow(
    color: iconColor.withOpacity(0.14),
    offset: const Offset(
      2.0,
      3.0,
    ),
    blurRadius: 10.0,
    spreadRadius: 0.0,
  ), //BoxShadow
  BoxShadow(
    color: iconColor.withOpacity(0.1),
    offset: const Offset(-1.0, -1.0),
    blurRadius: 2.0,
    spreadRadius: 0.0,
  ),
];


class DateTimeCard extends StatefulWidget {
  bool balanceShow;
  bool dropDownShow;
  DateTimeCard({this.balanceShow = false, this.dropDownShow = false, Key key})
      : super(key: key);

  @override
  State<DateTimeCard> createState() => _DateTimeCardState();
}

class _DateTimeCardState extends State<DateTimeCard> {
  TextEditingController fromDateCtrl = TextEditingController();
  TextEditingController toDateCtrl = TextEditingController();
  //text editing controller for text field

  @override
  void initState() {
    fromDateCtrl.text = ""; //set the initial value of text field
    toDateCtrl.text = "";
    super.initState();
  }

  List<String> deliveryTypeList = [
    'Select Parcel status',
    'Complete Delivery',
    'Delivery Pending',
    'Delivery Cancel',
    'Payment Done',
  ];

  String deliveryTypeValue = "Select Parcel status";
  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: textColor, // header background color
            onPrimary: whiteColor, // header text color
            onSurface: textColor, // body text color
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              primary: textColor, // button text color
            ),
          ),
        ),
        child: Builder(
// This widget is required for the theme to be applied
            builder: (context) {
              return Padding(
                padding: EdgeInsets.all(
                    AppDimension.padding(figPadding: 16, context: context)),
                child: CustomWhiteBackground(
                  elevation: 5,
                  width: AppDimension.width(figmaWidth: 328, context: context),
                  borderRadius: AppDimension.getResponsivePixelSize(
                      figmaPixelSize: 10, context: context),
                  boxShadow: [],
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal:
                        AppDimension.padding(figPadding: 15, context: context),
                        vertical:
                        AppDimension.padding(figPadding: 20, context: context)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (widget.balanceShow)
                         null
                        else
                          SizedBox(),
                        SizedBox(
                          height: AppDimension.getResponsivePixelSize(
                              figmaPixelSize: 10, context: context),
                          //  width: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                                child: Container(
                                  height: AppDimension.height(
                                      figmaHeight: 28, context: context),
                                  width: AppDimension.width(
                                      figmaWidth: 143, context: context),
                                  decoration: BoxDecoration(
                                    color: whiteColor,
                                    borderRadius: BorderRadius.all(Radius.circular(
                                        AppDimension.getResponsivePixelSize(
                                            figmaPixelSize: 5, context: context))),
                                    border: Border.all(color: borderColor),
                                  ),
                                  child: Center(
                                    child: TextField(
                                      controller:
                                      fromDateCtrl, //editing controller of this TextField
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding:
                                        EdgeInsets.only(left: 10, bottom: 15),
                                        hintText: "From Date",
                                        hintStyle: TextStyle(
                                          color: greyColor,
                                          fontSize: AppDimension.fontSize(
                                              figmaFontSize: 14, context: context),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      readOnly:
                                      true, //set it true, so that user will not able to edit text
                                      onTap: () async {
                                        DateTime pickedDate = await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(
                                                2000), //DateTime.now() - not to allow to choose before today.
                                            lastDate: DateTime(2101));

                                        if (pickedDate != null) {
                                          print(
                                              pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                          //String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
                                          String formattedDate =
                                          DateFormat('dd-MM-yyyy')
                                              .format(pickedDate);
                                          print(
                                              formattedDate); //formatted date output using intl package =>  2021-03-16
                                          //you can implement different kind of Date Format here according to your requirement

                                          setState(() {
                                            fromDateCtrl.text =
                                                formattedDate; //set output date to TextField value.
                                          });
                                        } else {
                                          print("Date is not selected");
                                        }
                                      },
                                    ),
                                  ),
                                )),
                            SizedBox(
                              width: AppDimension.getResponsivePixelSize(
                                  figmaPixelSize: 10, context: context),
                              //  width: 10,
                            ),
                            Expanded(
                                child: Container(
                                  height: AppDimension.height(
                                      figmaHeight: 28, context: context),
                                  width: AppDimension.width(
                                      figmaWidth: 143, context: context),
                                  decoration: BoxDecoration(
                                    color: whiteColor,
                                    borderRadius: BorderRadius.all(Radius.circular(
                                        AppDimension.getResponsivePixelSize(
                                            figmaPixelSize: 5, context: context))),
                                    border: Border.all(color: borderColor),
                                  ),
                                  child: Center(
                                    child: TextField(
                                      controller:
                                      toDateCtrl, //editing controller of this TextField
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding:
                                        EdgeInsets.only(left: 10, bottom: 15),
                                        hintText: "To Date",
                                        hintStyle: TextStyle(
                                          color: greyColor,
                                          //  color:  Color(0xFFECB409),
                                          fontSize: AppDimension.fontSize(
                                              figmaFontSize: 14, context: context),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      readOnly:
                                      true, //set it true, so that user will not able to edit text
                                      onTap: () async {
                                        DateTime pickedDate = await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(
                                                2000), //DateTime.now() - not to allow to choose before today.
                                            lastDate: DateTime(2101));

                                        if (pickedDate != null) {
                                          print(
                                              pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                          //String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
                                          String formattedDate =
                                          //  DateFormat('yyyy-MM-dd')
                                          DateFormat('dd-MM-yyyy')
                                              .format(pickedDate);
                                          print(
                                              formattedDate); //formatted date output using intl package =>  2021-03-16
                                          //you can implement different kind of Date Format here according to your requirement

                                          setState(() {
                                            toDateCtrl.text =
                                                formattedDate; //set output date to TextField value.
                                          });
                                        } else {
                                          print("Date is not selected");
                                        }
                                      },
                                    ),
                                  ),
                                )),
                          ],
                        ),
                        SizedBox(
                          height: AppDimension.getResponsivePixelSize(
                              figmaPixelSize: 15, context: context),
                        ),

                        if (widget.dropDownShow)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextWidget(
                                lebel: "Parcel Status",

                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                lebelColor: greyColor,
                              ),
                              SizedBox(
                                height: AppDimension.getResponsivePixelSize(
                                    figmaPixelSize: 10, context: context),
                              ),
                              DropDownButton(
                                height: AppDimension.height(
                                    figmaHeight: 42, context: context),
                                width: AppDimension.width(
                                    figmaWidth: 298, context: context),
                                decoration: BoxDecoration(
                                  color: whiteColor,
                                  borderRadius: BorderRadius.all(Radius.circular(
                                      AppDimension.getResponsivePixelSize(
                                          figmaPixelSize: 5, context: context))),
                                  border: Border.all(
                                      width: AppDimension.getResponsivePixelSize(
                                          figmaPixelSize: 1, context: context),
                                      color: borderColor),
                                ),
                                child: DropdownButton(
                                  isExpanded: true,
                                  underline: const SizedBox(),
                                  value: deliveryTypeValue,
                                  icon: Padding(
                                    padding: EdgeInsets.only(
                                        right: AppDimension.padding(
                                            figPadding: 16, context: context)),
                                    child: const Icon(Icons.arrow_drop_down),
                                  ),
                                  elevation: 16,
                                  style: TextStyle(
                                      color: Color(0xFF877E7E),
                                      fontSize: AppDimension.fontSize(
                                          figmaFontSize: 12, context: context)),
                                  onChanged: (value) {
                                    setState(() {
                                      deliveryTypeValue = value;
                                    });
                                  },
                                  items: deliveryTypeList
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: AppDimension.padding(
                                                    figPadding: 18, context: context)),
                                            child: Text(
                                              value,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: AppDimension.fontSize(
                                                      figmaFontSize: 14,
                                                      context: context)),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                ),
                              ),
                              SizedBox(
                                height: AppDimension.getResponsivePixelSize(
                                    figmaPixelSize: 15, context: context),
                              ),
                            ],
                          )
                        else
                          SizedBox(),



                        CustomButtonWidget(
                          height: AppDimension.height(
                              figmaHeight: 42, context: context),
                          width:
                          AppDimension.width(figmaWidth: 298, context: context),
                          decoration: BoxDecoration(
                            color: buttonColor,
                            borderRadius: BorderRadius.all(Radius.circular(
                                AppDimension.getResponsivePixelSize(
                                    figmaPixelSize: 5, context: context))),
                          ),
                          onPress: () {},
                          //titleFontSize: AppDimension.height(figmaHeight: 14, context: context),
                          title: "Search",
                          style: TextStyle(
                            color: whiteColor,
                            fontSize: AppDimension.fontSize(
                                figmaFontSize: 14, context: context),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }

          ///

        ));
  }
}


Color background=Color(0xFFBFBFBF);

Color dashInnertextColor=Color(0xFF454545);
Color currentBalanceColor=Color(0xFF33CC66);
Color totalIncomeColor=Color(0xFF137855);
Color processingColor=Color(0xFFECB409);
Color greyColor=Color(0xFF666666);
Color borderColor=Color(0xFFC7C7C7);
Color darkColor=Color(0xFF505050);
Color phoneColor=Color(0xFF32c853);
Color grey2Color=Color(0xFFE0E0E0);
Color underLineColor=Color(0xff0B4461);
Color whiteColor=Color(0xFFFFFFFF);
Color tileColor=Color(0xFFF5FBFF);
Color invoiceColor=Color(0xFF454545);

class CustomButtonWidget extends StatelessWidget {
  double height;
  double width;
  double innerPaddingHor;
  double innerPaddingVar;
  double outerBorder;
  Color outerBorderColor;
  Decoration decoration;
  Color backgroundColor;
  TextStyle style;
  double borderRadiusTop;
  double borderRadiusBottom;
  Color titleColor;

  String title;

  Function onPress;
  Widget child;

  CustomButtonWidget(
      {@required this.height,
        this.width,
        @required this.title,
        @required this.onPress,

        this.decoration,
        this.style,
        this.child,
        this.innerPaddingHor = 0,
        this.innerPaddingVar = 0,
        this.borderRadiusTop = 10,
        this.borderRadiusBottom = 10,
        this.outerBorderColor = Colors.white,
        this.outerBorder = 0.0,
        this.backgroundColor = Colors.white,
        this.titleColor = Colors.black,

        Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return

      GestureDetector(
        onTap: onPress,
        child: Container(
          height: height,
          width: width,
          decoration: decoration,
          child:Center(
            child: Text(
                title,
                style: style
            ),
          ),
        ),
      );
  }
}

class CustomWhiteBackground extends StatelessWidget {
  double height;
  double width;
  double borderRadius;
  Color color;
  List<BoxShadow> boxShadow;
  double elevation;
  double innerPaddingHor;
  double innerPaddingVar;
  Widget child;

  CustomWhiteBackground(
      { this.height,
        @required this.width,
        this.boxShadow,
        this.child,
        this.color = Colors.white,
        this.borderRadius = 10,
        this.elevation = 0,
        this.innerPaddingHor = 0,
        this.innerPaddingVar = 0,
        Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(

        elevation: elevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Container(
          width: width,
          height: height,
          padding: EdgeInsets.symmetric(
              vertical: innerPaddingVar,
              horizontal: innerPaddingHor),
          decoration: BoxDecoration(
            boxShadow: boxShadow,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(width: AppDimension.getResponsivePixelSize(figmaPixelSize: 1, context: context),color: Color(0xffE0E0E0)),
            color: color,
          ),
          child: child,
        ));
  }
}

class CustomTextWidget extends StatelessWidget {
  String lebel;
  double fontSize;


  double height;
  double width;

  Color lebelColor;
  bool lebelUnderline;
  FontWeight fontWeight;

  CustomTextWidget({
    @required this.lebel,
    this.fontSize,
    this.fontWeight,
    this.lebelColor,

    this.width,
    this.height,

    this.lebelUnderline,
    Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return lebelUnderline == true? Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$lebel",

          style: TextStyle(



              fontSize:    AppDimension.fontSize(figmaFontSize: fontSize??14, context: context),

              fontWeight:fontWeight ?? FontWeight.normal,color:lebelColor ?? textColor),),
        Padding(
          padding:  EdgeInsets.only(top:  AppDimension.padding(figPadding: 5, context: context),),

          child: Container(
            height:  AppDimension.height(figmaHeight:height , context: context),

            width:  AppDimension.width(figmaWidth: width, context: context),
            color: lebelColor,
          ),
        )
      ],
    ) :
    Text("$lebel",style: TextStyle(
        fontSize:    AppDimension.fontSize(figmaFontSize: fontSize??14, context: context),overflow:TextOverflow.visible ,
        fontWeight:fontWeight ?? FontWeight.normal,color:lebelColor ?? textColor),);
  }
}

class DropDownButton extends StatelessWidget {
  double height;
  double width;
  // double innerPaddingHor;
  // double innerPaddingVar;
  // double outerBorder;
  // Color outerBorderColor;
  // Decoration decoration;
  // Color backgroundColor;
  // TextStyle style;
  // double borderRadiusTop;
  // double borderRadiusBottom;
  // Color titleColor;
  //
  // String title;

  Decoration decoration;
  Widget child;

  DropDownButton(
      {@required this.height,
        @required this.width,
        @required this.decoration,
        @required this.child,
        Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height, width: width, decoration: decoration, child: child);

    ///
  }
}




