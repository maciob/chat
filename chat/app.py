from locale import format_string
from logging import root
from flask import Flask,render_template, request
from datetime import datetime
from flaskext.mysql import MySQL
from datetime import datetime

app = Flask(__name__)
mysql = MySQL()
app.config['MYSQL_DATABASE_USER'] = 'app'
app.config['MYSQL_DATABASE_PASSWORD'] = 'pass'
app.config['MYSQL_DATABASE_DB'] = 'mydb'
app.config['MYSQL_DATABASE_HOST'] = '172.17.0.3'
mysql.init_app(app)

@app.route("/<int:room_id>",methods=["GET","POST"])
def home(room_id): 
	return render_template("index.html")

@app.route("/api/chat/<int:room_id>",methods=["GET","POST"])
def send(room_id):
	conn = mysql.connect()
	cur = conn.cursor()
	row = ""
	if request.method == "GET":
		cur.execute(f"SELECT * FROM chat WHERE ID={room_id}")
		data = cur.fetchall()
		response = []
		if data:
			for i in data:
				response.append(f'({i[3]} {i[1]}): {i[2]}')
			return "\n".join(response)
		else:
			return "EMPTY HISTORY"
	if request.method == "POST":
		message = request.form.get("msg")
		username = request.form.get("username")
		date = datetime.now().strftime("%m/%d/%Y, %H:%M:%S")
		cur.execute(f"INSERT INTO chat (ID,username,message,date) VALUES ('{room_id}','{username}','{message}','{date}');")
		conn.commit()	
		return f'{message}'
if __name__ == "__main__":
	app.run()
