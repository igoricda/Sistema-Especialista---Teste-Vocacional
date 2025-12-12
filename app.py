# Autores:
# Guilherme Altmeyer Soares, Igor Correa Domingues de Almeida, Kauan Carlos Campos e Maria Eduarda Quevedo

from flask import Flask, render_template, request, jsonify
from pyswip import Prolog
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

prolog = Prolog()
prolog.consult("vocacional_api.pl")

#Rota inicial, carrega o html
@app.route('/')
def home():
    return render_template('index.html')

#Pega as questoes das macro-areas disponibilizadas pela API em PROLOG e retorna com um JSON
@app.route('/api/questions1', methods=['GET'])
def get_questions1():
    try:
        result = list(prolog.query("api_get_questions1(X)"))
        if not result:
            return jsonify([])

        raw_data = result[0]['X']
        questions = []
        
        for item in raw_data:
            q_id = item[0]
            q_text = str(item[1])
            q_alts = [str(a) for a in item[2]]
            
            questions.append({
                "id": q_id,
                "text": q_text,
                "options": q_alts
            })
            
        return jsonify(questions)
    except Exception as e:
        print(f"Erro no Prolog: {e}")
        return jsonify({"error": str(e)}), 500

# Envia as Respostas dessas perguntas para a API
@app.route('/api/submit1', methods=['POST'])
def submit1():
    data = request.json
    selected_texts = data.get('answers', [])
    
    # Tratamento de string para Prolog
    prolog_list_str = "[" + ", ".join([f"'{s}'" for s in selected_texts]) + "]"
    
    query = f"api_calc_stage1({prolog_list_str}, TopAreas)"
    result = list(prolog.query(query))
    
    top_areas = []
    if result:
        top_areas = [str(a) for a in result[0]['TopAreas']]
        
    return jsonify({"top_areas": top_areas})

# Recebe as perguntas das micro-areas, baseadas nas respostas anteriores
@app.route('/api/questions2', methods=['POST'])
def get_questions2():
    data = request.json
    areas = data.get('areas', [])
    
    areas_list_str = "[" + ", ".join([str(a) for a in areas]) + "]"
    
    query = f"api_get_questions2({areas_list_str}, Questions)"
    result = list(prolog.query(query))
    
    questions = []
    if result:
        raw_data = result[0]['Questions']
        for item in raw_data:
            q_area = str(item[0])
            q_id = item[1]
            q_text = str(item[2])
            q_alts = [str(a) for a in item[3]]
            
            questions.append({
                "area": q_area,
                "id": q_id,
                "text": q_text,
                "options": q_alts
            })
            
    return jsonify(questions)

# Envia as respostas das micro-areas e recebe o ranking final, enviado pela API
@app.route('/api/submit_final', methods=['POST'])
def submit_final():
    data = request.json
    selected_texts = data.get('answers', [])
    
    clean_texts = [s.replace("'", "") for s in selected_texts]
    prolog_list_str = "[" + ", ".join([f"'{s}'" for s in clean_texts]) + "]"
    
    query = f"api_calc_final({prolog_list_str}, Ranking)"
    result = list(prolog.query(query))
    
    ranking = []
    if result:
        raw_list = result[0]['Ranking']
        for item in raw_list:
            score = item[0]
            curso = str(item[1])
            ranking.append({"course": curso, "score": score})
            
    return jsonify(ranking)

if __name__ == '__main__':
    app.run(debug=False)
