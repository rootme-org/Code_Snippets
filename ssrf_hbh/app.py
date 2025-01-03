# app.py
from flask import Flask, request, abort, redirect, url_for
from requests import get
import logging

app = Flask(__name__)
logging.basicConfig(level=logging.DEBUG)

@app.route('/admin')
def admin_panel():
    app.logger.info(request.headers)
    client_ip = request.headers.get('X-Real-IP', None)
    if not client_ip:
        return "Welcome to the admin panel!"
    else:
        abort(403)

@app.route('/', defaults={'path': ''})
@app.route('/<path:path>')
def proxy(path):
    SITE_NAME = 'https://root-me.org'
    return get(f'{SITE_NAME}{path}').content

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)
