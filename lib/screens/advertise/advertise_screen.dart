import 'package:flutter/material.dart';
import 'package:jeep_ads/widgets/common/next_button.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:jeep_ads/screens/home/home_screen.dart';

class AdvertiseScreen extends StatefulWidget {
  const AdvertiseScreen({super.key});

  @override
  State<AdvertiseScreen> createState() => _AdvertiseScreenState();
}

class _AdvertiseScreenState extends State<AdvertiseScreen> {
  int currentStep = 0;
  final PageController _pageController = PageController();

  int months1 = 1; // Tracks the number of months for section 1
  int months2 = 1; // Tracks the number of months for section 2
  int selectedDuration = 30; // Tracks selected video duration
  int subtotal = 0; // Tracks subtotal
  int discount = 0; // Tracks discount
  int totalPrice = 0; // Tracks total price

  DateTime? startDate;
  DateTime? endDate;

  // Update subtotal when video duration is selected
  void updateSubtotal() {
    setState(() {
      // Example pricing logic:
      int videoDurationFactor = (selectedDuration == 30) ? 1 : 2;
      subtotal = months1 * months2 * videoDurationFactor;
      
      // Simple discount logic (10% off for now)
      discount = (subtotal * 0.10).toInt(); 
      
      // Calculate total price after discount
      totalPrice = subtotal - discount;
    });
  }

  List<Widget> getSteps() => [
        _buildStepContent('Enter your Ad Campaign Name', 'Enter Ad Campaign Name*'),
        // Only one step, add both Set Months directly below each other
        Column(
          children: [
            _buildSetMonthsLayout('Set Months', months1, (value) {
              setState(() {
                months1 = value;
              });
              updateSubtotal(); // Update subtotal when months1 changes
            }),
            _buildDateFields(),
            _buildSetMonthsLayout('Set Number of Jeeps', months2, (value) {
              setState(() {
                months2 = value;
              });
              updateSubtotal(); // Update subtotal when months2 changes
            }),
            const SizedBox(height: 18),
            _buildSelectVideoDuration(), // Add Select Video Duration section
            const SizedBox(height: 18),
            const Divider(),
             const SizedBox(height: 14),
            _buildSubtotal(), // Add Subtotal section
            const SizedBox(height: 12),
            _buildDiscount(), // Add Discount section
            const SizedBox(height: 12),
            _buildTotalPrice(), // Add Total Price section
          ],
        ),
        _buildVideoUploadSection(),
        _buildVerificationStep(),
      ];

  Widget _buildSetMonthsLayout(String title, int months, Function(int) onChanged) {
    return Padding(
      padding: const EdgeInsets.only(left: 42, right: 42, top: 42),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            title,
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(8, 40, 87, 1),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Set the Number of Modern Jeeps you would like\n to run your Ad',
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  if (months > 1) onChanged(months - 1); // Decrease months
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(21, 30),
                  backgroundColor:  const Color(0xFFF1F1F1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),

                child: const Text(
                  '-',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Text(
                '$months',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: () {
                  onChanged(months + 1); // Increase months
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(21, 30),
                  backgroundColor: const Color(0xFF0171BB),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: const Text(
                  '+',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDateFields() {
    return Padding(
      padding: const EdgeInsets.only(left: 42, right: 42),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Start Date',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      height: 22,
                   
                      child: TextButton(
                        onPressed: () {
                          // TODO: Implement date picker
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Icon(
                              Icons.calendar_today,
                              color: Color(0xFF8C8C8C),
                              size: 18,
                            ),
                            Text(
                              'Select Date',
                              style: TextStyle(
                                color: Color(0xFF8C8C8C),
                                fontSize: 14,
                              ),
                            ),
                          
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              const Text('-',style: TextStyle(fontSize: 54,fontWeight: FontWeight.w100,color: Colors.black),),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  
                  crossAxisAlignment: CrossAxisAlignment.start,


                  children: [
                    const Text(
                      'End Date',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      height:22,
                      
                      child: TextButton(
                        onPressed: () {
                          // TODO: Implement date picker
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Icon(
                              Icons.calendar_today,
                              color: Color(0xFF8C8C8C),
                              size: 18,
                            ),
                            Text(
                              'Select Date',
                              style: TextStyle(
                                color: Color(0xFF8C8C8C),
                                fontSize: 14,
                              ),
                            ),
                            
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSelectVideoDuration() {
    return Padding(
      padding: const EdgeInsets.only(left: 42, right: 42),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            'Select Video Duration',
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(8, 40, 87, 1),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Select the duration for your video (in seconds)',
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectedDuration = 30;
                  });
                  updateSubtotal();
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(21, 30),
                  backgroundColor: selectedDuration == 30 
                      ? const Color(0xFF0171BB)
                      : const Color(0xFFF1F1F1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: Text(
                  '30s',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    color: selectedDuration == 30 ? Colors.white : Colors.black,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectedDuration = 60;
                  });
                  updateSubtotal();
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(21, 30),
                  backgroundColor: selectedDuration == 60 
                      ? const Color(0xFF0171BB)
                      : const Color(0xFFF1F1F1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: Text(
                  '60s',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    color: selectedDuration == 60 ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSubtotal() {
    return Padding(
      padding: const EdgeInsets.only(left: 42, right: 42),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Text(
            'Subtotal:',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w300,
              color: Colors.black,
            ),
          ),
          Text(
            '\$$subtotal',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w300,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDiscount() {
    return Padding(
      padding: const EdgeInsets.only(left: 42, right: 42),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Text(
            'Discount:',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w300,
              color: Colors.black,
            ),
          ),
          Text(
            '-\$$discount',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w300,
              color: Colors.black,
            ),
          ),
        ],


      ),
    );
  }

  Widget _buildTotalPrice() {
    return Padding(
      padding: const EdgeInsets.only(left: 42, right: 42),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Text(
            'Total Price:',
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.w300,
              color: Colors.amber,
            ),
          ),
          Text(
            '\$$totalPrice',
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.w300,
              color: Colors.amber,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepContent(String title, String hintText) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(8, 40, 87, 1),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: TextField(
              maxLength: 50,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[600],
                ),
                border: const UnderlineInputBorder(),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[600]!),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF082857)),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                counterText: '',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoUploadSection() {
    return Padding(
      padding: const EdgeInsets.only(left: 42, right: 42, top: 42),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Upload Video',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(8, 40, 87, 1),
            ),
          ),
          const SizedBox(height: 20),
          DottedBorder(
            color: const Color(0xFF9E9E9E),
            strokeWidth: 2,
            dashPattern: const [8, 4],
            borderType: BorderType.RRect,
            radius: const Radius.circular(10),
            child: Container(
              width:  double.infinity,
              height: 200,
              color: const Color(0xFFF5F5F5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.cloud_upload_outlined,
                    size: 48,
                    color: Color(0xFF0171BB),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Upload your \n video Advertisment Here',
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
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Video Guidelines',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                const SizedBox(height: 12),
                _buildGuideline('Supported Formats:\n MP4, MOV, AVI'),
                const SizedBox(height: 8),
                _buildGuideline('Recommended reselution:\n 720p'),
                const SizedBox(height: 8),
                _buildGuideline('Video Maximum Duration:\n 60s'),
                const SizedBox(height: 8),
                _buildGuideline('Video Size Limit:\n 100 MB'),
                const SizedBox(height: 12),


              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGuideline(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: 
          Text(
            text,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
    );
  }

  Widget _buildVerificationStep() {
    return Padding(
      padding: const EdgeInsets.only(left: 42, right: 42, top: 42),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const Text(
            'Video Verification being\n Processed',
            textAlign: TextAlign.start,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 24,
              fontWeight: FontWeight.w500,
              height: 36/24,
              color:  Color(0xff082857),
            ),
          ),
          const SizedBox(height: 16),

          const Text(
            'Video Verification will take 1 - 24 hours.\nAfter successful verification, you may now\n then Pay and Run your Ads!',
            textAlign: TextAlign.start,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              height: 24/14,
              color: Colors.black87,
            ),

          ),
          const SizedBox(height: 60),
          Image.asset(
            'lib/images/verification.png', // Make sure to add this image to your assets
            width: double.infinity,
            height: 300,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final steps = getSteps();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Ad Campaigns',
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
              itemBuilder: (context, index) => Center(child: steps[index]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              color: Colors.white,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
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
            ),
          ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (currentStep > 0)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: NextButton(
                        onPressed: () {
                          setState(() => currentStep--);
                          _pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        text: 'Back',
                        width: double.infinity,
                      ),
                    ),
                  )
                else
                  const SizedBox(width: 8),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: NextButton(
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
                      text: currentStep == steps.length - 1 ? 'Done' : 'Next',
                      width: double.infinity,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
