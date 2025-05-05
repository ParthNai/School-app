import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class CreatePaperPage extends StatefulWidget {
  final Map<String, dynamic>? course;
  
  const CreatePaperPage({super.key, this.course});

  @override
  State<CreatePaperPage> createState() => _CreatePaperPageState();
}

class _CreatePaperPageState extends State<CreatePaperPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _durationController = TextEditingController(text: '60');
  final TextEditingController _totalMarksController = TextEditingController(text: '100');
  
  String _selectedSubject = 'Mathematics';
  String _selectedGrade = '10';
  String _selectedQuestionType = 'Multiple Choice';
  
  final List<Map<String, dynamic>> _questions = [];
  
  @override
  void initState() {
    super.initState();
    // Pre-fill fields if course is provided
    if (widget.course != null) {
      _selectedSubject = widget.course!['subject'];
      _selectedGrade = widget.course!['grade'];
      _titleController.text = '${widget.course!['name']} Exam';
      _descriptionController.text = 'Final examination for ${widget.course!['name']}';
    }
  }
  
  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _durationController.dispose();
    _totalMarksController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.course != null 
            ? 'Create Paper for ${widget.course!['name']}' 
            : 'Create New Paper'),
        backgroundColor: Colors.white,
        foregroundColor: AppTheme.primaryColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left panel - Paper settings
            Expanded(
              flex: 1,
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Paper Settings',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 24),
                      TextField(
                        controller: _titleController,
                        decoration: const InputDecoration(
                          labelText: 'Paper Title',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _descriptionController,
                        decoration: const InputDecoration(
                          labelText: 'Description',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 3,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              value: _selectedSubject,
                              decoration: const InputDecoration(
                                labelText: 'Subject',
                                border: OutlineInputBorder(),
                              ),
                              items: [
                                'Mathematics', 'Physics', 'Chemistry', 'Biology',
                                'English', 'History', 'Geography', 'Computer Science'
                              ].map((subject) {
                                return DropdownMenuItem(
                                  value: subject,
                                  child: Text(subject),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedSubject = value!;
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              value: _selectedGrade,
                              decoration: const InputDecoration(
                                labelText: 'Grade',
                                border: OutlineInputBorder(),
                              ),
                              items: ['9', '10', '11', '12'].map((grade) {
                                return DropdownMenuItem(
                                  value: grade,
                                  child: Text('Grade $grade'),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedGrade = value!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _durationController,
                              decoration: const InputDecoration(
                                labelText: 'Duration (minutes)',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: TextField(
                              controller: _totalMarksController,
                              decoration: const InputDecoration(
                                labelText: 'Total Marks',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      const Text(
                        'Add Question',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        value: _selectedQuestionType,
                        decoration: const InputDecoration(
                          labelText: 'Question Type',
                          border: OutlineInputBorder(),
                        ),
                        items: const [
                          DropdownMenuItem(value: 'Multiple Choice', child: Text('Multiple Choice')),
                          DropdownMenuItem(value: 'True/False', child: Text('True/False')),
                          DropdownMenuItem(value: 'Short Answer', child: Text('Short Answer')),
                          DropdownMenuItem(value: 'Essay', child: Text('Essay')),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _selectedQuestionType = value!;
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: _addQuestion,
                          icon: const Icon(Icons.add),
                          label: const Text('Add Question'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _savePaper,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text('Save Paper'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 24),
            // Right panel - Questions list
            Expanded(
              flex: 2,
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Questions',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Total: ${_questions.length} questions',
                            style: TextStyle(
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: _questions.isEmpty
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.assignment_outlined,
                                      size: 64,
                                      color: Colors.grey[400],
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      'No questions added yet',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Add questions from the left panel',
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : ListView.builder(
                                itemCount: _questions.length,
                                itemBuilder: (context, index) {
                                  final question = _questions[index];
                                  return _buildQuestionItem(question, index);
                                },
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionItem(Map<String, dynamic> question, int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Question ${index + 1}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '${question['marks']} marks',
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      question['type'],
                      style: TextStyle(
                        color: _getQuestionTypeColor(question['type']),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 16),
                    IconButton(
                      icon: const Icon(Icons.edit, size: 20),
                      onPressed: () => _editQuestion(index),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                    const SizedBox(width: 16),
                    IconButton(
                      icon: const Icon(Icons.delete, size: 20, color: Colors.red),
                      onPressed: () => _deleteQuestion(index),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(question['text']),
            const SizedBox(height: 8),
            if (question['type'] == 'Multiple Choice')
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (int i = 0; i < question['options'].length; i++)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: Row(
                        children: [
                          Icon(
                            question['answer'] == i
                                ? Icons.radio_button_checked
                                : Icons.radio_button_unchecked,
                            size: 16,
                            color: question['answer'] == i
                                ? AppTheme.primaryColor
                                : Colors.grey,
                          ),
                          const SizedBox(width: 8),
                          Text(question['options'][i]),
                        ],
                      ),
                    ),
                ],
              ),
            if (question['type'] == 'True/False')
              Row(
                children: [
                  Icon(
                    question['answer'] ? Icons.check_circle : Icons.cancel,
                    size: 16,
                    color: question['answer'] ? Colors.green : Colors.red,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Answer: ${question['answer'] ? 'True' : 'False'}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            if (question['type'] == 'Short Answer' || question['type'] == 'Essay')
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Model Answer:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(question['answer']),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Color _getQuestionTypeColor(String type) {
    switch (type) {
      case 'Multiple Choice':
        return Colors.blue;
      case 'True/False':
        return Colors.green;
      case 'Short Answer':
        return Colors.orange;
      case 'Essay':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  void _addQuestion() {
    // Show dialog to add question
    final TextEditingController questionController = TextEditingController();
    final TextEditingController marksController = TextEditingController(text: '5');
    
    // For multiple choice
    final List<TextEditingController> optionControllers = List.generate(
      4, (index) => TextEditingController(),
    );
    int selectedOption = 0;
    
    // For true/false
    bool isTrueSelected = true;
    
    // For short answer and essay
    final TextEditingController answerController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Add $_selectedQuestionType Question'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: questionController,
                      decoration: const InputDecoration(
                        labelText: 'Question Text',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: marksController,
                      decoration: const InputDecoration(
                        labelText: 'Marks',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),
                    if (_selectedQuestionType == 'Multiple Choice') ...[
                      const Text(
                        'Options:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      for (int i = 0; i < optionControllers.length; i++)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            children: [
                              Radio<int>(
                                value: i,
                                groupValue: selectedOption,
                                onChanged: (value) {
                                  setState(() {
                                    selectedOption = value!;
                                  });
                                },
                              ),
                              Expanded(
                                child: TextField(
                                  controller: optionControllers[i],
                                  decoration: InputDecoration(
                                    labelText: 'Option ${String.fromCharCode(65 + i)}',
                                    border: const OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                    if (_selectedQuestionType == 'True/False') ...[
                      const Text(
                        'Answer:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Radio<bool>(
                            value: true,
                            groupValue: isTrueSelected,
                            onChanged: (value) {
                              setState(() {
                                isTrueSelected = value!;
                              });
                            },
                          ),
                          const Text('True'),
                          const SizedBox(width: 16),
                          Radio<bool>(
                            value: false,
                            groupValue: isTrueSelected,
                            onChanged: (value) {
                              setState(() {
                                isTrueSelected = value!;
                              });
                            },
                          ),
                          const Text('False'),
                        ],
                      ),
                    ],
                    if (_selectedQuestionType == 'Short Answer' || _selectedQuestionType == 'Essay') ...[
                      const Text(
                        'Model Answer:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: answerController,
                        decoration: const InputDecoration(
                          labelText: 'Answer',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: _selectedQuestionType == 'Essay' ? 5 : 3,
                      ),
                    ],
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (questionController.text.isEmpty) {
                      return;
                    }
                    
                    final Map<String, dynamic> newQuestion = {
                      'text': questionController.text,
                      'type': _selectedQuestionType,
                      'marks': int.tryParse(marksController.text) ?? 5,
                    };
                    
                    if (_selectedQuestionType == 'Multiple Choice') {
                      final List<String> options = optionControllers
                          .map((controller) => controller.text.isEmpty ? 'Option' : controller.text)
                          .toList();
                      newQuestion['options'] = options;
                      newQuestion['answer'] = selectedOption;
                    } else if (_selectedQuestionType == 'True/False') {
                      newQuestion['answer'] = isTrueSelected;
                    } else {
                      newQuestion['answer'] = answerController.text;
                    }
                    
                    this.setState(() {
                      _questions.add(newQuestion);
                    });
                    
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                  ),
                  child: const Text('Add Question'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _editQuestion(int index) {
    // Implement edit question functionality
    final question = _questions[index];
    final TextEditingController questionController = TextEditingController(text: question['text']);
    final TextEditingController marksController = TextEditingController(text: question['marks'].toString());
    
    // For multiple choice
    final List<TextEditingController> optionControllers = [];
    if (question['type'] == 'Multiple Choice') {
      for (String option in question['options']) {
        optionControllers.add(TextEditingController(text: option));
      }
    }
    int selectedOption = question['type'] == 'Multiple Choice' ? question['answer'] : 0;
    
    // For true/false
    bool isTrueSelected = question['type'] == 'True/False' ? question['answer'] : true;
    
    // For short answer and essay
    final TextEditingController answerController = TextEditingController(
      text: question['type'] == 'Short Answer' || question['type'] == 'Essay' ? question['answer'] : '',
    );
    
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Edit ${question['type']} Question'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: questionController,
                      decoration: const InputDecoration(
                        labelText: 'Question Text',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: marksController,
                      decoration: const InputDecoration(
                        labelText: 'Marks',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),
                    if (question['type'] == 'Multiple Choice') ...[
                      const Text(
                        'Options:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      for (int i = 0; i < optionControllers.length; i++)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            children: [
                              Radio<int>(
                                value: i,
                                groupValue: selectedOption,
                                onChanged: (value) {
                                  setState(() {
                                    selectedOption = value!;
                                  });
                                },
                              ),
                              Expanded(
                                child: TextField(
                                  controller: optionControllers[i],
                                  decoration: InputDecoration(
                                    labelText: 'Option ${String.fromCharCode(65 + i)}',
                                    border: const OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                    if (question['type'] == 'True/False') ...[
                      const Text(
                        'Answer:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Radio<bool>(
                            value: true,
                            groupValue: isTrueSelected,
                            onChanged: (value) {
                              setState(() {
                                isTrueSelected = value!;
                              });
                            },
                          ),
                          const Text('True'),
                          const SizedBox(width: 16),
                          Radio<bool>(
                            value: false,
                            groupValue: isTrueSelected,
                            onChanged: (value) {
                              setState(() {
                                isTrueSelected = value!;
                              });
                            },
                          ),
                          const Text('False'),
                        ],
                      ),
                    ],
                    if (question['type'] == 'Short Answer' || question['type'] == 'Essay') ...[
                      const Text(
                        'Model Answer:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: answerController,
                        decoration: const InputDecoration(
                          labelText: 'Answer',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: question['type'] == 'Essay' ? 5 : 3,
                      ),
                    ],
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (questionController.text.isEmpty) {
                      return;
                    }
                    
                    final Map<String, dynamic> updatedQuestion = {
                      'text': questionController.text,
                      'type': question['type'],
                      'marks': int.tryParse(marksController.text) ?? 5,
                    };
                    
                    if (question['type'] == 'Multiple Choice') {
                      final List<String> options = optionControllers
                          .map((controller) => controller.text.isEmpty ? 'Option' : controller.text)
                          .toList();
                      updatedQuestion['options'] = options;
                      updatedQuestion['answer'] = selectedOption;
                    } else if (question['type'] == 'True/False') {
                      updatedQuestion['answer'] = isTrueSelected;
                    } else {
                      updatedQuestion['answer'] = answerController.text;
                    }
                    
                    this.setState(() {
                      _questions[index] = updatedQuestion;
                    });
                    
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                  ),
                  child: const Text('Update Question'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _deleteQuestion(int index) {
    // Show confirmation dialog
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Question'),
          content: const Text('Are you sure you want to delete this question?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _questions.removeAt(index);
                });
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _savePaper() {
    if (_titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a title for the paper')),
      );
      return;
    }
    
    if (_questions.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add at least one question to the paper')),
      );
      return;
    }
    
    // Calculate total marks
    int totalMarks = 0;
    for (var question in _questions) {
      totalMarks += question['marks'] as int;
    }
    
    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Paper saved successfully')),
    );
    
    // If this was called from a course, update the course's hasPaper status
    if (widget.course != null) {
      // In a real app, you would update the course in the database
      // For now, we'll just navigate back
      Navigator.pop(context);
    }
  }
}
