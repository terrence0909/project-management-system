from flask import Flask, jsonify, request
from flask_cors import CORS  # Import CORS

app = Flask(__name__)
CORS(app)  # Enable CORS for all routes

# In-memory task storage (will be lost on server restart)
tasks = []

# Route for the homepage
@app.route('/')
def home():
    return "Welcome to the construction project management system"

# Route to get all tasks
@app.route('/tasks', methods=['GET'])
def get_tasks():
    return jsonify(tasks)

# Route to add a task
@app.route('/tasks', methods=['POST'])
def add_task():
    try:
        task_data = request.json
        task_name = task_data.get('task')
        task_date = task_data.get('date')  # Including the date
        if task_name and task_date and isinstance(task_name, str):
            task = {'id': len(tasks) + 1, 'task': task_name, 'date': task_date}
            tasks.append(task)
            return jsonify({'message': 'Task added successfully!'}), 201
        return jsonify({'message': 'Invalid task provided!'}), 400
    except Exception as e:
        return jsonify({'message': str(e)}), 500

# Route to delete a task
@app.route('/tasks/<int:task_id>', methods=['DELETE'])
def delete_task(task_id):
    global tasks
    tasks = [task for task in tasks if task['id'] != task_id]
    return jsonify({'message': 'Task deleted successfully!'}), 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)  # Running on port 5000 by default
