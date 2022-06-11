from flask import Flask, render_template, request
import pymongo
import os
import subprocess

app = Flask(__name__, template_folder="templates")

client = pymongo.MongoClient("mongodb+srv://bmoon4:XXXXX@cluster0.lwnik.mongodb.net/?retryWrites=true&w=majority")
db = client.airflow_onboarding

@app.route('/')
def home():
    return render_template("index.html")

@app.route('/contact')
def contact():
    return render_template("contact.html")

@app.route('/form')
def form():
    return render_template("form.html")

@app.route('/confirm')
def confirm():
    return render_template("confirm.html")

@app.route('/submit',  methods=['POST'])
def submit():
    appcode = request.form.get("appcode")
    email = request.form.get("email")
    subprocess.Popen(['bash', 'script.sh', appcode, email])
    new_record = {
        "appcode" : appcode,
        "email" :  email,
    }
    db.appcode.insert_one(new_record)
    return render_template("submit.html", appcode=appcode, email=email)

if __name__ == "__main__":
    port = int(os.environ.get("PORT", 3000))
    app.run(debug=True, host='0.0.0.0', port=port)
