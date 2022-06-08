from flask import Flask, render_template
import os

app = Flask(__name__, template_folder="templates")

@app.route('/', methods=['POST', 'GET'])
def home():
    return render_template("index.html")

@app.route('/contact', methods=['GET'])
def contact():
    return render_template("contact.html")

@app.route('/form', methods=['POST', 'GET'])
def form():
    return render_template("form.html")

if __name__ == "__main__":
    port = int(os.environ.get("PORT", 3000))
    app.run(debug=True, host='0.0.0.0', port=port)
