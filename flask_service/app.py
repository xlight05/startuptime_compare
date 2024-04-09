from flask import Flask
import logging
import datetime

logging.Formatter.formatTime = (lambda self, record, datefmt=None: datetime.datetime.fromtimestamp(record.created, datetime.timezone.utc).astimezone().isoformat(sep="T",timespec="milliseconds"))

logging.basicConfig(format="%(asctime)s %(message)s", level=logging.INFO)

app = Flask(__name__)
@app.route("/hello")
def helloworld():
    return "Hello World!"

if __name__ == "__main__":
    app.run(host="localhost", port=8080)
