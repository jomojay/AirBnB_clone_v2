#!/usr/bin/python3
"""  a script that starts a Flask web application """

from flask import Flask
app = Flask(__name__)


@app.route('/', strict_slashes=False)
def index():
    """ index page"""
    return "Hello HBNB!"


@app.route('/hbnb', strict_slashes=False)
def hbnb():
    """HBNB page"""
    return "HBNB"


@app.route('/c/<text>', strict_slashes=False)
def c_route(text):
    """Dynamic inputed text: replace _ for space and show text"""
    return "C %s" % text.replace("_", " ")


@app.route('/python', strict_slashes=False)
@app.route('/python/<text>', strict_slashes=False)
def python_route(text="is_cool"):
    """Dynamic inputed text: replace _ for space and show text"""
    return "Python %s" % text.replace("_", " ")


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
