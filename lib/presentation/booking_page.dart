


import 'package:flutter/material.dart';
import 'package:home_garden/presentation/widgets/custombutton.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class BookingPage extends StatefulWidget {
  final String serviceTitle;

  const BookingPage({Key? key, required this.serviceTitle}) : super(key: key);

  @override
  State<BookingPage> createState() => _BookingPageState();
}

enum BookingStep { chooseDateTime, customerDetails, confirmation }

class _BookingPageState extends State<BookingPage> {
  BookingStep _currentStep = BookingStep.chooseDateTime;

  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDate = DateTime.now();

  String? _selectedTimeSlot;

  final Map<String, String> timeSlotsMap = {
    'Morning': '08:00 AM - 12:00 PM',
    'Afternoon': '12:00 PM - 04:00 PM',
    // 'Evening': '04:00 PM - 08:00 PM',
  };

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _postcodeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _postcodeController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    super.dispose();
  }

  // InputDecoration _inputDecoration(String label) => InputDecoration(
  //       labelText: label,
  //       labelStyle: const TextStyle(
  //         fontWeight: FontWeight.w600,
  //         fontFamily: 'DMSans',
  //         fontSize: 14,
  //         color: Colors.black87,
  //       ),
  //       filled: true,
  //       fillColor: Colors.grey[50],
  //       border: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(8),
  //         borderSide: BorderSide(color: Colors.grey[300]!),
  //       ),
  //       enabledBorder: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(8),
  //         borderSide: BorderSide(color: Colors.grey[300]!),
  //       ),
  //       focusedBorder: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(8),
  //         borderSide: const BorderSide(color: Color(0xFF205b3b), width: 2),
  //       ),
  //       contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
  //     );









//  Widget _buildCustomerDetailsStep() {
//   return Padding(
//     padding: const EdgeInsets.all(16.0),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Your Details',
//           style: TextStyle(
//             fontSize: 25,
//             fontWeight: FontWeight.w600,
//             color: Colors.black,
//             fontFamily: 'DMSans',
//           ),
//         ),
//         const SizedBox(height: 24),
//         Text(
//           'Name',
//           style: TextStyle(
//             color: Colors.black,
//             fontFamily: 'DMSans',
//             fontWeight: FontWeight.w400,
//             fontSize: 16,
//           ),
//         ),
//         const SizedBox(height: 8),
//         TextFormField(
//           decoration: InputDecoration(
//                border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide(color: Colors.grey[300]!),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide(color: Colors.grey[300]!),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: const BorderSide(color: Color(0xFF205b3b), width: 2),
//         ),
//         contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
//           ),
//           style: TextStyle(
//             fontFamily: 'DMSans',
//             fontWeight: FontWeight.w400,
//             fontSize: 16,
//             color: Colors.black,
//           ),
//           validator: (value) {
//             if (value == null || value.trim().isEmpty) {
//               return 'Please enter your name';
//             }
//             return null;
//           },
//         ),
//         const SizedBox(height: 16),
//         Text(
//           'Address',
//           style: TextStyle(
//             color: Colors.black,
//             fontFamily: 'DMSans',
//             fontWeight: FontWeight.w400,
//             fontSize: 16,
//           ),
//         ),
//         const SizedBox(height: 8),
//         TextFormField(
//           decoration: InputDecoration(
//              border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide(color: Colors.grey[300]!),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide(color: Colors.grey[300]!),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: const BorderSide(color: Color(0xFF205b3b), width: 2),
//         ),
//         contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
//           ),
//           style: TextStyle(
//             fontFamily: 'DMSans',
//             fontWeight: FontWeight.w400,
//             fontSize: 16,
//             color: Colors.black,
//           ),
//           maxLines: 2,
//           validator: (value) {
//             if (value == null || value.trim().isEmpty) {
//               return 'Please enter your address';
//             }
//             return null;
//           },
//         ),
//         const SizedBox(height: 16),
//         Text(
//           'Postcode',
//           style: TextStyle(
//             color: Colors.black,
//             fontFamily: 'DMSans',
//             fontWeight: FontWeight.w400,
//             fontSize: 16,
//           ),
//         ),
//         const SizedBox(height: 8),
//         TextFormField(
//            decoration: InputDecoration(
//              border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide(color: Colors.grey[300]!),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide(color: Colors.grey[300]!),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: const BorderSide(color: Color(0xFF205b3b), width: 2),
//         ),
//         contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
//           ),
//           style: TextStyle(
//             fontFamily: 'DMSans',
//             fontWeight: FontWeight.w400,
//             fontSize: 16,
//             color: Colors.black,
//           ),
//           validator: (value) {
//             if (value == null || value.trim().isEmpty) {
//               return 'Please enter your postcode';
//             }
//             return null;
//           },
//         ),
//         const SizedBox(height: 16),
//         Text(
//           'Phone',
//           style: TextStyle(
//             color: Colors.black,
//             fontFamily: 'DMSans',
//             fontWeight: FontWeight.w400,
//             fontSize: 16,
//           ),
//         ),
//         const SizedBox(height: 8),
//         TextFormField(
//           decoration: InputDecoration(
//              border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide(color: Colors.grey[300]!),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide(color: Colors.grey[300]!),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: const BorderSide(color: Color(0xFF205b3b), width: 2),
//         ),
//         contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
//           ),
//           keyboardType: TextInputType.phone,
//           style: TextStyle(
//             fontFamily: 'DMSans',
//             fontWeight: FontWeight.w400,
//             fontSize: 16,
//             color: Colors.black,
//           ),
//           validator: (value) {
//             if (value == null || value.trim().isEmpty) {
//               return 'Please enter your phone number';
//             }
//             final phoneRegex = RegExp(r'^\+?[\d\s]{7,15}$');
//             if (!phoneRegex.hasMatch(value.trim())) {
//               return 'Please enter a valid phone number';
//             }
//             return null;
//           },
//         ),
//         const Spacer(),
//         Row(
//           children: [
//             // Expanded(
//             //   child: OutlinedButton(
//             //     onPressed: _goToPreviousStep,
//             //     style: OutlinedButton.styleFrom(
//             //       foregroundColor: Colors.black, // Changed to black
//             //       padding: const EdgeInsets.symmetric(vertical: 14),
//             //       shape: RoundedRectangleBorder(
//             //         borderRadius: BorderRadius.circular(8),
//             //       ),
//             //       side: const BorderSide(color: Colors.black, width: 1), // Changed to black
//             //       textStyle: const TextStyle(
//             //         fontFamily: 'DMSans',
//             //         fontWeight: FontWeight.w600,
//             //         fontSize: 16,
//             //       ),
//             //     ),
//             //     child: const Text(
//             //       'Back',
//             //       style: TextStyle(color: Colors.black),
//             //     ),
//             //   ),
//             // ),
//             // const SizedBox(width: 16),
//             Expanded(
//               child: ElevatedButton(
//                 onPressed: _goToNextStep,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Color(0xFF205b3b), 
//                   padding: const EdgeInsets.symmetric(vertical: 14),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   textStyle: const TextStyle(
//                     fontFamily: 'DMSans',
//                     fontWeight: FontWeight.w600,
//                     fontSize: 16,
//                   ),
//                 ),
//                 child: const Text(
//                   'Confirm Booking',
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 16),
//       ],
//     ),
//   );
// }


Widget _buildCustomerDetailsStep() {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Form(
      key: _formKey, // Add Form widget with _formKey
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Details',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w600,
              color: Colors.black,
              fontFamily: 'DMSans',
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Name',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'DMSans',
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _nameController, // Link controller
            decoration: _inputDecoration('Name'), // Use the existing _inputDecoration method
            style: TextStyle(
              fontFamily: 'DMSans',
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: Colors.black,
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          Text(
            'Address',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'DMSans',
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _addressController, // Link controller
            decoration: _inputDecoration('Address'),
            style: TextStyle(
              fontFamily: 'DMSans',
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: Colors.black,
            ),
            maxLines: 2,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter your address';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          Text(
            'Postcode',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'DMSans',
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _postcodeController, // Link controller
            decoration: _inputDecoration('Postcode'),
            style: TextStyle(
              fontFamily: 'DMSans',
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: Colors.black,
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter your postcode';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          Text(
            'Phone',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'DMSans',
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _mobileController, // Link controller
            decoration: _inputDecoration('Phone'),
            keyboardType: TextInputType.phone,
            style: TextStyle(
              fontFamily: 'DMSans',
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: Colors.black,
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter your phone number';
              }
              final phoneRegex = RegExp(r'^\+?[\d\s]{7,15}$');
              if (!phoneRegex.hasMatch(value.trim())) {
                return 'Please enter a valid phone number';
              }
              return null;
            },
          ),
          // const SizedBox(height: 16),
          // Text(
          //   'Email (Optional)',
          //   style: TextStyle(
          //     color: Colors.black,
          //     fontFamily: 'DMSans',
          //     fontWeight: FontWeight.w400,
          //     fontSize: 16,
          //   ),
          // ),
          // const SizedBox(height: 8),
          // TextFormField(
          //   controller: _emailController, // Link controller
          //   decoration: _inputDecoration('Email'),
          //   keyboardType: TextInputType.emailAddress,
          //   style: TextStyle(
          //     fontFamily: 'DMSans',
          //     fontWeight: FontWeight.w400,
          //     fontSize: 16,
          //     color: Colors.black,
          //   ),
          //   validator: (value) {
          //     if (value != null && value.trim().isNotEmpty) {
          //       final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
          //       if (!emailRegex.hasMatch(value.trim())) {
          //         return 'Please enter a valid email address';
          //       }
          //     }
          //     return null;
          //   },
          // ),
          const Spacer(),
          Row(
            children: [
              // Expanded(
              //   child: OutlinedButton(
              //     onPressed: _goToPreviousStep,
              //     style: OutlinedButton.styleFrom(
              //       foregroundColor: Colors.black,
              //       padding: const EdgeInsets.symmetric(vertical: 14),
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(8),
              //       ),
              //       side: const BorderSide(color: Colors.black, width: 1),
              //       textStyle: const TextStyle(
              //         fontFamily: 'DMSans',
              //         fontWeight: FontWeight.w600,
              //         fontSize: 16,
              //       ),
              //     ),
              //     child: const Text(
              //       'Back',
              //       style: TextStyle(color: Colors.black),
              //     ),
              //   ),
              // ),
              // const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: _goToNextStep,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF205b3b),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    textStyle: const TextStyle(
                      fontFamily: 'DMSans',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  child: const Text(
                    'Confirm Booking',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    ),
  );
}

  Widget _buildConfirmationStep() {
    final formattedDate = _selectedDate == null
        ? ''
        : DateFormat.yMMMMd().format(_selectedDate!);
    final timeRange = _selectedTimeSlot != null
        ? timeSlotsMap[_selectedTimeSlot!] ?? ''
        : '';

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF205b3b),
                border: Border.all(color: Colors.grey[200]!, width: 4),
              ),
              child: const Icon(
                Icons.check_circle,
                size: 80,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Booking Confirmed',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                    color: Colors.black87,
                    fontFamily: 'DMSans',
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailRow('Service:', widget.serviceTitle),
                  _buildDetailRow('Date:', formattedDate),
                  _buildDetailRow('Time:', timeRange),
                  const SizedBox(height: 12),
                  _buildDetailRow('Name:', _nameController.text.trim()),
                  _buildDetailRow('Address:', _addressController.text.trim()),
                  _buildDetailRow('Mobile:', _mobileController.text.trim()),
                  if (_emailController.text.trim().isNotEmpty)
                    _buildDetailRow('Email:', _emailController.text.trim()),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () =>
                    Navigator.popUntil(context, (route) => route.isFirst),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF205b3b),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  textStyle: const TextStyle(
                    fontFamily: 'DMSans',
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                child: const Text(
                  'Back to Home',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            fontSize: 16,
            color: Colors.black87,
            height: 1.4,
            fontFamily: 'DMSans',
          ),
          children: [
            TextSpan(
              text: '$label ',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            TextSpan(
              text: value,
              style: const TextStyle(fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content;
    switch (_currentStep) {
      case BookingStep.chooseDateTime:
        content = _buildChooseDateTimeStep();
        break;
      case BookingStep.customerDetails:
        content = _buildCustomerDetailsStep();
        break;
      case BookingStep.confirmation:
        content = _buildConfirmationStep();
        break;
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () {
            if (_currentStep == BookingStep.chooseDateTime) {
              Navigator.pop(context);
            } else {
              _goToPreviousStep();
            }
          },
          tooltip: 'Back',
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(child: content),
    );
  }

  void _goToNextStep() {
    setState(() {
      if (_currentStep == BookingStep.chooseDateTime) {
        if (_selectedDate == null) {
          _showSnack('Please select a date');
          return;
        }
        if (_selectedTimeSlot == null) {
          _showSnack('Please select a time slot');
          return;
        }
        _currentStep = BookingStep.customerDetails;
      } else if (_currentStep == BookingStep.customerDetails) {
        if (_formKey.currentState?.validate() ?? false) {
          _currentStep = BookingStep.confirmation;
        }
      }
    });
  }

  void _goToPreviousStep() {
    setState(() {
      if (_currentStep == BookingStep.customerDetails) {
        _currentStep = BookingStep.chooseDateTime;
      } else if (_currentStep == BookingStep.confirmation) {
        _currentStep = BookingStep.customerDetails;
      }
    });
  }

  void _showSnack(String message) {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _selectYearMonth(BuildContext context) async {
    final DateTime firstDay = DateTime.now();
    final DateTime initialDate = _focusedDay.isBefore(firstDay) ? firstDay : _focusedDay;
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDay,
      lastDate: DateTime.now().add(const Duration(days: 365)),
      helpText: 'Choose Date',
      initialDatePickerMode: DatePickerMode.year,
    );
    if (picked != null) {
      setState(() {
        _focusedDay = DateTime(picked.year, picked.month, 1);
        _selectedDate = null;
      });
    }
  }

  InputDecoration _inputDecoration(String label) => InputDecoration(
        // labelText: label,
        labelStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontFamily: 'DMSans',
          fontSize: 14,
          color: Colors.black87,
        ),
        filled: true,
        fillColor: Colors.grey[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF205b3b), width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      );

  Widget _buildChooseDateTimeStep() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choose a Date',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Colors.black87,
                    fontFamily: 'DMSans',
                  ),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                // color: Colors.grey[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: TableCalendar(
                
                firstDay: DateTime.now(),
                lastDay: DateTime.now().add(const Duration(days: 365)),
                focusedDay: _focusedDay.isBefore(DateTime.now()) ? DateTime.now() : _focusedDay,
                selectedDayPredicate: (day) => isSameDay(_selectedDate, day),
                onDaySelected: (selectedDay, focusedDay) {
                  if (!selectedDay.isBefore(DateTime.now())) {
                    setState(() {
                      _selectedDate = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  }
                },
                calendarStyle: CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: Colors.grey[300],
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: const BoxDecoration(
                    color: Color(0xFF205b3b),
                    shape: BoxShape.circle,
                  ),
                ),
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextStyle: const TextStyle(
                    fontFamily: 'DMSans',
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                  leftChevronIcon: const Icon(Icons.chevron_left, color: Color(0xFF205b3b), size: 24),
                  rightChevronIcon: const Icon(Icons.chevron_right, color: Color(0xFF205b3b), size: 24),
                ),
                calendarBuilders: CalendarBuilders(
                  headerTitleBuilder: (context, day) => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () => _selectYearMonth(context),
                        child: const Icon(Icons.calendar_today, color: Color(0xFF205b3b), size: 20),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        DateFormat.yMMMM().format(day),
                        style: const TextStyle(
                          fontFamily: 'DMSans',
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Choose a Time',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Colors.black87,
                    fontFamily: 'DMSans',
                  ),
            ),
            const SizedBox(height: 12),
            ...timeSlotsMap.entries.map((entry) => RadioListTile<String>(
                  contentPadding: const EdgeInsets.all(0),    
                  // radioScaleFactor: 1.0,
                  
                  title: Text(entry.key),
                  // subtitle: Text(entry.value),
                  value: entry.key,
                  groupValue: _selectedTimeSlot,
                  onChanged: (value) => setState(() => _selectedTimeSlot = value),
                  activeColor: const Color(0xFF205b3b),
                )),
            const SizedBox(height: 120),
            _buildCommonButtons(),
          ],
        ),
      ),
    );
  }


  Widget _buildCommonButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: Row(
        children: [
          if (_currentStep != BookingStep.confirmation)
            // Expanded(
            //   child: OutlinedButton(
            //     onPressed: _currentStep == BookingStep.chooseDateTime
            //         ? () => Navigator.pop(context)
            //         : _goToPreviousStep,
            //     style: OutlinedButton.styleFrom(
            //       foregroundColor: Colors.black,
            //       padding: const EdgeInsets.symmetric(vertical: 14),
            //       side: const BorderSide(color: Colors.black, width: 1),
            //     ),
            //     child: const Text('Back'),
            //   ),
            // ),
          // if (_currentStep != BookingStep.confirmation) const SizedBox(width: 16),
          Expanded(
            child: CustomButton(
              backgroundColor: Color(0xFF205b3b),
                borderRadius: 10,
              padding: 10,
              text:    _currentStep == BookingStep.confirmation
                      ? 'Back to Home'
                      : _currentStep == BookingStep.customerDetails
                          ? 'Confirm Booking'
                          : 'Next',onPressed:  _goToNextStep,),
          )
          // Expanded(
          //   child: ElevatedButton(
          //     onPressed: _goToNextStep,
          //     style: ElevatedButton.styleFrom(
          //       backgroundColor: const Color(0xFF205b3b),
          //       padding: const EdgeInsets.symmetric(vertical: 14),
          //     ),
          //     child: Text(
          //       _currentStep == BookingStep.confirmation
          //           ? 'Back to Home'
          //           : _currentStep == BookingStep.customerDetails
          //               ? 'Confirm Booking'
          //               : 'Next',
          //       style: const TextStyle(color: Colors.white),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
