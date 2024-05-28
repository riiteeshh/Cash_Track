import 'package:cash_track/actions/add_transaction_action_state.dart';
import 'package:cash_track/utils/bloc/add_transaction_bloc/add_transaction_bloc.dart';
import 'package:cash_track/widgets/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class TransactionAdditionView extends StatefulWidget {
  const TransactionAdditionView({super.key});

  @override
  State<TransactionAdditionView> createState() =>
      _TransactionAdditionViewState();
}

class _TransactionAdditionViewState extends State<TransactionAdditionView> {
  bool isExpenseSelected = true;
  bool isIncomeSelected = false;
  int selectedIndex = 10000;
  String iconData = 'lib/assets/images/7.svg';
  List<String> categoryName = [
    'Bills',
    'Business',
    'Flight',
    'Food',
    'Fuel',
    'Health',
    'Stocks',
    'Others',
    'Rent',
    'Restaurant',
    'Salary',
    'Shopping',
    'Savings'
  ];
  String type = 'expense';
  String name = 'others';
  final description = TextEditingController();
  final amount = TextEditingController();

  AddTransactionBloc addTransactionBloc = AddTransactionBloc();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.sizeOf(context).height * 0.09),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(10.r),
          color: Colors.white),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SizedBox(
                  height: MediaQuery.sizeOf(context).height,
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      verticalSpace(15),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          'Add Transaction',
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 16.h,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.none),
                        ),
                      ),
                      verticalSpace(15),
                      Text(
                        'Select Transaction Type',
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 14.h,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.none),
                      ),
                      verticalSpace(10),
                      Material(
                          child: ListTile(
                        onTap: () {
                          setState(() {
                            isIncomeSelected = true;
                            isExpenseSelected = false;
                            type = 'income';
                          });
                        },
                        tileColor: Colors.white,
                        contentPadding: const EdgeInsets.all(10),
                        leading: SizedBox(
                          width: 60,
                          height: 60,
                          child: Card(
                            color: (isIncomeSelected)
                                ? const Color(0xff6a58e7)
                                : Colors.white,
                            elevation: 0,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SvgPicture.asset(
                                'lib/assets/images/income.svg',
                                color: (isIncomeSelected)
                                    ? Colors.white
                                    : const Color(0xff6a58e7),
                              ),
                            ),
                          ),
                        ),
                        title: Text(
                          'Income',
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 14.h,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.none),
                        ),
                      )),
                      verticalSpace(10),
                      Material(
                        child: ListTile(
                          onTap: () {
                            setState(() {
                              isIncomeSelected = false;
                              isExpenseSelected = true;
                              type = 'expense';
                            });
                          },
                          tileColor: Colors.white,
                          contentPadding: const EdgeInsets.all(10),
                          leading: SizedBox(
                            width: 60,
                            height: 60,
                            child: Card(
                              color: (isExpenseSelected)
                                  ? const Color(0xff6a58e7)
                                  : Colors.white,
                              elevation: 0,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SvgPicture.asset(
                                  'lib/assets/images/expense.svg',
                                  color: (isExpenseSelected)
                                      ? Colors.white
                                      : const Color(0xff6a58e7),
                                ),
                              ),
                            ),
                          ),
                          title: Text(
                            'Expense',
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 14.h,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.none),
                          ),
                        ),
                      ),
                      verticalSpace(10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Name',
                            style: TextStyle(
                                fontSize: 14.h,
                                fontWeight: FontWeight.w300,
                                color: Colors.black,
                                decoration: TextDecoration.none),
                          ),
                          verticalSpace(10),
                          Material(
                            child: TextFormField(
                              controller: description,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  hintText: 'Description',
                                  contentPadding: const EdgeInsets.all(15),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                          ),
                          verticalSpace(10),
                          Text(
                            'Amount',
                            style: TextStyle(
                                fontSize: 14.h,
                                fontWeight: FontWeight.w300,
                                color: Colors.black,
                                decoration: TextDecoration.none),
                          ),
                          verticalSpace(10),
                          Material(
                            child: TextFormField(
                              textInputAction: TextInputAction.done,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                decimal: true,
                              ),
                              controller: amount,
                              decoration: InputDecoration(
                                  hintText: 'Amount',
                                  contentPadding: const EdgeInsets.all(15),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                          ),
                          verticalSpace(15),
                          Text(
                            'Choose category',
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 18.h,
                                fontWeight: FontWeight.w400,
                                decoration: TextDecoration.none),
                          ),
                          Material(
                            child: SizedBox(
                              width: double.maxFinite,
                              height: MediaQuery.sizeOf(context).height,
                              child: GridView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.zero,
                                  itemCount: 8,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 4,
                                          childAspectRatio:
                                              MediaQuery.sizeOf(context)
                                                      .height *
                                                  0.0009),
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedIndex = index;
                                          name = categoryName[index];
                                          iconData =
                                              'lib/assets/images/${index.toString()}.svg';
                                        });
                                      },
                                      child: Card(
                                        elevation: 0,
                                        color: Colors.white,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Card(
                                              elevation: 0,
                                              color: (selectedIndex == index)
                                                  ? const Color(0xff6a58e7)
                                                  : Colors.white,
                                              child: SizedBox(
                                                width: 60,
                                                height: 55,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: SvgPicture.asset(
                                                      'lib/assets/images/${index.toString()}.svg',
                                                      color: (selectedIndex ==
                                                              index)
                                                          ? Colors.white
                                                          : const Color(
                                                              0xff6a58e7)),
                                                ),
                                              ),
                                            ),
                                            Text(
                                              categoryName[index],
                                              textAlign: TextAlign.center,
                                              maxLines: 1,
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              BlocConsumer<AddTransactionBloc, AddTransactionState>(
                bloc: addTransactionBloc,
                listener: (context, state) {
                  addTransactionActionState(context, state);
                },
                builder: (context, state) {
                  if (state is AddTransactionLoadingState) {
                    SafeArea(
                        child: SizedBox(
                            width: double.maxFinite,
                            height: MediaQuery.sizeOf(context).width * 0.12,
                            child: ElevatedButton(
                              onPressed: null,
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff6a58e7),
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              child: const CircularProgressIndicator(),
                            )));
                  }
                  return Container(
                      margin: const EdgeInsets.only(bottom: 25),
                      width: double.maxFinite,
                      height: MediaQuery.sizeOf(context).width * 0.12,
                      child: ElevatedButton(
                        onPressed: () {
                          addTransactionBloc.add(
                              AddTransactionButtonClickedEvent(
                                  name: name,
                                  iconData: iconData,
                                  description: description.text,
                                  type: type,
                                  amount: amount.text));
                          description.clear();
                          amount.clear();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff6a58e7),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        child: Text(
                          'Continue',
                          style: TextStyle(
                            fontSize: 18.h,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
