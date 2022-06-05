from flask import Flask, redirect, url_for, render_template, request, session, flash
from flask_mysqldb import MySQL
from flask_wtf import Form
from wtforms import SubmitField
import yaml
from logging import FileHandler,WARNING
import markups
from flask_sqlalchemy import SQLAlchemy

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

#app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///<db_name>.db'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

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
    return render_template("database.html", form=form)
    if request.method == 'POST':
        if request.form.get('epistimoniko_pedio'):
            return render_template("epistimoniko_pedio.html")
        elif request.form.get('stelexos'):
            return render_template('stelexos.html')
        elif request.form.get('programma'):
            return render_template('programma.html')
        elif request.form.get('organismos'):
            return render_template('organismos.html')
        elif request.form.get('panepistimio'):
            return render_template('panepistimio.html')
        elif request.form.get('etairia'):
            return render_template('etairia.html')
        elif request.form.get('ereunitiko_kentro'):
            return render_template('ereunitiko_kentro.html')
        elif request.form.get('organismos_tilefwna'):
            return render_template('organismos_tilefwna.html')
        elif request.form.get('ereunitis'):
            return render_template('ereunitis.html') #####
        elif request.form.get('aksiologisi'):
            return render_template('aksiologisi.html')
        elif request.form.get('ergo'):
            return render_template('ergo.html')
        elif request.form.get('paradoteo'):
            return render_template('paradoteo.html')
        elif request.form.get('epistimoniko_pedio_ergou'):
            return render_template('epistimoniko_pedio_ergou.html')
        elif request.form.get('ergazetai_se'):
            return render_template("ergazetai_se_ergo.html")
        #else:
            #pass 
    else:
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
    else:
        return render_template('Q1.html')





#### Q2
@app.route("/Q2", methods=['GET', 'POST'])
def Q2():
    if request.method == 'POST':
        cur = mysql.connection.cursor()
        resultValue1 = cur.execute(" select * from ereunitis_vw; ")
        if resultValue1 > 0:
            Q2A1Answer = cur.fetchall()
        resultValue2 = cur.execute(" select * from stelexos_vw; ")
        if resultValue2 > 0 and resultValue1 > 0:
            Q2A2Answer = cur.fetchall()      
            return render_template('Q2.html', Q2A1Answer = Q2A1Answer, Q2A2Answer = Q2A2Answer )
        cur.close()
    else:
        return render_template('Q2.html')



#### Q3
@app.route("/Q3", methods=['GET', 'POST'])
def Q3():
    if request.method == 'POST':
        cur = mysql.connection.cursor()
        resultValue = cur.execute("select * from epist_pedio")
        if resultValue > 0:
            Q3Answer = cur.fetchall()  
            return render_template('Q3.html', Q3Answer = Q3Answer)
        cur.close()
    else:
        return render_template('Q3.html')





###
@app.route("/Q3/Full", methods=['GET', 'POST'])
def Q3Full():
    pedio = (request.form['pedio'])
    if request.method == 'POST':
        cur = mysql.connection.cursor()
        resultValue = cur.execute("select e.ergo_id, e.titlos from ergo e inner join epist_pediou_ergou ep on e.ergo_id= ep.ergo_id  where CURRENT_DATE() between e.enarksi and e.liksi and ep.onoma_epist_pediou =  %s;", (pedio,)) ####allagi
        if resultValue>0:
            Q3f1Answer = cur.fetchall()  
        cur.close()
        cur = mysql.connection.cursor()
        resultValue2 = cur.execute("select distinct vw.ssn, vw.onoma, vw.epitheto from ereunitis_vw vw inner join (select e.ergo_id, e.titlos from ergo e inner join epist_pediou_ergou ep on e.ergo_id= ep.ergo_id  where CURRENT_DATE() between e.enarksi and e.liksi and ep.onoma_epist_pediou = %s ) s on s.ergo_id = vw.ergo_id;", (pedio,))
        if resultValue2>0 and resultValue>0:
            Q3f2Answer = cur.fetchall()
            return render_template('Q3_full.html', Q3f1Answer = Q3f1Answer, Q3f2Answer = Q3f2Answer)
        cur.close()
    #else:
        #return render_template('Q3_full.html')




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
        resultValue = cur.execute("select a.onoma_epist_pediou, b.onoma_epist_pediou from epist_pediou_ergou a inner join epist_pediou_ergou b where a.ergo_id = b.ergo_id and a.onoma_epist_pediou < b.onoma_epist_pediou group by a.onoma_epist_pediou, b.onoma_epist_pediou order by count(*) desc limit 3; ")
        if resultValue > 0:
            Q5Answer = cur.fetchall()  
            return render_template('Q5.html', Q5Answer = Q5Answer)
        cur.close()
    else:
        return render_template('Q5.html')





#### Q6
@app.route("/Q6", methods=['GET', 'POST'])
def Q6():
    if request.method == 'POST':
        cur = mysql.connection.cursor()
        resultValue = cur.execute("select e.ssn, e.onoma, e.epitheto , count(*) from ereunitis e inner join ergazetai_se_ergo erga on e.ssn = erga.ssn where TIMESTAMPDIFF(YEAR, e.hmeromhnia_gennhshs, CURDATE())<40 group by e.ssn order by count(*) desc limit 3; ")
        if resultValue > 0:
            Q6Answer = cur.fetchall()  
            return render_template('Q6.html', Q6Answer = Q6Answer)
        cur.close()
    else:
        return render_template('Q6.html')





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
    else:
        return render_template('Q7.html')




#### Q8
@app.route("/Q8", methods=['GET', 'POST'])
def Q8():
    if request.method == 'POST':
        cur = mysql.connection.cursor()
        resultValue = cur.execute("select ssn, onoma, epitheto, count(*)  from ereunitis_vw where ergo_id not in (select ergo_id from paradoteo) group by ssn having count(*)>4 ;")
        if resultValue > 0:
            Q8Answer = cur.fetchall()  
            return render_template('Q8.html', Q8Answer = Q8Answer)
        cur.close()
    else:
        return render_template('Q8.html')



'''
@app.route("/epistimoniko_pedio", methods=['GET', 'POST'])
def epistimoniko_pedio():
    if request.method == 'POST':
        cur = mysql.connection.cursor()
        resultValue = cur.execute(" ")
        if resultValue > 0:
            Answer = cur.fetchall()  
            return render_template('epistimoniko_pedio.html', '0')
        cur.close()
        #return render_template('Q7.html')
    elif request.method == 'GET':
        return render_template('epistimoniko_pedio.html', '0')


'''
'''
@app.route('/database/<variable>/create')
def create(variable):
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
    
'''


@app.route('/database/<variable>/retrieve', methods = ['GET', 'POST'])
def retrieve(variable):
    if request.method == 'POST' or request.method == 'GET':
        cur = mysql.connection.cursor()
        resultValue = cur.execute(" select * from %s;", (variable,))
        if resultValue > 0:
            Answer = cur.fetchall()  
            return render_template('epistimoniko_pedio.html', Answer = Answer)
        cur.close()
        #return render_template('Q7.html')
    else: #request.method == 'GET':
        Answer = 0
        return render_template('epistimoniko_pedio.html', Answer = Answer)   


'''
@app.route('/database/<variable>/update')
def update(variable):
    



@app.route('/database/<variable>/delete')
def delete(variable):
    
'''




@app.route("/database/epistimoniko_pedio", methods=['GET', 'POST'])
def database_epistimoniko_pedio():
    Answer = 0
    return render_template('epistimoniko_pedio.html', Answer = Answer)



@app.route("/database/stelexos", methods=['GET', 'POST'])
def database_stelexos():
    return render_template('stelexos.html')




@app.route("/database/programma", methods=['GET', 'POST'])
def database_programma():
    return render_template('programma.html')




@app.route("/database/organismos", methods=['GET', 'POST'])
def database_organismos():
    return render_template('organismos.html')





@app.route("/database/panepistimio", methods=['GET', 'POST'])
def database_panepistimio():
    return render_template('panepistimio.html')




@app.route("/database/etairia", methods=['GET', 'POST'])
def database_etairia():
    return render_template('etairia.html')





@app.route("/database/ereunitiko_kentro", methods=['GET', 'POST'])
def database_ereunitiko_kentro():
    return render_template('ereunitiko_kentro.html')





@app.route("/database/organismos_tilefwna", methods=['GET', 'POST'])
def database_organismos_tilefwna():
    return render_template('organismos_tilefwna.html')





@app.route("/database/ereunitis", methods=['GET', 'POST'])
def database_ereunitis():
    return render_template('ereunitis.html')





@app.route("/database/aksiologisi", methods=['GET', 'POST'])
def database_aksiologisi():
    return render_template('aksiologisi.html')





@app.route("/database/ergo", methods=['GET', 'POST'])
def database_ergo():
    return render_template('ergo.html')




@app.route("/database/paradoteo", methods=['GET', 'POST'])
def database_paradoteo():
    return render_template('paradoteo.html')




@app.route("/database/epistimoniko_pedio_ergou", methods=['GET', 'POST'])
def database_epistimoniko_pedio_ergou():
    return render_template('epistimoniko_pedio_ergou.html')



@app.route("/database/ergazetai_se", methods=['GET', 'POST'])
def database_ergazetai_se():
    return render_template('ergazetai_se.html')



if __name__ == '__main__':
    app.run(debug=True)