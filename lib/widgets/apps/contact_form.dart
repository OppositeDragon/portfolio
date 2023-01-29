import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/controllers/contact_form_controller.dart';
import 'package:validators/validators.dart';

class ContactForm extends ConsumerStatefulWidget {
  const ContactForm({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ContactFormState();
}

class _ContactFormState extends ConsumerState<ContactForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _messageController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _messageController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cfs = ref.watch(cfcProvider);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xE4FFFFFF), Colors.purple],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.7, 1],
            tileMode: TileMode.clamp,
          ),
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(2),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(12),
            child: Form(
              key: _formKey,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 350),
                child: Column(
                  children: [
                    Text('Contact Me', style: Theme.of(context).textTheme.headlineMedium),
                    const SizedBox(height: 4),
                    TextFormField(
                      controller: _nameController,
                      autofocus: true,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!isEmail(value)) {
                          return 'Please enter a valid email';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _messageController,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        labelText: 'Message',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your message';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final emailDetails = {
                            'user_name': _nameController.text.trim(),
                            'user_email': _emailController.text.trim().toLowerCase(),
                            'user_message': _messageController.text.trim(),
                          };
                          await ref.read(cfcProvider.notifier).sendEmail(emailDetails);
                        }
                      },
                      child: Center(
                        child: cfs.isLoading
                            ? const SizedBox(
                                height: 2,
                                child: LinearProgressIndicator(color: Colors.white),
                              )
                            : cfs.sent == 2
                                ? Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Text('An error occurred'),
                                      SizedBox(width: 10),
                                      Icon(
                                        Icons.check,
                                        color: Colors.redAccent,
                                      )
                                    ],
                                  )
                                : cfs.sent == 1
                                    ? Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: const [
                                          Text('Message Sent'),
                                          SizedBox(width: 10),
                                          Icon(
                                            Icons.check,
                                            color: Colors.greenAccent,
                                          )
                                        ],
                                      )
                                    : const Text('Send'),
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
