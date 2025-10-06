from flask import Flask, render_template, request, flash, redirect, url_for, session
import random
import smtplib
from email.mime.text import MIMEText
from datetime import datetime, timedelta
import mysql.connector
import hashlib

app = Flask(__name__)
app.secret_key = "secret123"

# MySQL connection
db = mysql.connector.connect(
    host="localhost",
    user="root",
    password="",
    database="otp_system1"
)
cursor = db.cursor()

# Send OTP Email
def send_otp(email, otp):
    sender_email = "dhrumildhameliy@gmail.com"      # your gmail
    sender_password = "wovlqomajuipycyp"   # your gmail app password
    msg = MIMEText(f"Your OTP is: {otp}\nIt will expire in 5 minutes.")
    msg['Subject'] = "Login OTP Verification"
    msg['From'] = sender_email
    msg['To'] = email

    try:
        server = smtplib.SMTP("smtp.gmail.com", 587)
        server.starttls()
        server.login(sender_email, sender_password)
        server.send_message(msg)
        server.quit()
        return True
    except Exception as e:
        print("Error sending email:", e)
        return False


# Hashing passwords for security
def hash_password(password):
    return hashlib.sha256(password.encode()).hexdigest()


# Register page (optional, for testing)
@app.route('/register', methods=['GET', 'POST'])
def register():
    if request.method == 'POST':
        email = request.form['email']
        password = hash_password(request.form['password'])

        try:
            cursor.execute("INSERT INTO users (email, password) VALUES (%s, %s)", (email, password))
            db.commit()
            flash("Registration successful! Please login.", "success")
            return redirect(url_for('login'))
        except:
            flash("Email already exists!", "danger")

    return render_template('register.html')


# Step 1: Login with email+password
@app.route('/', methods=['GET', 'POST'])
@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        email = request.form['email']
        password = hash_password(request.form['password'])

        cursor.execute("SELECT id, password FROM users WHERE email=%s", (email,))
        user = cursor.fetchone()

        if user and user[1] == password:
            otp = str(random.randint(100000, 999999))
            expires_at = datetime.now() + timedelta(minutes=5)

            cursor.execute("INSERT INTO otp_logs (user_id, otp_code, expires_at) VALUES (%s, %s, %s)",
                           (user[0], otp, expires_at))
            db.commit()

            if send_otp(email, otp):
                flash("OTP sent to your email!", "success")
                return render_template('verify.html', email=email)
            else:
                flash("Failed to send OTP. Check email settings.", "danger")
        else:
            flash("Invalid email or password!", "danger")

    return render_template('login.html')


# Step 2: Verify OTP
@app.route('/verify', methods=['POST'])
def verify():
    email = request.form['email']
    otp_input = request.form['otp']

    cursor.execute("""
        SELECT otp_logs.id, otp_logs.otp_code, otp_logs.expires_at, otp_logs.is_used, users.id 
        FROM otp_logs
        JOIN users ON otp_logs.user_id = users.id
        WHERE users.email = %s
        ORDER BY otp_logs.created_at DESC
        LIMIT 1
    """, (email,))
    
    result = cursor.fetchone()

    if result:
        otp_id, otp_code, expires_at, is_used, user_id = result
        if is_used:
            flash("OTP already used!", "danger")
        elif datetime.now() > expires_at:
            flash("OTP expired!", "danger")
        elif otp_input == otp_code:
            cursor.execute("UPDATE otp_logs SET is_used = TRUE WHERE id = %s", (otp_id,))
            db.commit()
            session['user_id'] = user_id
            session['email'] = email
            return redirect(url_for('dashboard'))
        else:
            flash("Invalid OTP!", "danger")
    else:
        flash("No OTP found for this email!", "danger")

    return render_template('verify.html', email=email)


# Dashboard (protected route)
@app.route('/dashboard')
def dashboard():
    if 'user_id' not in session:
        return redirect(url_for('login'))
    return render_template('dashboard.html', email=session['email'])


@app.route('/logout')
def logout():
    session.clear()
    flash("Logged out successfully!", "info")
    return redirect(url_for('login'))



@app.route('/')
def index():
    # If user logged in, show dashboard; otherwise go to login page.
    if 'user_id' in session:
        return redirect(url_for('dashboard'))
    return redirect(url_for('login'))

if __name__ == '__main__':
    app.run(debug=True)
