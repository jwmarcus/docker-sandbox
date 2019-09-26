from flask import Flask, escape, request
from time import gmtime, strftime

app = Flask(__name__)

@app.route('/')
def hello():
    return "The time is: {}".format(strftime("%a, %d %b %Y %H:%M:%S +0000", gmtime()))

