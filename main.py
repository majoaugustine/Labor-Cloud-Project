import os
from posixpath import dirname
from random import random
import secrets
import string
from flask import Flask, flash, redirect, request, session, render_template, url_for, jsonify
from functools import wraps
from flaskext.mysql import MySQL
from datetime import date, datetime
from flask_cors import CORS
from flask_mail import Mail, Message
from werkzeug.utils import secure_filename

app = Flask(__name__)
app.secret_key = '^%&%@JGJHGSA)(HJK!HGJ'

mysql = MySQL()
app.config['MYSQL_DATABASE_USER'] = 'root'
app.config['MYSQL_DATABASE_PASSWORD'] = 'root'
app.config['MYSQL_DATABASE_DB'] = 'labc'
app.config['MYSQL_DATABASE_HOST'] = 'localhost'

mail = Mail(app)  # instantiate the mail class

# configuration of mail
app.config['MAIL_SERVER'] = 'smtp.gmail.com'
app.config['MAIL_PORT'] = 465
app.config['MAIL_USERNAME'] = 'webfarmstpius@gmail.com'
app.config['MAIL_PASSWORD'] = 'webfarm123'
app.config['MAIL_USE_TLS'] = False
app.config['MAIL_USE_SSL'] = True
mail = Mail(app)

# ubuntu path
app.config['UPLOAD_FOLDER'] = 'uploads/'

mysql.init_app(app)
CORS(app)
conn = mysql.connect()


def allow_for_loggined_users_only(f):
    @wraps(f)
    def wrapper(*args, **kwargs):
        if 'username' not in session:
            return redirect(url_for('login', next=request.endpoint))
        return f(*args, **kwargs)

    return wrapper


def randomString(stringLength):
    """Generate a random string with the combination of lowercase and uppercase letters """
    lettersAndDigits = string.ascii_letters + string.digits
    return ''.join(random.choice(lettersAndDigits) for i in range(stringLength))


# Password Generator


def password(size=8, characters=string.ascii_letters + string.digits):
    return ''.join(random.choice(characters) for _ in range(size))


def Mailer(sender, recipient, Subject, body):
    try:
        msg = Message(Subject, sender=sender, recipients=[recipient])
        msg.body = body
        mail.send(msg)

        return "sended successfully"
    except:
        return "A Error occurred while perform mailing !"


def create_connection():
    cursor = conn.cursor()
    return cursor


def close_connection(cursor):
    cursor.close()
    return True


@app.route('/')
def index():
    cursor = create_connection()
    cursor.execute("select * from feedback")
    row = cursor.fetchall()        
    close_connection(cursor)
    return render_template('index.html',feedback=row)


@app.route('/login', methods=['POST', 'GET'])
def login():
    if request.method == 'POST':
        cursor = create_connection()
        cursor.execute("select id,type from login where username=%s and password=%s",
                       (request.form['username'], request.form['password']))
        row = cursor.fetchone()

        if row is None:
            flash('Incorrect username or password supplied')
            return render_template('login.html')
        else:

            session['username'] = request.form['username']
            session['id'] = row[0]
            session['type'] = row[1]
            

            if row[1] == 'admin':
                return redirect(url_for("admin_home"))
            if row[1] == 'user':
                cursor.execute("select * from registration where lid=%s",row[0])
                row = cursor.fetchone()
                session['reg_id'] = row[0]
                session['user_name'] = row[2]
                session['location_reference'] = row[10]
                return redirect(url_for("user_home"))
            if row[1] == 'labour':
                cursor.execute("select * from labours where login_reference=%s",row[0])
                row = cursor.fetchone()
                session['reg_id'] = row[0]
                session['location_reference'] = row[6]
                return redirect(url_for("labour_home"))

    if request.method == 'GET':
        return render_template('login.html')


@app.route('/admin_home')
@allow_for_loggined_users_only
def admin_home():
    return render_template('admin_home.html')

@app.route('/forg')
def forg_pass():
    return render_template('forg_pass.html')


@app.route('/user_home')
def user_home():
    print(session)
    return render_template('user_home.html',user= session['user_name'])


@app.route('/labour_home')
def labour_home():
    print(session)
    return render_template('labour_home.html')

@app.route('/logout', methods=['GET'])
@allow_for_loggined_users_only
def logout():
    if request.method == 'GET':
        session.clear()
        return redirect(url_for('login'))


@app.route('/locations', methods=['GET', 'POST'])
@allow_for_loggined_users_only
def locations():
    if request.method == 'GET':
        return render_template('new_location.html')
    if request.method == 'POST':
        try:
            cursor = create_connection()
            cursor.execute("insert into locations(location_name)values(%s)",
                           (request.form['location_name']))
            conn.commit()
            close_connection(cursor)
            flash('New location created successfully !!!')
            return redirect(url_for('locations'))
        except Exception as e:
            flash('Something went wrong !!!')
            print(str(e))
            return redirect(url_for('locations'))
    return render_template('locations.html')


@app.route('/manage_locations', methods=['GET', 'POST'])
@allow_for_loggined_users_only
def manage_locations():
    if request.method == 'GET':
        cursor = create_connection()
        cursor.execute("select * from locations")
        row = cursor.fetchall()
        close_connection(cursor)
        return render_template('manage_locations.html', locations=row)
    if request.method == 'POST':
        print("reached", request.form)
        conn = mysql.connect()
        cursor = conn.cursor()
        query = "update locations set location_name=%s where id=%s"

        cursor.execute(query, (request.form.get('location_name'), request.form.get('location_reference')))
        conn.commit()
        cursor.execute("select * from locations")
        row = cursor.fetchall()
        close_connection(cursor)
        return render_template('manage_locations.html', locations=row)


@app.route("/delete_locations", methods=["POST", "GET"])
@allow_for_loggined_users_only
def delete_locations():
    if request.method == 'GET':
        cursor = create_connection()
        cursor.execute("select * from locations")
        row = cursor.fetchall()
        close_connection(cursor)
        return render_template('manage_locations.html', locations=row)
    if request.method == 'POST':
        conn = mysql.connect()
        cursor = conn.cursor()
        query = "delete from locations where id=%s"

        cursor.execute(query, request.form.get('delete_by_id'))
        conn.commit()
        cursor.execute("select * from locations")
        row = cursor.fetchall()
        close_connection(cursor)
        return render_template('manage_locations.html', locations=row)


@app.route('/new_labour', methods=['GET', 'POST'])
def new_labour():
    if request.method == 'GET':
        cursor = create_connection()
        cursor.execute("select * from locations")
        locations = cursor.fetchall()
        cursor.execute("select * from work_type")
        work_type = cursor.fetchall()
        return render_template('new_labour_registration.html',data=locations,work_type=work_type)
    if request.method == 'POST':
        try:
            print(request.form['labour_name'])
            cursor = create_connection()
            cursor.execute("insert into login(username,password,type,created_on)values(%s,%s,%s,%s)",(request.form['labour_name'],request.form['phone'],'labour',datetime.now()))
            cursor.execute("insert into labours(labour_name,address,phone,wage,age,location_reference,work_reference,login_reference)values(%s,%s,%s,%s,%s,%s,%s,%s)",
                           (request.form['labour_name'],request.form['address'],request.form['phone'],
                           request.form['wage'],request.form['age'],request.form['location_reference'],request.form['work_reference'],cursor.lastrowid))
            conn.commit()
            close_connection(cursor)
            flash('labour added successfully !!!')
            return redirect(url_for('new_labour'))
        except Exception as e:
            flash('Something went wrong !!!')
            print(str(e))
            return redirect(url_for('new_labour'))
    return render_template('new_labour_registration.html')


@app.route("/delete_labours", methods=["POST", "GET"])
@allow_for_loggined_users_only
def delete_labours():
    if request.method == 'GET':
        cursor = create_connection()
        cursor.execute("select * from labours l,locations ln,work_type w where l.location_reference=ln.id and l.work_reference=w.id")
        row = cursor.fetchall()
        close_connection(cursor)
        return render_template('manage_labours.html', locations=row)
    if request.method == 'POST':
        conn = mysql.connect()
        cursor = conn.cursor()
        query = "delete from labours where id=%s"

        cursor.execute(query, request.form.get('delete_by_id'))
        conn.commit()
        cursor.execute("select * from labours")
        row = cursor.fetchall()
        close_connection(cursor)
        return render_template('manage_labours.html', labours=row)


@app.route('/manage_labours', methods=['GET', 'POST'])
@allow_for_loggined_users_only
def manage_labours():
    if request.method == 'GET':
        cursor = create_connection()
        cursor.execute("select * from labours l,locations ln,work_type w where l.location_reference=ln.id and l.work_reference=w.id")
        row = cursor.fetchall()
        close_connection(cursor)
        return render_template('manage_labours.html', labours=row)
    if request.method == 'POST':
        print("reached", request.form)
        conn = mysql.connect()
        cursor = conn.cursor()
        query = "update labours set labour_name=%s,address=%s,phone=%s,wage=%s,age=%s where id=%s"

        cursor.execute(query, (request.form.get('labour_name'),request.form.get('address'),
        request.form.get('phone'),request.form.get('wage'),request.form.get('age'), request.form.get('labour_reference')))
        conn.commit()
        cursor.execute("select * from labours l,locations ln where l.location_reference=ln.id")
        row = cursor.fetchall()
        close_connection(cursor)
        return render_template('manage_labours.html', labours=row)

@app.route('/new-work-registration', methods=['GET', 'POST'])
@allow_for_loggined_users_only
def new_work_registration():
    if request.method == 'GET':
        cursor = create_connection()
        cursor.execute("select * from locations")
        locations = cursor.fetchall()
        return render_template('new_work_type.html',data=locations)
    if request.method == 'POST':
        try:
            print(request.form)
            cursor = create_connection()

            cursor.execute("INSERT INTO `work_type`(`location_reference`,`work_name`)values(%s,%s)",(request.form['location_reference'],request.form['work_name']))

            conn.commit()
            close_connection(cursor)
            flash('request created successfully !!!')
            return redirect(url_for('new_work_registration'))
        except Exception as e:
            flash('Something went wrong !!!')
            print(str(e))
            return redirect(url_for('new_work_registration'))
    return render_template('new_work_type.html')



@app.route("/delete_work_name", methods=["POST", "GET"])
@allow_for_loggined_users_only
def delete_work_name():
    if request.method == 'GET':
        cursor = create_connection()
        cursor.execute("select * from work_type w,locations ln where w.location_reference=ln.id")
        row = cursor.fetchall()
        close_connection(cursor)
        return render_template('manage_work_type.html', locations=row)
    if request.method == 'POST':
        conn = mysql.connect()
        cursor = conn.cursor()
        query = "delete from work_type where id=%s"

        cursor.execute(query, request.form.get('delete_by_id'))
        conn.commit()
        cursor.execute("select * from work_type w,locations ln where w.location_reference=ln.id")
        row = cursor.fetchall()
        close_connection(cursor)
        return render_template('manage_work_type.html', labours=row)


@app.route('/manage_work_type', methods=['GET', 'POST'])
@allow_for_loggined_users_only
def manage_work_type():
    if request.method == 'GET':
        cursor = create_connection()
        cursor.execute("select * from work_type w,locations ln where w.location_reference=ln.id")
        row = cursor.fetchall()
        close_connection(cursor)
        return render_template('manage_work_type.html', labours=row)
    if request.method == 'POST':
        print("reached", request.form)
        conn = mysql.connect()
        cursor = conn.cursor()
        query = "update work_type set work_name=%s where id=%s"

        cursor.execute(query, (request.form.get('work_name'),request.form.get('id')))
        conn.commit()
        cursor.execute("select * from work_type w,locations ln where w.location_reference=ln.id")
        row = cursor.fetchall()
        close_connection(cursor)
        return render_template('manage_work_type.html', labours=row)






@app.route('/manage-work-request', methods=['GET', 'POST'])
@allow_for_loggined_users_only
def manage_work_request():
    if request.method == 'GET':
        cursor = create_connection()
        cursor.execute("select * from work_request w,registration r,labours l,work_type t,locations lns where w.user_reference=r.id and w.worker_reference=l.id and l.work_reference=t.id and  r.location_reference=lns.id and l.id=%s order by w.date_of_request desc",session['reg_id'])
        locations = cursor.fetchall()
        print(locations)
        return render_template('manage_work_request.html',data=locations)

        
    if request.method == 'POST':
        try:
            cursor = create_connection()
            cursor.execute("INSERT INTO `work_request`(`user_reference`,`worker_reference`,`date_of_request`,`work_date`)values(%s,%s,%s,%s))",
                           (request.form['user_reference'],request.form['worker_reference'],request.form['date_of_request'],
                           request.form['work_date']))
            conn.commit()
            close_connection(cursor)
            flash('request created successfully !!!')
            return redirect(url_for('new_labour'))
        except Exception as e:
            flash('Something went wrong !!!')
            print(str(e))
            return redirect(url_for('new_labour'))
    return render_template('manage_work_request.html')




@app.route("/approve_request", methods=["POST", "GET"])
@allow_for_loggined_users_only
def approve_request():
    if request.method == 'GET':
        cursor = create_connection()
        cursor.execute("select * from work_request w,registration r,labours l,work_type t,locations lns where w.user_reference=r.id and w.worker_reference=l.id and l.work_reference=t.id and  r.location_reference=lns.id and l.id=%s order by w.date_of_request desc",session['reg_id'])
        row = cursor.fetchall()
        close_connection(cursor)
        return render_template('manage_work_request.html', data=row)
    if request.method == 'POST':
        conn = mysql.connect()
        cursor = conn.cursor()
        query = "update work_request set status=%s where id=%s"

        cursor.execute(query, ('approved',request.form.get('approve_by_id')))
        conn.commit()
        # cursor.execute("select * from work_request w,registration r,labours l,work_type t where w.user_reference=r.id and w.worker_reference=l.id and l.work_reference=t.id and w.status='pending'")
        # row = cursor.fetchall()

        cursor.execute("select * from work_request w,registration r,labours l,work_type t,locations lns where w.user_reference=r.id and w.worker_reference=l.id and l.work_reference=t.id and  r.location_reference=lns.id and l.id=%s order by w.date_of_request desc",session['reg_id'])
        row = cursor.fetchall()

        close_connection(cursor)
        return render_template('manage_work_request.html', data=row)

@app.route("/reject_request", methods=["POST", "GET"])
@allow_for_loggined_users_only
def reject_request():
    if request.method == 'GET':
        cursor = create_connection()
        cursor.execute("select * from work_request w,registration r,labours l,work_type t,locations lns where w.user_reference=r.id and w.worker_reference=l.id and l.work_reference=t.id and  r.location_reference=lns.id and l.id=%s order by w.date_of_request desc",session['reg_id'])
        row = cursor.fetchall()
        close_connection(cursor)
        return render_template('manage_work_request.html', data=row)
    if request.method == 'POST':
        conn = mysql.connect()
        cursor = conn.cursor()
        query = "update work_request set status=%s where id=%s"
        cursor.execute(query, ('rejected',request.form.get('reject_by_id')))
        conn.commit()
        cursor.execute("select * from work_request w,registration r,labours l,work_type t,locations lns where w.user_reference=r.id and w.worker_reference=l.id and l.work_reference=t.id and  r.location_reference=lns.id and l.id=%s order by w.date_of_request desc",session['reg_id'])
        row = cursor.fetchall()
        close_connection(cursor)
        return render_template('manage_work_request.html', data=row)


@app.route('/manage-old-work-request', methods=['GET', 'POST'])
@allow_for_loggined_users_only
def manage_old_work_request():
    if request.method == 'GET':
        cursor = create_connection()
        cursor.execute("select * from work_request w,registration r,labours l,work_type t,locations lns where w.user_reference=r.id and w.worker_reference=l.id and l.work_reference=t.id and w.status!='pending' and r.location_reference=lns.id")
        locations = cursor.fetchall()
        return render_template('old_work_request.html',data=locations)


@app.route('/manage-old-work-request-by-reference', methods=['GET', 'POST'])
@allow_for_loggined_users_only
def manage_old_work_request_by_reference():
    if request.method == 'GET':
        cursor = create_connection()
        print(session["reg_id"])
        cursor.execute("select * from work_request w,registration r,labours l,work_type t,locations lns where w.user_reference=r.id and w.worker_reference=l.id and l.work_reference=t.id and r.location_reference=lns.id and w.user_reference=%s",session["reg_id"])
        locations = cursor.fetchall()
        print(locations)
        return render_template('user_old_request_view.html',data=locations)


@app.route('/manage-old-work-request-for-labour', methods=['GET', 'POST'])
@allow_for_loggined_users_only
def manage_old_work_request_for_labour():
    if request.method == 'GET':
        cursor = create_connection()
        print("session",session)
        
        cursor.execute("select * from work_request w,registration r,labours l,work_type t,locations lns where w.user_reference=r.id and w.worker_reference=l.id and l.work_reference=t.id and r.location_reference=lns.id and w.worker_reference=%s",session['reg_id'])
        locations = cursor.fetchall()
        print(locations)
        return render_template('labour_my_request.html',data=locations)



@app.route('/user_registration', methods=['GET', 'POST'])
# @allow_for_loggined_users_only
def user_registration():
    if request.method == 'GET':
        cursor = create_connection()
        cursor.execute("select * from locations")
        locations = cursor.fetchall()
        return render_template('new_user_registration.html',data=locations)
    if request.method == 'POST':
        try:
            print(request.form)
            cursor = create_connection()
            cursor.execute("INSERT INTO  login (username,password,type,created_on)VALUES(%s,%s,%s,%s)",(request.form['username'],request.form['password'],'user',datetime.now()))
            cursor.execute("INSERT INTO `registration`(`lid`,`name`,`gender`,`dob`,`phone`,`email`,`address`,`adhaar_no`,`created_on`,`location_reference`)VALUES(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)",
                           (cursor.lastrowid,request.form['name'],request.form['gender'],
                           request.form['dob'],request.form['phone'],request.form['email'],
                           request.form['address'],request.form['adhaar'],datetime.now(),
                           request.form['location_reference']))
            conn.commit()
            close_connection(cursor)
            flash('New user created successfully !!!')
            return redirect(url_for('user_registration'))
        except Exception as e:
            flash('Something went wrong !!!')
            print(str(e))
            return redirect(url_for('user_registration'))
    return render_template('new_user_registration.html')



@app.route('/get_workers_by_type', methods=['GET', 'POST'])
@allow_for_loggined_users_only
def get_workers_by_type():
    if request.method == 'POST':
        cursor = create_connection()
        session['work_reference']=request.form.get('work_reference')
        cursor.execute("select * from labours where work_reference=%s",request.form.get('work_reference'))
        row = cursor.fetchall()
        cursor.execute("select * from work_type where id=%s",request.form.get('work_reference'))
        row2 = cursor.fetchone()
        return render_template('new_work_request.html', work_type=session['work_type'],workers=row,work_name=row2[1])


@app.route('/new_work_request', methods=['GET', 'POST'])
@allow_for_loggined_users_only
def new_work_request():
    if request.method == 'GET':
        cursor = create_connection()
        print(session['location_reference'])
        cursor.execute("select * from work_type where location_reference=%s",session['location_reference'])
        row = cursor.fetchall()
        close_connection(cursor)
        session['work_type'] = row
        return render_template('new_work_request.html', work_type=row)
    if request.method == 'POST':
        try:
            print("reached", request.form)
            cursor = create_connection()
            query = "INSERT INTO `work_request`(`user_reference`,`worker_reference`,`date_of_request`,`work_date`,`work_description`)VALUES(%s,%s,%s,%s,%s)"
            cursor.execute(query, (session['reg_id'],request.form.get('worker_reference'),datetime.now(),request.form.get('work_date'),request.form.get('work_detail')))
            conn.commit()
            flash('New request created successfully !!!')
            return redirect(url_for("new_work_request"))
        except Exception as e:
            flash('Something went wrong !!!')
            print(str(e))
            return redirect(url_for('new_work_request'))




@app.route('/user_feedback', methods=['GET', 'POST'])
@allow_for_loggined_users_only
def user_feedback():
    if request.method == 'GET':
        return render_template('user_feedback.html')
    if request.method == 'POST':
        try:
            print("reached", request.form)
            cursor = create_connection()
            cursor.execute("INSERT INTO `feedback`(`feedback`,`user_reference`,`created_on`)VALUES(%s,%s,%s)",(request.form['feedback'],session['reg_id'],datetime.now()))
            conn.commit()
            flash('Feedback created successfully !!!')
            return redirect(url_for("user_feedback"))
        except Exception as e:
            flash('Something went wrong !!!')
            print(str(e))
            return redirect(url_for('user_feedback'))












if __name__ == '__main__':
    app.run(debug=True, host="localhost", port=8000)
