import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:jeep_ads/widgets/common/next_button.dart';
import 'package:jeep_ads/screens/home/home_screen.dart';
import 'package:jeep_ads/models/notifications/ad_campaign.dart';

class PaymentScreen extends StatefulWidget {
  final double totalAmount;
  final AdCampaign campaign;

  const PaymentScreen({
    super.key,
    required this.totalAmount,
    required this.campaign,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int currentStep = 0;
  final PageController _pageController = PageController();
  String? selectedPaymentMethod;
  bool isExpanded = false;
  bool hasUploadedReceipt = false;

  List<Widget> getSteps() => [
        _buildTotalCostStep(),
        _buildPaymentMethodStep(),
        _buildThankYouStep(),
      ];
//1st page
  Widget _buildTotalCostStep() {
    return Padding(
      padding: const EdgeInsets.only(left: 42.0, right: 42, top: 42),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Video Thumbnail
          Container(
            width: double.infinity,
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              image: DecorationImage(
                image: NetworkImage(widget.campaign.thumbnailUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 30),
          // Campaign Details
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(left: 1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildDetailRow('Ad Campaign Name:', widget.campaign.title),
                _buildDetailRow(
                    'Ad Duration', '${widget.campaign.months} months'),
                _buildDetailRow('Modern Jeeps',
                    '${widget.campaign.numberOfJeeps.toString()} Modern Jeeps'),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Payment Breakdown
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                const Divider(
                  height: 24,
                  color: Color(0xff222222),
                ),
                _buildPaymentRow('Subtotal:', widget.campaign.subtotal),
                const SizedBox(height: 8),
                _buildPaymentRow('VAT (12%):', widget.campaign.discount),
                const SizedBox(height: 12),
                _buildPaymentRow(
                  'Total:',
                  widget.campaign.budget,
                  isTotal: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

//for the details
  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Label at the top
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              color: Color(0XFF8C8C8C),
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

//for the details
  Widget _buildPaymentRow(String label, double amount, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: isTotal ? 18 : 12,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal
                ? const Color.fromARGB(255, 0, 0, 0)
                : Color(0XFF222222),
          ),
        ),
        Text(
          'PHP ${amount.toStringAsFixed(2)}',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: isTotal ? 18 : 12,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal
                ? const Color.fromARGB(255, 0, 0, 0)
                : Color(0XFF222222),
          ),
        ),
      ],
    );
  }

//2nd page
  Widget _buildPaymentMethodStep() {
    return SingleChildScrollView(
      child: Padding(
        padding:
            const EdgeInsets.only(left: 42.0, right: 42, top: 42, bottom: 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Mode of Payment',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: Color(0xFF082857),
              ),
            ),
            const SizedBox(height: 2),
            // Video Thumbnail and Title
            Container(
              width: double.infinity,
              height: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(0),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(0),
                      bottomLeft: Radius.circular(0),
                    ),
                    child: Image.network(
                      widget.campaign.thumbnailUrl,
                      width: 90,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.campaign.title,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF222222),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Subtotal:',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 11,
                                color: Colors.black87,
                              ),
                            ),
                            Text(
                              'PHP ${widget.campaign.subtotal.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 11,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'VAT (12%):',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 11,
                                color: Colors.black87,
                              ),
                            ),
                            Text(
                              'PHP ${(widget.campaign.subtotal * 0.12).toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 11,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 15,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceBetween, // Aligns the texts to opposite sides
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10), // Adds left padding of 20px
                    child: const Text(
                      'Total:',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(
                      height:
                          5), // Adds horizontal space of 20 between 'Total' and the value
                  Text(
                    'PHP ${widget.campaign.subtotal.toStringAsFixed(2)}', // Displays the subtotal at the end
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16), // Add some spacing before the line
            const Divider(
              thickness: 1,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            const Text(
              'Select Bank to Pay',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFF082857),
              ),
            ),
            const SizedBox(height: 14),
            _buildPaymentOption('BPI', 'lib/images/BPI_logo.png', 'BPI'),
            const SizedBox(height: 14),
            _buildPaymentOption('GCash', 'lib/images/gcash_logo.png', 'GCash'),
            const SizedBox(height: 16),
            const Divider(
              thickness: 1,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            _buildReceiptUpload(),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOption(String title, String imagePath, String value) {
    final isSelected = selectedPaymentMethod == value;

    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Set shadow color
            offset:
                const Offset(0, 6), // Horizontal and vertical offset (4px down)
            blurRadius: 8, // Blur effect (larger number = more blurred)
            spreadRadius: 0, // Spread of the shadow
          ),
        ],
        border: Border.all(
          color: isSelected
              ? const Color.fromARGB(255, 255, 255, 255)
              : const Color.fromARGB(255, 255, 255, 255),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12),
        color: isSelected
            ? const Color.fromARGB(255, 255, 255, 255)
            : const Color.fromARGB(255, 255, 255, 255),
      ),
      child: InkWell(
        onTap: () {
          this.setState(() {
            selectedPaymentMethod =
                selectedPaymentMethod == value ? null : value;
            isExpanded = selectedPaymentMethod == value;
          });
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Image.asset(
                    imagePath,
                    width: 80,
                    height: 30,
                    fit: BoxFit.contain,
                  ),
                  const Spacer(),
                  Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: const Color.fromARGB(255, 0, 0, 0),
                  ),
                ],
              ),
            ),
            if (isSelected && isExpanded)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1), // Set shadow color
                      offset: const Offset(
                          0, 6), // Horizontal and vertical offset (4px down)
                      blurRadius:
                          8, // Blur effect (larger number = more blurred)
                      spreadRadius: 0, // Spread of the shadow
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 150,
                      height: 100,
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          //DROPDOWN CONTENT
                          Positioned(
                            top: 0, // Overlaps slightly with the icon
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(value == 'GCash'
                                      ? 'lib/images/gcash_qr.png'
                                      : 'lib/images/bpi_qr.png'),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (value == 'BPI') ...[
                                const Text(
                                  'Jenesia Red',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Text(
                                  '1234 5678 9012',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 12,
                                    color: Colors.black87,
                                  ),
                                ),
                              ] else if (value == 'GCash') ...[
                                const Text(
                                  'Jenesia Red',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Text(
                                  '0917 123 4567',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                              const SizedBox(height: 14),
                              Transform.translate(
                                offset: const Offset(-16, 0),
                                child: TextButton.icon(
                                  onPressed: () {
                                    // TODO: Implement QR/Account details download
                                  },
                                  icon: const Icon(Icons.download,
                                      color: Color(0xFF0171BB)),
                                  label: Text(
                                    value == 'GCash'
                                        ? 'Download QR'
                                        : 'Download QR',
                                    style: const TextStyle(
                                      color: Color(0xFF0171BB),
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildReceiptUpload() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Upload Receipt',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xFF082857),
          ),
        ),
        const SizedBox(height: 12),
        DottedBorder(
          color: const Color(0xFF9E9E9E),
          strokeWidth: 2,
          dashPattern: const [12, 6],
          borderType: BorderType.Rect,
          radius: const Radius.circular(10),
          child: Container(
            width: double.infinity,
            height: 150,
            color: const Color(0xFFF1F1F1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.upload_file,
                  size: 48,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Upload your payment receipt here',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () {
                    // TODO: Implement file picker
                  },
                  child: const Text(
                    'Browse Files',
                    style: TextStyle(
                      color: Color(0xFF0171BB),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildThankYouStep() {
    return Padding(
      padding: const EdgeInsets.only(left: 42.0, right: 42.0, top: 42),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Thank you for\n placeholder!',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF082857),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Once we have your content finalized, we\'ll\nreplace this placeholder text with your real\ncontent.',
            textAlign: TextAlign.start,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              height: 1.5,
              color: Colors.black87,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Image.asset(
            'lib/images/thank_you_page.png', // Add a success/checkmark image
            width: double.infinity,
            height: 350,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final steps = getSteps();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Payment',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (index) {
                setState(() => currentStep = index);
              },
              itemCount: steps.length,
              itemBuilder: (context, index) => steps[index],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(steps.length, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Container(
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(2),
                      color: currentStep == index
                          ? const Color(0xFF082857)
                          : Colors.grey,
                    ),
                  ),
                );
              }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: currentStep == 0
                ? NextButton(
                    onPressed: () {
                      setState(() => currentStep++);
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    text: 'Pay Now!',
                    width: double.infinity,
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      NextButton(
                        onPressed: () {
                          setState(() => currentStep--);
                          _pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        text: 'Back',
                        width: 160,
                      ),
                      NextButton(
                        onPressed: () {
                          if (currentStep < steps.length - 1) {
                            setState(() => currentStep++);
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          } else {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomeScreen(),
                              ),
                              (route) => false,
                            );
                          }
                        },
                        text:
                            currentStep == steps.length - 1 ? 'Done' : 'Submit',
                        width: 160,
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
