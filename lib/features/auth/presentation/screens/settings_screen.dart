import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:social_task/core/services/service.dart';
import 'package:social_task/features/auth/domain/entities/device_entity.dart';
import 'package:social_task/features/auth/presentation/bloc/settings_bloc.dart';
import 'package:social_task/features/auth/presentation/screens/webview_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController _urlController = TextEditingController();
  DeviceEntity? _selectedDevice;

  @override
  void initState() {
    super.initState();
    _urlController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: BlocProvider(
        create: (context) => sl<SettingsBloc>()..add(LoadSettingsEvent()),
        child: BlocConsumer<SettingsBloc, SettingsState>(
          listener: (context, state) {
            if (state is SettingsLoaded) {
              _urlController.text = state.url;
              if (state.devicesError != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error loading devices: ${state.devicesError!.message}')),
                );
              }
            } else if (state is SettingsUrlSaved) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('URL saved successfully!')),
              );
              _urlController.text = state.url;
            } else if (state is SettingsError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.failure.message)),
              );
            }
          },
          builder: (context, state) {
            final devices = state.devices;
            final isLoading = state is SettingsLoading;
            
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  const Text('Web View URL', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _urlController,
                    decoration: InputDecoration(
                      hintText: 'Enter web url (e.g., https://google.com)',
                      border: const OutlineInputBorder(),
                      suffixIcon: isLoading 
                          ? const Padding(padding: EdgeInsets.all(8.0), child: CircularProgressIndicator(strokeWidth: 2))
                          : IconButton(
                              icon: const Icon(Icons.save),
                              onPressed: _urlController.text.isEmpty
                                  ? null
                                  : () {
                                      context.read<SettingsBloc>().add(
                                        SaveUrlEvent(url: _urlController.text.trim()),
                                      );
                                    },
                            ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  const Text('Access Network Devices', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<DeviceEntity>(
                    decoration: const InputDecoration(
                      labelText: 'Select Printer/Device',
                      border: OutlineInputBorder(),
                    ),
                    value: _selectedDevice,
                    items: devices.map((device) {
                      return DropdownMenuItem(
                        value: device,
                        child: Text('${device.name} (${device.address})'),
                      );
                    }).toList(),
                    onChanged: (DeviceEntity? newValue) {
                      setState(() {
                        _selectedDevice = newValue;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Selected: ${newValue?.name}')),
                      );
                    },
                    hint: const Text('No devices found or select a device'),
                  ),
                  const SizedBox(height: 40),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.blue.shade700,
                    ),
                    onPressed: state.url.isNotEmpty
                        ? () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => WebViewScreen(url: state.url)),
                            );
                          }
                        : null,
                    child: const Text(
                      'Go to Web View',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}