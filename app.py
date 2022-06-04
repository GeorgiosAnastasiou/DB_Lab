from flask import Flask, redirect, url_for, render_template, request, session, flash
from flask_mysqldb import MySQL
from flask_wtf import Form
from wtforms import SubmitField
import yaml
from logging import FileHandler,WARNING
import markups

app = Flask(__name__)


class ButtonForm(Form):
    database = SubmitField()
    Q1 = SubmitField()
    Q2 = SubmitField()
    Q3 = SubmitField()
    Q4 = SubmitField()
    Q5 = SubmitField()
    Q6 = SubmitField()
    Q7 = SubmitField()
    Q8 = SubmitField()

class ButtonForm2(Form):
    epistimoniko_pedio = SubmitField()
    stelexos = SubmitField() 
    programma = SubmitField()
    organismos = SubmitField()
    panepistimio = SubmitField()
    etairia = SubmitField()
    ereunitiko_kentro = SubmitField()
    organismos_tilefwna = SubmitField() 
    ereunitis = SubmitField()
    aksiologisi = SubmitField() 
    ergo = SubmitField()
    paradoteo = SubmitField() 
    epistimoniko_pedio_ergou = SubmitField() 
    ergazetai_se_ergo = SubmitField() 

# Configure db
db = yaml.safe_load(open('db.yaml'))
app.config['MYSQL_HOST'] = db['mysql_host']
app.config['MYSQL_USER'] = db['mysql_user']
app.config['MYSQL_PASSWORD'] = db['mysql_password']
app.config['MYSQL_DB'] = db['mysql_db']

mysql = MySQL()
mysql.init_app(app)

@app.route('/', methods=['GET', 'POST'])
def index():
    form = ButtonForm()
    if request.method == 'POST':
        if request.form.get('database'): #== 'Go to database':
            #return redirect(url_for("/database"))
            return render_template("database.html")
            #return render_template('database.html', form=form)
        elif request.form.get("Q1"):
            return render_template("Q1.html")
        elif request.form.get('Q2'):
            return render_template("Q2.html")
        elif request.form.get('Q3'):
            return render_template("Q3.html")
        elif request.form.get('Q4'):
            return render_template("Q4.html")
        elif request.form.get('Q5'):
            return render_template("Q5.html")
        elif request.form.get('Q5'):
            return render_template("Q6.html")
        elif request.form.get('Q7'):
            return render_template("Q7.html")
        elif request.form.get('Q8'):
            return render_template("Q8.html")
    elif request.method == 'GET':
        return render_template('index.html', form=form)




@app.route("/database", methods=['GET', 'POST'])
def database():
    form = ButtonForm2()
    if request.method == 'POST':
        if request.form['submit_button'] == 'Epistimoniko Pedio':
            return render_template("epistimoniko_pedio.html")
        elif request.form['submit_button'] == 'Stelexos':
            return render_template('stelexos.html')
        elif request.form['submit_button'] == 'Programma':
            return render_template('programma.html')
        elif request.form['submit_button'] == 'Organismos':
            return render_template('organismos.html')
        elif request.form['submit_button'] == 'Panepistimio':
            return render_template('panepistimio.html')
        elif request.form['submit_button'] == 'Etairia':
            return render_template('etairia.html')
        elif request.form['submit_button'] == 'Ereunitiko Kentro':
            return render_template('ereunitiko_kentro.html')
        elif request.form['submit_button'] == 'Organismos Tilefwna':
            return render_template('organismos_tilefwna.html')
        elif request.form['submit_button'] == 'Ereunitis':
            return render_template('ereunitis.html') #####
        elif request.form['submit_button'] == 'Aksiologisi':
            return render_template('aksiologisi.html')
        elif request.form['submit_button'] == 'Ergo':
            return render_template('ergo.html')
        elif request.form['submit_button'] == 'Paradoteo':
            return render_template('paradoteo.html')
        elif request.form['submit_button'] == 'Epistimoniko Pedio Ergou':
            return render_template('epistimoniko_pedio_ergou.html')
        elif request.form['submit_button'] == 'Ergazetai se Ergo':
            return render_template("ergazetai_se_ergo.html")
        #else:
            #pass 
    elif request.method == 'GET':
        return render_template("database.html", form=form)
    #return render_template('database.html') 


#### Q1
@app.route("/Q1", methods=['GET', 'POST'])
def Q1():
    if request.method == 'POST':
        cur = mysql.connection.cursor()
        resultValue = cur.execute(" ")
        if resultValue > 0:
            Q1Answer = cur.fetchall()  
            return render_template('Q1.html', Q1Answer = Q1Answer)
        cur.close()
    #else:
    #    return render_template('Q1.html')





#### Q2
@app.route("/Q2", methods=['GET', 'POST'])
def Q2():
    if request.method == 'POST':
        cur = mysql.connection.cursor()
        resultValue = cur.execute(" ")
        if resultValue > 0:
            Q2Answer = cur.fetchall()  
            return render_template('Q2.html', Q2Answer = Q2Answer)
        cur.close()
    #else:
    #    return render_template('Q2.html')



#### Q3
@app.route("/Q3", methods=['GET', 'POST'])
def Q3():
    if request.method == 'POST':
        cur = mysql.connection.cursor()
        resultValue = cur.execute(" ")
        if resultValue > 0:
            Q3Answer = cur.fetchall()  
            return render_template('Q3.html', Q3Answer = Q3Answer)
        cur.close()
    #else:
    #    return render_template('Q3.html')




#### Q4
@app.route("/Q4", methods=['GET', 'POST'])
def Q4():
    if request.method == 'POST':
        cur = mysql.connection.cursor()
        resultValue = cur.execute(" ")
        if resultValue > 0:
            Q4Answer = cur.fetchall()  
            return render_template('Q4.html', Q4Answer = Q4Answer)
        cur.close()
    #else:
    #    return render_template('Q4.html')




#### Q5
@app.route("/Q5", methods=['GET', 'POST'])
def Q5():
    if request.method == 'POST':
        cur = mysql.connection.cursor()
        resultValue = cur.execute(" ")
        if resultValue > 0:
            Q5Answer = cur.fetchall()  
            return render_template('Q5.html', Q5Answer = Q5Answer)
        cur.close()
    #else:
    #    return render_template('Q5.html')





#### Q6
@app.route("/Q6", methods=['GET', 'POST'])
def Q6():
    if request.method == 'POST':
        cur = mysql.connection.cursor()
        resultValue = cur.execute(" ")
        if resultValue > 0:
            Q6Answer = cur.fetchall()  
            return render_template('Q6.html', Q6Answer = Q6Answer)
        cur.close()
    #else:
    #    return render_template('Q6.html')





#### Q7
@app.route("/Q7", methods=['GET', 'POST'])
def Q7():
    if request.method == 'POST':
        cur = mysql.connection.cursor()
        #cur = db.connection.cursor()
        resultValue = cur.execute("select st.onoma_stelexous, er.poso, o.onoma from etairia e inner join organismos o on e.syntomografia = o.syntomografia inner join ergo er on o.syntomografia = er.syntomografia inner join stelexos st on st.stelexos_id = er.stelexos_id order by er.poso desc limit 5")
        if resultValue > 0:
            Q7Answer = cur.fetchall()  
            return render_template('Q7.html', Q7Answer = Q7Answer)
        cur.close()
    #else:
    #    return render_template('Q7.html')




#### Q8
@app.route("/Q8", methods=['GET', 'POST'])
def Q8():
    if request.method == 'POST':
        cur = mysql.connection.cursor()
        resultValue = cur.execute(" ")
        if resultValue > 0:
            Q8Answer = cur.fetchall()  
            return render_template('Q8.html', Q8Answer = Q8Answer)
        cur.close()
    #else:
    #    return render_template('Q8.html')



    
@app.route("/epistimoniko_pedio", methods=['GET', 'POST'])
def epistimoniko_pedio():
    if request.method == 'POST':
        cur = mysql.connection.cursor()
        resultValue = cur.execute(" ")
        if resultValue > 0:
            Answer = cur.fetchall()  
            return render_template('epistimoniko_pedio.html')
        cur.close()
        #return render_template('Q7.html')
    elif request.method == 'GET':
        return render_template('epistimoniko_pedio.html')



@app.route("/database/epistimoniko_pedio", methods=['GET', 'POST'])
def database_epistimoniko_pedio():
    return render_template('<section>.html')



@app.route("/database/stelexos", methods=['GET', 'POST'])
def database_epistimoniko_pedio():
    assert section == request.view_args['section']
    #if section == 'organismos_tilefwna':
    return render_template('<section>.html')




@app.route("/database/programma", methods=['GET', 'POST'])
def database_epistimoniko_pedio():
    assert section == request.view_args['section']
    #if section == 'organismos_tilefwna':
    return render_template('<section>.html')




@app.route("/database/organismos", methods=['GET', 'POST'])
def database_organismos():
    assert section == request.view_args['section']
    #if section == 'organismos_tilefwna':
    return render_template('organismos.html')





@app.route("/database/panepistimio", methods=['GET', 'POST'])
def database_panepistimio():





@app.route("/database/etairia", methods=['GET', 'POST'])
def database_epistimoniko_pedio():
    assert section == request.view_args['section']
    #if section == 'organismos_tilefwna':
    return render_template('etairia.html')





@app.route("/database/ereunitiko_kentro", methods=['GET', 'POST'])
def database_ereunitiko_kentro():
    assert section == request.view_args['section']
    #if section == 'organismos_tilefwna':
    return render_template('ereunitiko_kentro.html')





@app.route("/database/organismos_tilefwna", methods=['GET', 'POST'])
def database(section):
    assert section == request.view_args['section']
    #if section == 'organismos_tilefwna':
    return render_template('<section>.html')





@app.route("/database/ereunitis", methods=['GET', 'POST'])
def database(section):
    assert section == request.view_args['section']
    #if section == 'organismos_tilefwna':
    return render_template('<section>.html')





@app.route("/database/aksiologisi", methods=['GET', 'POST'])
def database(section):
    assert section == request.view_args['section']
    #if section == 'organismos_tilefwna':
    return render_template('<section>.html')





@app.route("/database/ergo", methods=['GET', 'POST'])
def database(section):
    assert section == request.view_args['section']
    #if section == 'organismos_tilefwna':
    return render_template('<section>.html')




@app.route("/database/paradoteo", methods=['GET', 'POST'])
def database(section):
    assert section == request.view_args['section']
    #if section == 'organismos_tilefwna':
    return render_template('<section>.html')




@app.route("/database/epistimoniko_pedio_ergou", methods=['GET', 'POST'])
def database(section):
    assert section == request.view_args['section']
    #if section == 'organismos_tilefwna':
    return render_template('<section>.html')



@app.route("/database/ergazetai_se", methods=['GET', 'POST'])
def database(section):
    assert section == request.view_args['section']
    #if section == 'organismos_tilefwna':
    return render_template('<section>.html')



if __name__ == '__main__':
    app.run(debug=True)