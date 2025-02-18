import 'package:flutter/material.dart';
import '../../models/notifications/ad_campaign.dart';
import '../notifications/notifications_screen.dart';
import '../../widgets/common/cancel_button.dart';
import '../profile/profile_screen.dart';
import '../advertise/advertise_screen.dart';
import '../payment/payment_screen.dart';
import '../statistics/ad_statistics_screen.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  String _searchQuery = '';
  final _searchController = TextEditingController();
  AdStatus? _selectedStatus;

  Widget get _currentPage {
    switch (_selectedIndex) {
      case 0:
        return AdsPage(
          searchQuery: _searchQuery,
          filterStatus: _selectedStatus,
        );
      case 1:
        return const UserProfilePage();
      default:
        return const AdsPage();
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _selectedIndex == 0
          ? const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.center,
                colors: [
                  Color(0xFFFFB222),
                  Colors.white,
                ],
              ),
            )
          : null,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: false,
        appBar: _selectedIndex == 0
            ? AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                surfaceTintColor: Colors.transparent,
                shadowColor: Colors.transparent,
                scrolledUnderElevation: 0,
                systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarColor: Colors.transparent,
                  statusBarIconBrightness: Brightness.dark,
                ),
                title: const Text(
                  'Ad Campaigns',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.filter_list, color: Colors.white),
                    onPressed: () => _showFilterBottomSheet(context),
                  ),
                  IconButton(
                    icon: const Icon(Icons.notifications, color: Colors.white),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NotificationsScreen(),
                        ),
                      );
                    },
                  ),
                ],
              )
            : null,
        body: Column(
          children: [
            if (_selectedIndex == 0)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search campaign name',
                    suffixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(
                        color: Colors.grey.shade300,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade50,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                ),
              ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _currentPage,
                  ],
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 50),
            FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AdvertiseScreen(),
                  ),
                );
              },
              shape: const CircleBorder(),
              backgroundColor: const Color.fromARGB(221, 12, 9, 60),
              child: const Icon(Icons.add, color: Colors.white),
            ),
            const SizedBox(height: 4),
            const Text(
              'Advertise Now',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(221, 12, 9, 60),
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          elevation: 0,
          shape: const CircularNotchedRectangle(),
          notchMargin: 6,
          child: Container(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavBarItem(0, Icons.tv_outlined, 'Ads'),
                const SizedBox(width: 48), // Space for FAB
                _buildNavBarItem(1, Icons.person_outline, 'User'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavBarItem(int index, IconData icon, String label) {
    return InkWell(
      onTap: () => setState(() => _selectedIndex = index),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  icon,
                  color: _selectedIndex == index
                      ? Theme.of(context).primaryColor
                      : Colors.grey,
                ),
                if (index == 0)
                  Positioned(
                    child: Icon(
                      Icons.play_circle_outline,
                      size: 12,
                      color: _selectedIndex == index
                          ? Theme.of(context).primaryColor
                          : Colors.grey,
                    ),
                  ),
              ],
            ),
            Text(
              label,
              style: TextStyle(
                color: _selectedIndex == index
                    ? Theme.of(context).primaryColor
                    : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Filter by Status',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...AdStatus.values.map((status) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _selectedStatus =
                                _selectedStatus == status ? null : status;
                          });
                          Navigator.pop(context);
                          this.setState(() {});
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: status.color.withOpacity(0.1),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Container(
                                        width: 12,
                                        height: 12,
                                        decoration: BoxDecoration(
                                          color: status.color,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    status.label,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      height: 16 / 14,
                                      color: _selectedStatus == status
                                          ? status.color
                                          : Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'This is just to fill up space since copy isn\'t ready. ',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      height: 12 / 20,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                  if (_selectedStatus != null) ...[
                    const SizedBox(height: 16),
                    CancelButton(
                      onPressed: () {
                        setState(() {
                          _selectedStatus = null;
                        });
                        Navigator.pop(context);
                        this.setState(() {});
                      },
                      text: 'Clear Filter',
                      height: 48,
                    ),
                  ],
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class AdsPage extends StatefulWidget {
  final String searchQuery;
  final AdStatus? filterStatus;

  const AdsPage({
    super.key,
    this.searchQuery = '',
    this.filterStatus,
  });

  @override
  State<AdsPage> createState() => _AdsPageState();
}

class _AdsPageState extends State<AdsPage> {
  // Sample video ad campaign data
  final List<AdCampaign> _allAds = [
    AdCampaign(
      id: '1',
      title: 'Jeep Wrangler Off-Road Adventure',
      thumbnailUrl: 'https://picsum.photos/200/300',
      status: AdStatus.running,
      transactionId: 'TRX-001',
      units: 5000,
      budget: 1500.00,
      duration: '30',
      dateRange: 'Jan 01, 2024 - Feb 01, 2024',
      numberOfJeeps: 3,
      subtotal: 1500.00,
      discount: 150.00,
      months: 12,
    ),
    AdCampaign(
      id: '2',
      title: 'Jeep Grand Cherokee Luxury Tour',
      thumbnailUrl: 'https://picsum.photos/200/301',
      status: AdStatus.pendingPayment,
      transactionId: 'TRX-002',
      units: 3000,
      budget: 2500.00,
      duration: '45',
      dateRange: 'Jan 01, 2024 - Feb 01, 2024',
      numberOfJeeps: 3,
      subtotal: 2500.00,
      discount: 250.00,
      months: 12,
    ),
    AdCampaign(
      id: '3',
      title: 'Jeep Compass City Drive',
      thumbnailUrl: 'https://picsum.photos/200/302',
      status: AdStatus.running,
      transactionId: 'TRX-003',
      units: 2000,
      budget: 1000.00,
      duration: '15',
      dateRange: 'Jan 01, 2024 - Feb 01, 2024',
      numberOfJeeps: 3,
      subtotal: 1000.00,
      discount: 100.00,
      months: 12,
    ),
    AdCampaign(
      id: '4',
      title: 'Jeep Gladiator Power Demo',
      thumbnailUrl: 'https://picsum.photos/200/303',
      status: AdStatus.running,
      transactionId: 'TRX-004',
      units: 7500,
      budget: 3500.00,
      duration: '1:00',
      dateRange: 'Jan 01, 2024 - Feb 01, 2024',
      numberOfJeeps: 3,
      subtotal: 3500.00,
      discount: 350.00,
      months: 12,
    ),
    AdCampaign(
      id: '5',
      title: 'Jeep Renegade Urban Adventure',
      thumbnailUrl: 'https://picsum.photos/200/304',
      status: AdStatus.running,
      transactionId: 'TRX-005',
      units: 4000,
      budget: 1800.00,
      duration: '0:20',
      dateRange: 'Jan 01, 2024 - Feb 01, 2024',
      numberOfJeeps: 3,
      subtotal: 1500.00,
      discount: 150.00,
      months: 12,
    ),
    AdCampaign(
      id: '6',
      title: 'Jeep Cherokee Night Drive',
      thumbnailUrl: 'https://picsum.photos/200/305',
      status: AdStatus.rejected,
      transactionId: 'TRX-006',
      units: 6000,
      budget: 2800.00,
      duration: '0:40',
      dateRange: 'Jan 01, 2024 - Feb 01, 2024',
      numberOfJeeps: 3,
      subtotal: 2500.00,
      discount: 250.00,
      months: 12,
    ),
    AdCampaign(
      id: '7',
      title: 'Jeep Wagoneer Luxury Experience',
      thumbnailUrl: 'https://picsum.photos/200/306',
      status: AdStatus.running,
      transactionId: 'TRX-007',
      units: 8000,
      budget: 4500.00,
      duration: '1:30',
      dateRange: 'Jan 01, 2024 - Feb 01, 2024',
      numberOfJeeps: 3,
      subtotal: 4500.00,
      discount: 450.00,
      months: 12,
    ),
    AdCampaign(
      id: '8',
      title: 'Jeep Liberty Classic Review',
      thumbnailUrl: 'https://picsum.photos/200/307',
      status: AdStatus.closed,
      transactionId: 'TRX-008',
      units: 3500,
      budget: 1200.00,
      duration: '0:25',
      dateRange: 'Jan 01, 2024 - Feb 01, 2024',
      numberOfJeeps: 3,
      subtotal: 1200.00,
      discount: 120.00,
      months: 12,
    ),
    AdCampaign(
      id: '9',
      title: 'Jeep Patriot Family Tour',
      thumbnailUrl: 'https://picsum.photos/200/308',
      status: AdStatus.pendingPayment,
      transactionId: 'TRX-009',
      units: 4500,
      budget: 2000.00,
      duration: '0:35',
      dateRange: 'Jan 01, 2024 - Feb 01, 2024',
      numberOfJeeps: 3,
      subtotal: 2000.00,
      discount: 200.00,
      months: 12,
    ),
    AdCampaign(
      id: '10',
      title: 'Jeep Commander Mountain Challenge',
      thumbnailUrl: 'https://picsum.photos/200/309',
      status: AdStatus.running,
      transactionId: 'TRX-010',
      units: 6500,
      budget: 3000.00,
      duration: '0:50',
      dateRange: 'Jan 01, 2024 - Feb 01, 2024',
      numberOfJeeps: 3,
      subtotal: 3000.00,
      discount: 300.00,
      months: 12,
    ),
    AdCampaign(
      id: '11',
      title: 'Jeep Grand Wagoneer Premium Showcase',
      thumbnailUrl: 'https://picsum.photos/200/310',
      status: AdStatus.processing,
      transactionId: 'TRX-011',
      units: 9000,
      budget: 5500.00,
      duration: '2:00',
      dateRange: 'Jan 01, 2024 - Feb 01, 2024',
      numberOfJeeps: 3,
      subtotal: 5500.00,
      discount: 550.00,
      months: 12,
    ),
    AdCampaign(
      id: '12',
      title: 'Jeep Compass Trail Rated Test',
      thumbnailUrl: 'https://picsum.photos/200/311',
      status: AdStatus.running,
      transactionId: 'TRX-012',
      units: 5500,
      budget: 2300.00,
      duration: '0:45',
      dateRange: 'Jan 01, 2024 - Feb 01, 2024',
      numberOfJeeps: 3,
      subtotal: 2300.00,
      discount: 230.00,
      months: 12,
    ),
  ];

  List<AdCampaign> get _filteredAds {
    if (widget.searchQuery.isEmpty) return _allAds;
    return _allAds
        .where((ad) =>
            ad.title.toLowerCase().contains(widget.searchQuery.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    if (_allAds.isEmpty) {
      return Center(
        child: Card(
          margin: const EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Run Your First Ad',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // TODO: Implement ad creation
                    print('Create new ad from CTA');
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                  ),
                  child: const Text('Create Ad'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Column(
      children: _filteredAds.where((ad) {
        final matchesSearch =
            ad.title.toLowerCase().contains(widget.searchQuery.toLowerCase());
        final matchesFilter =
            widget.filterStatus == null || ad.status == widget.filterStatus;
        return matchesSearch && matchesFilter;
      }).map((ad) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: InkWell(
            onTap: () => _showActionBottomSheet(context, ad),
            child: Card(
              elevation: 4,
              shadowColor: Colors.black.withOpacity(0.5),
              margin: const EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: ad.status.color,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          ad.dateRange,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            ad.thumbnailUrl,
                            width: 180,
                            height: 130,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ad.title,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Text(
                                    'Status: ',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Color(0xFF8C8C8C),
                                      fontWeight: FontWeight.w500,
                                      height: 11 / 14,
                                    ),
                                  ),
                                  Text(
                                    ad.status.label,
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: ad.status.color,
                                      fontWeight: FontWeight.w400,
                                      height: 11 / 13,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Left Column
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Transaction ID:',
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: Color(0xFF222222),
                                            fontWeight: FontWeight.w500,
                                            height: 11 / 14,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          ad.transactionId,
                                          style: const TextStyle(
                                            fontSize: 10,
                                            color: Color(0xFF8C8C8C),
                                            fontWeight: FontWeight.w400,
                                            height: 10 / 13,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        const Text(
                                          'Budget: ',
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: Color(0xFF222222),
                                            fontWeight: FontWeight.w500,
                                            height: 11 / 14,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'PHP ${ad.budget.toStringAsFixed(2)}',
                                          style: const TextStyle(
                                            fontSize: 10,
                                            color: Color(0xFF8C8C8C),
                                            fontWeight: FontWeight.w400,
                                            height: 10 / 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Right Column
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Units: ',
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: Color(0xFF222222),
                                            fontWeight: FontWeight.w500,
                                            height: 11 / 14,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          '${ad.units}',
                                          style: const TextStyle(
                                            fontSize: 10,
                                            color: Color(0xFF8C8C8C),
                                            fontWeight: FontWeight.w400,
                                            height: 10 / 13,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        const Text(
                                          'Duration: ',
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: Color(0xFF222222),
                                            fontWeight: FontWeight.w500,
                                            height: 11 / 14,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          ad.duration,
                                          style: const TextStyle(
                                            fontSize: 10,
                                            color: Color(0xFF8C8C8C),
                                            fontWeight: FontWeight.w400,
                                            height: 10 / 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  void _showActionBottomSheet(BuildContext context, AdCampaign ad) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                ad.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              //pending payment
              const SizedBox(height: 24),
              if (ad.status == AdStatus.pendingPayment) ...[
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AdvertiseScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Icon(Icons.edit,
                                size: 40, color: Color(0xFFFF9000)),
                          ],
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Edit',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                height: 16 / 14,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'This is just to fill up space since copy isn\'t ready. ',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  height: 12 / 20),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Close bottom sheet
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentScreen(
                          totalAmount: ad.budget,
                          campaign: ad, // Pass the current ad campaign
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Icon(Icons.credit_card,
                                size: 40, color: Color(0xFFFF9000)),
                          ],
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pay Now!',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                height: 16 / 14,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Proceed to payment to start your campaign',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                height: 12 / 20,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                //RUNNING
              ] else if (ad.status == AdStatus.running) ...[
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  AdStatisticsScreen(campaign: ad),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Icon(Icons.visibility,
                                      size: 40, color: Color(0xFFFF9000)),
                                ],
                              ),
                              const SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'View',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      height: 16 / 14,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'View campaign',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        height: 12 / 20),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AdvertiseScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Icon(Icons.edit,
                                      size: 40, color: Color(0xFFFF9000)),
                                ],
                              ),
                              const SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Edit',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      height: 16 / 14,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Edit campaign',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        height: 12 / 20),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: null, // Disabled button
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[300],
                    foregroundColor: Colors.grey[600],
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Icon(Icons.credit_card,
                                size: 40, color: Colors.grey[600]),
                          ],
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pay Now',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                height: 16 / 14,
                                color: Colors.grey[600],
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'This is just to fill up space since copy isn\'t ready. ',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                height: 12 / 20,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
              if (ad.status == AdStatus.rejected) ...[
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AdvertiseScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Icon(Icons.edit,
                                size: 40, color: Color(0xFFFF9000)),
                          ],
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Edit',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                height: 16 / 14,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'This is just to fill up space since copy isn\'t ready. ',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  height: 12 / 20),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: null, // Disabled button
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[300],
                    foregroundColor: Colors.grey[600],
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Icon(Icons.credit_card,
                                size: 40, color: Colors.grey[600]),
                          ],
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pay Now',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                height: 16 / 14,
                                color: Colors.grey[600],
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'This is just to fill up space since copy isn\'t ready. ',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                height: 12 / 20,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
              if (ad.status == AdStatus.processing) ...[
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AdvertiseScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Icon(Icons.edit,
                                size: 40, color: Color(0xFFFF9000)),
                          ],
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Edit',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                height: 16 / 14,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'This is just to fill up space since copy isn\'t ready. ',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  height: 12 / 20),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: null, // Disabled button
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[300],
                    foregroundColor: Colors.grey[600],
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Icon(Icons.credit_card,
                                size: 40, color: Colors.grey[600]),
                          ],
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pay Now!',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                height: 16 / 14,
                                color: Colors.grey[600],
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'This is just to fill up space since copy isn\'t ready. ',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                height: 12 / 20,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
              if (ad.status == AdStatus.closed) ...[
                ElevatedButton(
                  onPressed: () {
                    // TODO: Implement run again flow
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Icon(Icons.refresh,
                                size: 40, color: Color(0xFFFF9000)),
                          ],
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Run Again',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                height: 16 / 14,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'This is just to fill up space since copy isn\'t ready. ',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  height: 12 / 20),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 12),
              CancelButton(
                onPressed: () => Navigator.pop(context),
                text: 'Cancel',
                height: 48,
              ),
            ],
          ),
        );
      },
    );
  }
}
