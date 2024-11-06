from flask import Flask, request, jsonify
import sqlite3

app = Flask(__name__)

def verify_token(api_key):
    conn = sqlite3.connect('uuids.db')
    c = conn.cursor()
    c.execute("SELECT * FROM uuids WHERE uuid LIKE ?", (api_key,))
    result = c.fetchone()
    conn.close()
    return result is not None

@app.route('/api/admin', methods=['GET'])
def check_api_key():
    api_key = request.headers.get('X-Api-Key')
    if api_key:
        if verify_token(api_key):
            return jsonify({'status': 'true'}), 200
    return jsonify({'status': 'false'}), 401

if __name__ == '__main__':
    app.run(host="0.0.0.0")
