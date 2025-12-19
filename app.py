#!/usr/bin/env python3
from flask import Flask, request, jsonify, render_template_string
import psycopg2
import os

app = Flask(__name__)
DATABASE_URL = os.environ.get('DATABASE_URL', 'dbname=mylottodata host=localhost')

def get_db():
    return psycopg2.connect(DATABASE_URL)

def execute_lottery_query(state, game, time_of_day, year, month, day):
    conn = get_db()
    cur = conn.cursor()
    
    state_variations = {
        'dc': 'Washington, D.C.', 'washington dc': 'Washington, D.C.',
        'washington d.c.': 'Washington, D.C.', 'd.c.': 'Washington, D.C.',
    }
    state_lower = state.lower().strip()
    if state_lower in state_variations:
        state = state_variations[state_lower]
    
    midday_patterns = ['Midday', 'Mid-Day', 'Day', '1:50', 'Afternoon', 'Morning']
    evening_patterns = ['Evening', 'Night', '7:50', 'PM']
    time_patterns = midday_patterns if time_of_day == 'Midday' else evening_patterns
    
    game_variations = {
        'Pick 3': ['Pick 3', 'Pick-3', 'DC-3', 'Cash 3', 'Daily 3', 'Play 3'],
        'Pick 4': ['Pick 4', 'Pick-4', 'DC-4', 'Cash 4', 'Daily 4', 'Play 4', 'Win 4'],
        'Pick 5': ['Pick 5', 'Pick-5', 'DC-5', 'Cash 5', 'Daily 5', 'Play 5', 'Georgia Five'],
    }
    game_names = game_variations.get(game, [game])
    
    if state_lower in state_variations:
        state_match, state_param = "s.name = %s", state
    else:
        state_match, state_param = "s.name ILIKE %s", f"%{state}%"
    
    game_id = game_name = None
    for game_var in game_names:
        if game_id: break
        for time_pat in time_patterns:
            cur.execute(f"SELECT g.id, g.name FROM games g JOIN states s ON g.state_id = s.id WHERE {state_match} AND g.name ILIKE %s AND g.active = true LIMIT 1", (state_param, f"%{game_var}%{time_pat}%"))
            result = cur.fetchone()
            if result:
                game_id, game_name = result
                break
    
    if not game_id:
        for game_var in game_names:
            cur.execute(f"SELECT g.id, g.name FROM games g JOIN states s ON g.state_id = s.id WHERE {state_match} AND g.name ILIKE %s AND g.active = true LIMIT 1", (state_param, f"%{game_var}%"))
            result = cur.fetchone()
            if result:
                game_id, game_name = result
                break
    
    if not game_id:
        conn.close()
        return None, f"Could not find {game} in {state}"
    
    cur.execute("SELECT draw_date, value FROM draws WHERE game_id = %s AND EXTRACT(YEAR FROM draw_date) = %s AND EXTRACT(MONTH FROM draw_date) = %s AND EXTRACT(DAY FROM draw_date) = %s ORDER BY draw_date DESC LIMIT 1", (game_id, year, month, day))
    result = cur.fetchone()
    conn.close()
    
    if result:
        return True, f"{game_name}, {result[0].strftime('%B %d, %Y')}: {result[1].replace('-', ', ')}"
    return None, f"No results for {game_name} on {month}/{day}/{year}"

@app.route('/')
def index():
    return render_template_string(HTML)

@app.route('/query', methods=['POST'])
def query():
    data = request.json
    try:
        success, response = execute_lottery_query(data['state'], data['game'], data['time'], int(data['year']), int(data['month']), int(data['day']))
        return jsonify({'success': success, 'response': response})
    except Exception as e:
        return jsonify({'success': False, 'response': f'Error: {str(e)}'})

@app.route('/health')
def health():
    return jsonify({'status': 'ok'})

HTML = '''<!DOCTYPE html><html><head><title>Lottery Lookup</title><meta name="viewport" content="width=device-width,initial-scale=1"><style>*{box-sizing:border-box}body{font-family:-apple-system,sans-serif;max-width:500px;margin:0 auto;padding:20px;background:linear-gradient(135deg,#1a1a2e,#16213e);min-height:100vh;color:#eee}h1{text-align:center;font-size:24px}#start-screen{text-align:center;padding:40px}#start-btn{width:150px;height:150px;border-radius:50%;border:none;background:linear-gradient(145deg,#4ecca3,#3eb489);color:#fff;font-size:20px;cursor:pointer;box-shadow:0 8px 30px rgba(78,204,163,.5)}#app{display:none}.prompt-box{background:rgba(78,204,163,.15);border:2px solid rgba(78,204,163,.5);border-radius:12px;padding:25px;text-align:center;font-size:28px;margin:20px 0}#mic-area{text-align:center;margin:20px 0}#mic{width:80px;height:80px;border-radius:50%;border:none;font-size:36px;cursor:pointer}#mic.listening{background:linear-gradient(145deg,#4ecca3,#3eb489);animation:pulse 1s infinite}#mic.idle{background:linear-gradient(145deg,#3498db,#2980b9)}@keyframes pulse{0%,100%{transform:scale(1)}50%{transform:scale(1.1)}}#timer{font-size:24px;color:#f39c12;margin:10px 0;min-height:30px}#heard{background:rgba(255,255,255,.1);border-radius:8px;padding:10px;margin:10px 0;min-height:40px;color:#aaa;font-style:italic}.params{display:grid;grid-template-columns:repeat(3,1fr);gap:8px;margin:20px 0}.param{background:rgba(255,255,255,.1);padding:10px;border-radius:8px;text-align:center}.param-label{font-size:11px;color:#888;text-transform:uppercase}.param-value{font-size:16px;font-weight:500}#result-box{background:rgba(78,204,163,.2);border:2px solid rgba(78,204,163,.5);border-radius:12px;padding:20px;text-align:center;font-size:22px;display:none;margin:20px 0}.controls{text-align:center;margin-top:20px}.controls button{padding:10px 20px;margin:5px;background:transparent;border:1px solid #666;color:#888;border-radius:8px;cursor:pointer}</style></head><body><h1>🎰 Lottery Lookup</h1><div id="start-screen"><button id="start-btn" onclick="startApp()">🎤 Start</button><p>Click to begin</p></div><div id="app"><div class="prompt-box" id="prompt">State?</div><div id="mic-area"><button id="mic" class="idle">🎤</button><div id="timer"></div><div id="heard"></div></div><div class="params"><div class="param"><div class="param-label">State</div><div class="param-value" id="p-state">-</div></div><div class="param"><div class="param-label">Year</div><div class="param-value" id="p-year">-</div></div><div class="param"><div class="param-label">Month</div><div class="param-value" id="p-month">-</div></div><div class="param"><div class="param-label">Day</div><div class="param-value" id="p-day">-</div></div><div class="param"><div class="param-label">Game</div><div class="param-value" id="p-game">-</div></div><div class="param"><div class="param-label">Time</div><div class="param-value" id="p-time">-</div></div></div><div id="result-box"></div><div class="controls"><button onclick="resetApp()">Start Over</button></div></div><script>const STEPS=["state","year","month","day","game","time"],PROMPTS={state:"State?",year:"Year?",month:"Month?",day:"Day?",game:"Game? (Pick 3, 4, or 5)",time:"Midday or Evening?"},MONTHS=["","january","february","march","april","may","june","july","august","september","october","november","december"];let currentStep=0,params={},recognition=null,timeoutId=null,countdownId=null;const SpeechRecognition=window.SpeechRecognition||window.webkitSpeechRecognition;SpeechRecognition&&(recognition=new SpeechRecognition,recognition.continuous=!1,recognition.interimResults=!1,recognition.lang="en-US",recognition.onresult=e=>{clearTimers();const t=e.results[0][0].transcript;document.getElementById("heard").textContent='"'+t+'"',processInput(t)},recognition.onend=()=>{},recognition.onerror=e=>{console.log("Speech error:",e.error)});function startApp(){document.getElementById("start-screen").style.display="none",document.getElementById("app").style.display="block",speechSynthesis.speak(new SpeechSynthesisUtterance("")),setTimeout(()=>{askCurrentStep()},300)}function askCurrentStep(){const e=STEPS[currentStep],t=PROMPTS[e];document.getElementById("prompt").textContent=t,speak(t,()=>{startListening()})}function speak(e,t){const n=new SpeechSynthesisUtterance(e);n.rate=1;const s=speechSynthesis.getVoices();s.length&&(n.voice=s.find(e=>"en-US"===e.lang)||s[0]);let o=!1;const i=setTimeout(()=>{o||!t||(o=!0,t())},Math.max(2e3,80*e.length));n.onend=()=>{clearTimeout(i),o||!t||(o=!0,t())},speechSynthesis.speak(n)}function startListening(){if(!recognition)return;clearTimers();const e=document.getElementById("mic");e.className="listening";let t=10;document.getElementById("timer").textContent=t;try{recognition.start()}catch(e){}countdownId=setInterval(()=>{t--,document.getElementById("timer").textContent=t>0?t:""},1e3),timeoutId=setTimeout(()=>{clearTimers(),recognition.stop(),e.className="idle",setTimeout(askCurrentStep,500)},1e4)}function clearTimers(){timeoutId&&clearTimeout(timeoutId),countdownId&&clearInterval(countdownId),document.getElementById("timer").textContent=""}function processInput(e){const t=STEPS[currentStep],n=parseInput(t,e);n?(params[t]=n,updateDisplay(),++currentStep>=STEPS.length?executeQuery():setTimeout(askCurrentStep,500)):speak("Sorry, I didn't get that.",()=>{setTimeout(askCurrentStep,300)})}function parseInput(e,t){if(t=t.toLowerCase().trim(),"state"===e){const e={florida:"Florida",georgia:"Georgia",texas:"Texas",ohio:"Ohio",michigan:"Michigan",illinois:"Illinois","new york":"New York","new jersey":"New Jersey",pennsylvania:"Pennsylvania",maryland:"Maryland",virginia:"Virginia","north carolina":"North Carolina","south carolina":"South Carolina",tennessee:"Tennessee",kentucky:"Kentucky",indiana:"Indiana",missouri:"Missouri",louisiana:"Louisiana",dc:"DC","washington dc":"DC","d.c.":"DC",california:"California",arizona:"Arizona",colorado:"Colorado",connecticut:"Connecticut",delaware:"Delaware",maine:"Maine",massachusetts:"Massachusetts"};for(let[n,s]of Object.entries(e))if(t.includes(n))return s;return t.length>1?t.charAt(0).toUpperCase()+t.slice(1):null}if("year"===e){const e=t.match(/\d{4}/);return e?e[0]:null}if("month"===e){for(let e=1;e<MONTHS.length;e++)if(t.includes(MONTHS[e])||t.includes(MONTHS[e].substring(0,3)))return e.toString();const e=t.match(/\d{1,2}/);return e&&parseInt(e[0])>=1&&parseInt(e[0])<=12?e[0]:null}if("day"===e){const e=t.match(/\d{1,2}/);return e&&parseInt(e[0])>=1&&parseInt(e[0])<=31?e[0]:null}return"game"===e?t.includes("3")||t.includes("three")?"Pick 3":t.includes("4")||t.includes("four")?"Pick 4":t.includes("5")||t.includes("five")?"Pick 5":null:"time"===e?t.includes("mid")||t.includes("day")||t.includes("afternoon")?"Midday":t.includes("even")||t.includes("night")?"Evening":null:null}function updateDisplay(){for(let e of STEPS)document.getElementById("p-"+e).textContent=params[e]||"-"}async function executeQuery(){document.getElementById("prompt").textContent="Searching...",document.getElementById("mic").className="idle";try{const e=await fetch("/query",{method:"POST",headers:{"Content-Type":"application/json"},body:JSON.stringify(params)}),t=await e.json();document.getElementById("result-box").style.display="block",document.getElementById("result-box").textContent=t.response,document.getElementById("prompt").textContent=t.success?"Found!":"Not Found",speak(t.response)}catch(e){document.getElementById("result-box").style.display="block",document.getElementById("result-box").textContent="Error: "+e.message}}function resetApp(){currentStep=0,params={},clearTimers(),recognition&&recognition.stop(),speechSynthesis.cancel(),document.getElementById("result-box").style.display="none",document.getElementById("heard").textContent="",updateDisplay(),askCurrentStep()}window.onload=()=>{speechSynthesis&&speechSynthesis.getVoices()};</script></body></html>'''

if __name__ == '__main__':
    port = int(os.environ.get('PORT', 5003))
    app.run(host='0.0.0.0', port=port, debug=True)
