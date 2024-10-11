
# Construction Project Management System

This is a web application designed to manage construction projects. It consists of a frontend and a backend connected to AWS infrastructure. The system aims to streamline project management, enhance collaboration among team members, and improve overall efficiency in the construction process.

## Project Structure
- **backend/**: Contains the Flask application and its configurations.
- **frontend/**: Contains the HTML, CSS, and JavaScript files for the client-side.
- **terraform/**: Contains Terraform scripts for deploying AWS resources.
- **jenkins/**: Contains Jenkins configurations for continuous integration and deployment (CI/CD).
- **.env**: Environment variables for application configuration.
- **.gitignore**: Files and directories to be ignored by Git.
- **README.md**: Project documentation.

## Technologies Used
- **Frontend**: HTML, CSS, JavaScript (with frameworks/libraries such as React or Bootstrap if applicable)
- **Backend**: Flask (Python)
- **Database**: MySQL (on AWS RDS)
- **Infrastructure as Code**: Terraform
- **Continuous Integration/Deployment**: Jenkins
- **Version Control**: Git

## Setup Instructions
1. **Clone the repository:**
   ```bash
   git clone https://github.com/yourusername/project-management-system.git
   cd project-management-system

	2.	Navigate to the backend directory and install dependencies:

cd backend
pip install -r requirements.txt


	3.	Set up the frontend:
	•	Navigate to the frontend directory:

cd ../frontend

	•	Install frontend dependencies (if using Node.js):

npm install


	4.	Configure environment variables:
	•	Copy .env.example to .env and fill in the necessary values for your database and application configurations.
	5.	Run the application:
	•	For the backend:

python app.py


	•	For the frontend:

npm start



Deploying Infrastructure

To deploy the infrastructure using Terraform, follow these steps:

	1.	Navigate to the terraform directory:

cd ../terraform


	2.	Initialize Terraform:

terraform init


	3.	Apply the Terraform configuration:

terraform apply



CI/CD Pipeline

The CI/CD pipeline is set up using Jenkins. To configure Jenkins:

	1.	Install Jenkins on your server.
	2.	Create a new pipeline job in Jenkins.
	3.	Link the job to your GitHub repository.
	4.	Use the scripts provided in the jenkins directory for building and deploying the application.

Contributing

Contributions are welcome! Please follow these steps:

	1.	Fork the repository.
	2.	Create a new branch (git checkout -b feature-branch).
	3.	Make your changes and commit them (git commit -m "Your message").
	4.	Push to the branch (git push origin feature-branch).
	5.	Create a pull request.

License

This project is licensed under the MIT License. See the LICENSE file for details.

Contact

For any questions or inquiries, please contact:

	•	Tshepo Tau
	•	tauterrence09@gmail.com

### Next Steps
- **Update GitHub URL**: Replace `yourusername` with your actual GitHub username.
- **Fill in Contact Information**: Add your name and email in the contact section.

Feel free to copy this entire block into your `README.md` file!

