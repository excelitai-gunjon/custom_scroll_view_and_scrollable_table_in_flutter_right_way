import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';

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
      // appBar: AppBar(
      //   title: Text("Statement"),
      // ),
      body: NestedScrollView(

        physics: NeverScrollableScrollPhysics(),
        headerSliverBuilder: (context, isScolled){
          return [
            SliverAppBar(
              collapsedHeight: AppDimension.padding(figPadding: 500, context: context),
              expandedHeight: AppDimension.padding(figPadding: 500, context: context),
              flexibleSpace: Column(
                children: [
                  AppBar(
                    title: Text("Statement",
                    style: TextStyle(
                      color: Colors.black,
                    ),),

                  ),
                  StatementDatePage(),
                ],
              ),
            )
          ];
        },
        body: TablePage(),
      )
    );
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
              AppCustomTextLebel(
                lebel: "STATEMENT DATE :",
                bold: true,
                fontSize:
                    AppDimension.fontSize(figmaFontSize: 16, context: context),
              ),
              Padding(
                padding: const EdgeInsets.only(top:8.0),
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
                  // CustomGridItemWidget(
                  //   title: "Merchant Balance",
                  //   amount: dailyList[0].amount,
                  //   color: Color(0xffF8CBAD),
                  // ),
                  // CustomGridItemWidget(
                  //   title: dailyList[0].title,
                  //   amount: dailyList[0].amount,
                  //   color: Color(0xffF8CBAD),
                  // ),
                  // CustomGridItemWidget(
                  //   title: dailyList[0].title,
                  //   amount: dailyList[0].amount,
                  //   color: Color(0xffF8CBAD),
                  // ),

                ],
              )
            ],
          ),
        )
      ],
    );
  }
}

// Table Components ---------------------------------------------------------------------

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
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              // height: 460,
              // width: 860,
              constraints: BoxConstraints(
                  minHeight: 100, minWidth: double.infinity, maxHeight: size.height),
              child: SfDataGridTheme(
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
              ),
            ),
          ],
        ),
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
      color: Color(0xffC6E0B4), amount: "1810", title: "Total Delivery Charges"),
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
  String title;
  String image;
  String amount;
  Color color;
  CustomGridItemWidget(
      {@required this.image,
      @required this.title,
      @required this.amount,
      @required this.color,
      Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      height: AppDimension.width(figmaWidth: 76, context: context),
      width: AppDimension.width(figmaWidth: 106, context: context), // 158
      color: color != null ? color : Colors.white,
      boxShadow: containerShadow,
      paddingHorizontal: AppDimension.padding(figPadding: 12, context: context),
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
                    AppDimension.fontSize(figmaFontSize: 14, context: context),
                fontWeight: FontWeight.w500),
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: AppDimension.padding(figPadding: 10, context: context),
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
