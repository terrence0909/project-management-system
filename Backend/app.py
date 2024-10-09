from flask import Flask
from config import Config

app = Flask(__name__)
app.config.from_object(Config)

@app.route('/')
def home():
    return "Welcome to the Construction Project Management System!"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
