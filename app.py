from flask import Flask, render_template, request
import os
import subprocess

app = Flask(__name__, template_folder="templates")

@app.route('/')
def home():
    return render_template("index.html")

@app.route('/contact')
def contact():
    return render_template("contact.html")

@app.route('/form')
def form():
    return render_template("form.html")

@app.route('/submit',  methods=['POST'])
def submit():
    appcode = request.form.get("appcode")
    subprocess.Popen(['bash', 'script.sh', appcode])
    return render_template("submit.html", appcode=appcode)

if __name__ == "__main__":
    port = int(os.environ.get("PORT", 3000))
    app.run(debug=True, host='0.0.0.0', port=port)
