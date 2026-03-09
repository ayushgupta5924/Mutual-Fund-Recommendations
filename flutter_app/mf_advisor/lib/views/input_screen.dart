import 'package:flutter/material.dart';
import '../models/models.dart';
import '../services/api_service.dart';
import 'results_screen.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final _formKey = GlobalKey<FormState>();
  final _budgetController = TextEditingController();
  final _ageController = TextEditingController();
  final _horizonController = TextEditingController();
  
  String _riskTolerance = 'moderate';
  final List<String> _selectedGoals = [];
  bool _isLoading = false;

  final List<Map<String, String>> _goals = [
    {'value': 'retirement', 'label': 'Retirement'},
    {'value': 'wealth_creation', 'label': 'Wealth Creation'},
    {'value': 'education', 'label': 'Education'},
    {'value': 'tax_saving', 'label': 'Tax Saving'},
    {'value': 'short_term', 'label': 'Short Term'},
  ];

  Future<void> _getRecommendations() async {
    if (!_formKey.currentState!.validate() || _selectedGoals.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields and select at least one goal')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final profile = UserProfile(
        budget: double.parse(_budgetController.text),
        riskTolerance: _riskTolerance,
        investmentHorizon: int.parse(_horizonController.text),
        goals: _selectedGoals,
        age: int.parse(_ageController.text),
      );

      final recommendations = await ApiService().getRecommendations(profile);
      
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultsScreen(
              recommendations: recommendations,
              budget: profile.budget,
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            duration: const Duration(seconds: 5),
            backgroundColor: Colors.red.shade700,
          ),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('Your Investment Profile', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue.shade700,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.blue.shade700, Colors.blue.shade500],
                ),
              ),
              child: const Column(
                children: [
                  Icon(Icons.person_outline, size: 60, color: Colors.white),
                  SizedBox(height: 8),
                  Text(
                    'Tell us about yourself',
                    style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'We\'ll find the perfect funds for you',
                    style: TextStyle(fontSize: 14, color: Colors.white70),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildCard([
                      const Text('Basic Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 16),
                      _buildTextField(_budgetController, 'Investment Budget (₹)', Icons.currency_rupee),
                      const SizedBox(height: 12),
                      _buildTextField(_ageController, 'Your Age', Icons.cake),
                      const SizedBox(height: 12),
                      _buildTextField(_horizonController, 'Investment Horizon (years)', Icons.calendar_today),
                    ]),
                    
                    const SizedBox(height: 16),
                    
                    _buildCard([
                      const Text('Risk Tolerance', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      _buildRiskOption('Low', 'Stable returns, minimal risk', Icons.shield, Colors.green),
                      _buildRiskOption('Moderate', 'Balanced growth & stability', Icons.balance, Colors.orange),
                      _buildRiskOption('High', 'Maximum growth potential', Icons.trending_up, Colors.red),
                    ]),
                    
                    const SizedBox(height: 16),
                    
                    _buildCard([
                      const Text('Investment Goals', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      ..._goals.map((goal) => _buildGoalCheckbox(goal)),
                    ]),
                    
                    const SizedBox(height: 24),
                    
                    SizedBox(
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _getRecommendations,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade700,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          elevation: 0,
                        ),
                        child: _isLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.auto_awesome, color: Colors.white),
                                  SizedBox(width: 8),
                                  Text('Get Recommendations', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
                                ],
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: children),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.blue.shade700),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.grey.shade50,
      ),
      keyboardType: TextInputType.number,
      validator: (v) => v!.isEmpty ? 'Required' : null,
    );
  }

  Widget _buildRiskOption(String value, String desc, IconData icon, Color color) {
    final isSelected = _riskTolerance == value.toLowerCase();
    return GestureDetector(
      onTap: () => setState(() => _riskTolerance = value.toLowerCase()),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.1) : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? color : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? color : Colors.grey),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(value, style: TextStyle(fontWeight: FontWeight.bold, color: isSelected ? color : Colors.black)),
                  Text(desc, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ),
            if (isSelected) Icon(Icons.check_circle, color: color),
          ],
        ),
      ),
    );
  }

  Widget _buildGoalCheckbox(Map<String, String> goal) {
    final isSelected = _selectedGoals.contains(goal['value']);
    return CheckboxListTile(
      title: Text(goal['label']!),
      value: isSelected,
      onChanged: (checked) {
        setState(() {
          if (checked!) {
            _selectedGoals.add(goal['value']!);
          } else {
            _selectedGoals.remove(goal['value']);
          }
        });
      },
      activeColor: Colors.blue.shade700,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      contentPadding: EdgeInsets.zero,
    );
  }
}
