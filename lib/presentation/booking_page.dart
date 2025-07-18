// booking_page.dart

import 'package:flutter/material.dart';
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

  // Step 1: Date and Time
  DateTime _focusedMonth = DateTime.now();
  DateTime? _selectedDate;

  String? _selectedTimeSlot; // 'Morning', 'Afternoon', 'Evening'

  final Map<String, String> timeSlotsMap = {
    'Morning': '08:00 AM - 12:00 PM',
    'Afternoon': '12:00 PM - 04:00 PM',
    'Evening': '04:00 PM - 08:00 PM',
  };

  // Step 2: Customer details
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();

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

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    super.dispose();
  }

  void _incrementMonth() {
    setState(() {
      _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month + 1);
      if (_selectedDate != null &&
          (_selectedDate!.year != _focusedMonth.year ||
              _selectedDate!.month != _focusedMonth.month)) {
        _selectedDate = null;
      }
    });
  }

  void _decrementMonth() {
    setState(() {
      final prevMonth = DateTime(_focusedMonth.year, _focusedMonth.month - 1);
      final now = DateTime.now();
      if (prevMonth.isBefore(DateTime(now.year, now.month))) {
        return;
      }
      _focusedMonth = prevMonth;
      if (_selectedDate != null &&
          (_selectedDate!.year != _focusedMonth.year ||
              _selectedDate!.month != _focusedMonth.month)) {
        _selectedDate = null;
      }
    });
  }

  Widget _buildCalendarHeader() {
    return Container(
      height: 110,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF215C3C),
            Color(0xFF3DAA77),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(32),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding:
              const EdgeInsets.only(left: 24, right: 16, top: 20, bottom: 16),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  if (_currentStep == BookingStep.chooseDateTime) {
                    Navigator.pop(context);
                  } else {
                    _goToPreviousStep();
                  }
                },
                tooltip: 'Back',
              ),
              const Expanded(
                child: Center(
                  child: Text(
                    'Create Booking',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'DMSans',
                      fontSize: 22,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 48),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWeekDays() {
    const weekDays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: weekDays
          .map(
            (e) => Expanded(
              child: Center(
                child: Text(
                  e,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                    fontFamily: 'DMSans',
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildCalendarGrid() {
    final year = _focusedMonth.year;
    final month = _focusedMonth.month;

    final firstDayOfMonth = DateTime(year, month, 1);
    final lastDayOfMonth = DateTime(year, month + 1, 0);

    final firstWeekday = firstDayOfMonth.weekday % 7;
    final daysInMonth = lastDayOfMonth.day;
    final totalGridItems = ((firstWeekday + daysInMonth) / 7).ceil() * 7;

    DateTime now = DateTime.now();

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: totalGridItems,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        final dayNumber = index - firstWeekday + 1;
        bool isValidDay = dayNumber > 0 && dayNumber <= daysInMonth;

        if (!isValidDay) {
          return const SizedBox.shrink();
        }

        final dateToBuild = DateTime(year, month, dayNumber);

        final isBeforeToday = dateToBuild.isBefore(
          DateTime(now.year, now.month, now.day),
        );

        final isSelected = _selectedDate != null &&
            _selectedDate!.year == dateToBuild.year &&
            _selectedDate!.month == dateToBuild.month &&
            _selectedDate!.day == dateToBuild.day;

        return GestureDetector(
          onTap: isBeforeToday
              ? null
              : () {
                  setState(() {
                    _selectedDate = dateToBuild;
                  });
                },
          child: Container(
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color(0xFF4CAF50)
                  : isBeforeToday
                      ? Colors.grey[200]
                      : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: isSelected
                  ? null
                  : Border.all(
                      color: isBeforeToday
                          ? Colors.grey.shade300
                          : Colors.grey.shade400,
                    ),
            ),
            child: Center(
              child: Text(
                '$dayNumber',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  fontFamily: 'DMSans',
                  color: isSelected
                      ? Colors.white
                      : (isBeforeToday ? Colors.grey : Colors.black87),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTimeSlotOption(String label) {
    bool selected = _selectedTimeSlot == label;
    return ChoiceChip(
      label: Text(
        label,
        style: TextStyle(
          color: selected ? Colors.white : Colors.black87,
          fontWeight: FontWeight.w600,
          fontFamily: 'DMSans',
        ),
      ),
      selected: selected,
      selectedColor: const Color(0xFF4CAF50),
      backgroundColor: Colors.grey[200],
      onSelected: (_) {
        setState(() {
          _selectedTimeSlot = label;
        });
      },
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
    );
  }

  Widget _buildChooseDateTimeStep() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Choose Date',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Colors.green[900],
                  fontFamily: 'DMSans',
                ),
          ),
          const SizedBox(height: 12),
          _buildWeekDays(),
          const SizedBox(height: 4),
          Expanded(child: _buildCalendarGrid()),
          const SizedBox(height: 16),
          Text(
            'Choose Time',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Colors.green[900],
                  fontFamily: 'DMSans',
                ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            children: [
              _buildTimeSlotOption('Morning'),
              _buildTimeSlotOption('Afternoon'),
              _buildTimeSlotOption('Evening'),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _goToNextStep,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4CAF50),
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35),
                ),
                textStyle: const TextStyle(
                  fontFamily: 'DMSans',
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
              child: const Text(
                'Next',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration(String label) => InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontFamily: 'DMSans',
          color: Colors.black87,
        ),
        filled: true,
        fillColor: Colors.grey[50],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey[300]!)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF4CAF50), width: 2)),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      );

  Widget _buildCustomerDetailsStep() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Text(
              'Customer Details',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Colors.green[900],
                    fontFamily: 'DMSans',
                  ),
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _nameController,
              decoration: _inputDecoration('Full Name'),
              textInputAction: TextInputAction.next,
              style: const TextStyle(fontFamily: 'DMSans'),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _addressController,
              decoration: _inputDecoration('Address'),
              textInputAction: TextInputAction.next,
              minLines: 1,
              maxLines: 3,
              style: const TextStyle(fontFamily: 'DMSans'),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter your address';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _mobileController,
              decoration: _inputDecoration('Mobile Number'),
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              style: const TextStyle(fontFamily: 'DMSans'),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter your mobile number';
                }
                final phoneRegex = RegExp(r'^\+?[\d\s]{7,15}$');
                if (!phoneRegex.hasMatch(value.trim())) {
                  return 'Please enter a valid mobile number';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _emailController,
              decoration: _inputDecoration('Email (optional)'),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              style: const TextStyle(fontFamily: 'DMSans'),
              validator: (value) {
                if (value != null && value.isNotEmpty) {
                  final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                  if (!emailRegex.hasMatch(value.trim())) {
                    return 'Please enter a valid email';
                  }
                }
                return null;
              },
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _goToPreviousStep,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF4CAF50),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35)),
                      side: const BorderSide(color: Color(0xFF4CAF50), width: 2),
                      textStyle: const TextStyle(
                        fontFamily: 'DMSans',
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    child: const Text(
                      'Back',
                      style: TextStyle(color: Color(0xFF4CAF50)),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _goToNextStep,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4CAF50),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35)),
                      textStyle: const TextStyle(
                        fontFamily: 'DMSans',
                        fontWeight: FontWeight.w700,
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
            const SizedBox(height: 24),
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
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 160,
                  height: 160,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        Colors.green.shade300,
                        Colors.green.shade700,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
                const Icon(
                  Icons.check_circle,
                  size: 120,
                  color: Colors.white,
                ),
              ],
            ),
            const SizedBox(height: 32),
            Text(
              'Booking Confirmed!',
              style: TextStyle(
                color: Colors.green.shade900,
                fontWeight: FontWeight.w900,
                fontFamily: 'DMSans',
                fontSize: 28,
                letterSpacing: 1.2,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(24),
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
            const SizedBox(height: 36),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () =>
                    Navigator.popUntil(context, (route) => route.isFirst),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF50),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35),
                  ),
                  textStyle: const TextStyle(
                    fontFamily: 'DMSans',
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
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
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            TextSpan(text: value),
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
      body: Column(
        children: [
          _buildCalendarHeader(),
          Expanded(child: content),
        ],
      ),
    );
  }
}