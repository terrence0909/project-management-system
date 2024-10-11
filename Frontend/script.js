document.addEventListener('DOMContentLoaded', function () {
    const taskForm = document.getElementById('task-form');
    const taskList = document.getElementById('task-list');

    // Function to fetch tasks and display them
    async function fetchTasks() {
        try {
            const response = await fetch('http://127.0.0.1:5000/tasks');
            const tasks = await response.json();
            taskList.innerHTML = ''; // Clear the current list
            tasks.forEach(task => {
                addTaskToDOM(task); // Add each task to the DOM
            });
        } catch (error) {
            console.error('Error fetching tasks:', error);
        }
    }

    // Function to add a task to the DOM
    function addTaskToDOM(task) {
        const li = document.createElement('li');
        li.className = 'list-group-item';
        li.textContent = `${task.task} (Due: ${task.date})`; // Display the task name and date
        li.id = `task-${task.id}`; // Set a unique ID for the list item

        // Create a delete button
        const deleteButton = document.createElement('button');
        deleteButton.className = 'btn btn-danger btn-sm float-right';
        deleteButton.textContent = 'Delete';
        deleteButton.onclick = async function () {
            await deleteTask(task.id);
        };

        li.appendChild(deleteButton); // Append the delete button to the list item
        taskList.appendChild(li); // Add the task item to the list
    }

    // Function to delete a task
    async function deleteTask(taskId) {
        try {
            const response = await fetch(`http://127.0.0.1:5000/tasks/${taskId}`, {
                method: 'DELETE',
            });

            if (response.ok) {
                document.getElementById(`task-${taskId}`).remove(); // Remove the task from the DOM
                alert('Task deleted successfully!'); // Show success message
            } else {
                const result = await response.json();
                alert(result.message); // Show error message
            }
        } catch (error) {
            console.error('Error deleting task:', error);
            alert('Failed to delete task. Please try again.'); // Show error message
        }
    }

    taskForm.addEventListener('submit', async function (e) {
        e.preventDefault(); // Prevent the form from submitting normally

        const taskName = document.getElementById('task-name').value;
        const taskDate = document.getElementById('task-date').value;

        if (taskName && taskDate) {
            try {
                const response = await fetch('http://127.0.0.1:5000/tasks', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        task: taskName,
                        date: taskDate
                    })
                });

                const result = await response.json();
                alert(result.message); // Show success message

                if (response.ok) {
                    // Fetch the updated task list to include the new task
                    fetchTasks();
                }
            } catch (error) {
                console.error('Error adding task:', error);
                alert('Failed to add task. Please try again.'); // Show error message
            }
        } else {
            alert('Please enter both task name and date.'); // Alert if inputs are missing
        }

        // Clear the input fields after submission
        taskForm.reset();
    });

    // Initial fetch of tasks when the page loads
    fetchTasks();
});
