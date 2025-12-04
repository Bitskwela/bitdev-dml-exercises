# Activity 1: Frontend Flask Deployment

In this activity, you'll learn how to deploy your Flask application with a frontend to production platforms like Render, Vercel, and PythonAnywhere.

---

## Activity 1: Preparing Your Flask App for Deployment

**Checklist before deployment:**

✅ **requirements.txt** - All dependencies listed  
✅ **Environment variables** - Config moved to .env  
✅ **Debug mode OFF** - Set `DEBUG=False`  
✅ **Static files** - Properly configured  
✅ **Database** - Use production database (PostgreSQL)  
✅ **CORS** - Properly configured for frontend domain  
✅ **Security** - SECRET_KEY in environment variables  

**Create `requirements.txt`:**

```bash
pip freeze > requirements.txt
```

**Or manually create:**

```txt
Flask==2.3.0
Flask-CORS==4.0.0
python-dotenv==1.0.0
gunicorn==21.2.0
psycopg2-binary==2.9.9
PyJWT==2.8.0
bcrypt==4.1.2
```

---

## Activity 2: Deploying to Render (Free Tier)

**Step 1: Create `render.yaml`:**

```yaml
services:
  - type: web
    name: barangay-portal
    env: python
    buildCommand: pip install -r requirements.txt
    startCommand: gunicorn app:app
    envVars:
      - key: PYTHON_VERSION
        value: 3.11.0
      - key: SECRET_KEY
        generateValue: true
      - key: DATABASE_URL
        fromDatabase:
          name: barangay-db
          property: connectionString
      - key: FLASK_ENV
        value: production

databases:
  - name: barangay-db
    databaseName: barangay
    user: barangay_user
```

**Step 2: Update `app.py` for production:**

```python
import os
from flask import Flask, send_from_directory
from flask_cors import CORS

app = Flask(__name__, static_folder='static', static_url_path='')

# Production configuration
app.config['SECRET_KEY'] = os.environ.get('SECRET_KEY', 'dev-key-change-this')
app.config['DEBUG'] = False

# CORS for production domain
allowed_origins = [
    'https://your-frontend.vercel.app',
    'https://your-custom-domain.com'
]

if os.environ.get('FLASK_ENV') == 'development':
    allowed_origins.append('http://localhost:3000')

CORS(app, origins=allowed_origins, supports_credentials=True)

# Serve static files
@app.route('/')
def serve_frontend():
    return send_from_directory(app.static_folder, 'index.html')

@app.route('/<path:path>')
def serve_static(path):
    return send_from_directory(app.static_folder, path)

# API routes
@app.route('/api/health')
def health_check():
    return {'status': 'healthy', 'environment': os.environ.get('FLASK_ENV', 'production')}

if __name__ == '__main__':
    port = int(os.environ.get('PORT', 5000))
    app.run(host='0.0.0.0', port=port)
```

**Step 3: Deploy to Render:**

1. Push code to GitHub
2. Go to render.com → New → Web Service
3. Connect GitHub repository
4. Select branch (main/master)
5. Render auto-detects Python
6. Set environment variables
7. Click "Create Web Service"

**Render will:**
- Install dependencies from `requirements.txt`
- Run `gunicorn app:app`
- Provide HTTPS URL: `https://your-app.onrender.com`

---

## Activity 3: Frontend Configuration for Different Environments

**Create `static/js/config.js`:**

```javascript
// Environment detection
const ENV = {
    DEVELOPMENT: 'development',
    STAGING: 'staging',
    PRODUCTION: 'production'
};

// Detect current environment
function detectEnvironment() {
    const hostname = window.location.hostname;
    
    if (hostname === 'localhost' || hostname === '127.0.0.1') {
        return ENV.DEVELOPMENT;
    } else if (hostname.includes('staging')) {
        return ENV.STAGING;
    } else {
        return ENV.PRODUCTION;
    }
}

// API Configuration
const API_CONFIG = {
    [ENV.DEVELOPMENT]: {
        API_URL: 'http://localhost:5000',
        TIMEOUT: 5000,
        DEBUG: true
    },
    [ENV.STAGING]: {
        API_URL: 'https://staging-api.onrender.com',
        TIMEOUT: 10000,
        DEBUG: true
    },
    [ENV.PRODUCTION]: {
        API_URL: 'https://barangay-portal.onrender.com',
        TIMEOUT: 15000,
        DEBUG: false
    }
};

// Get current config
const currentEnv = detectEnvironment();
const config = API_CONFIG[currentEnv];

// Export config
window.APP_CONFIG = {
    ...config,
    ENV: currentEnv
};

console.log(`🚀 Running in ${currentEnv} mode`);
console.log(`📡 API URL: ${config.API_URL}`);
```

**Use in your app:**

```javascript
// api.js
async function fetchFromAPI(endpoint, options = {}) {
    const { API_URL, TIMEOUT, DEBUG } = window.APP_CONFIG;
    
    const controller = new AbortController();
    const timeoutId = setTimeout(() => controller.abort(), TIMEOUT);
    
    try {
        const response = await fetch(`${API_URL}${endpoint}`, {
            ...options,
            signal: controller.signal,
            headers: {
                'Content-Type': 'application/json',
                ...options.headers
            }
        });
        
        clearTimeout(timeoutId);
        
        if (!response.ok) {
            throw new Error(`HTTP ${response.status}: ${response.statusText}`);
        }
        
        const data = await response.json();
        
        if (DEBUG) {
            console.log(`API Response [${endpoint}]:`, data);
        }
        
        return data;
        
    } catch (error) {
        clearTimeout(timeoutId);
        
        if (error.name === 'AbortError') {
            throw new Error('Request timeout');
        }
        
        throw error;
    }
}

// Usage:
// const residents = await fetchFromAPI('/api/residents');
```

---

## Activity 4: Deploying to Vercel (Frontend Only)

**For frontend-only deployment (separate frontend/backend):**

**Step 1: Create `vercel.json`:**

```json
{
  "version": 2,
  "builds": [
    {
      "src": "*.html",
      "use": "@vercel/static"
    },
    {
      "src": "*.css",
      "use": "@vercel/static"
    },
    {
      "src": "*.js",
      "use": "@vercel/static"
    }
  ],
  "routes": [
    {
      "src": "/api/(.*)",
      "dest": "https://your-backend.onrender.com/api/$1"
    },
    {
      "src": "/(.*)",
      "dest": "/$1"
    }
  ]
}
```

**Step 2: Project Structure:**

```
frontend/
├── index.html
├── css/
│   └── styles.css
├── js/
│   ├── config.js
│   ├── api.js
│   └── app.js
├── images/
└── vercel.json
```

**Step 3: Deploy:**

```bash
# Install Vercel CLI
npm install -g vercel

# Deploy
vercel

# Follow prompts:
# - Set project name
# - Choose framework (None)
# - Set root directory (.)
```

**Or deploy via GitHub:**

1. Push to GitHub
2. Import to Vercel
3. Deploy automatically on push

---

## Activity 5: Deploying to PythonAnywhere

**Step 1: Upload files to PythonAnywhere:**

```bash
# On PythonAnywhere console
cd ~
git clone https://github.com/yourusername/barangay-portal.git
cd barangay-portal
```

**Step 2: Create virtual environment:**

```bash
mkvirtualenv --python=/usr/bin/python3.10 barangay-env
pip install -r requirements.txt
```

**Step 3: Configure WSGI file:**

Create `/var/www/yourusername_pythonanywhere_com_wsgi.py`:

```python
import sys
import os

# Add your project directory
project_home = '/home/yourusername/barangay-portal'
if project_home not in sys.path:
    sys.path.insert(0, project_home)

# Load environment variables
from dotenv import load_dotenv
load_dotenv(os.path.join(project_home, '.env'))

# Import Flask app
from app import app as application
```

**Step 4: Configure Web App:**

1. Go to Web tab
2. Add new web app
3. Choose Flask + Python version
4. Set source code path: `/home/yourusername/barangay-portal`
5. Set virtualenv: `/home/yourusername/.virtualenvs/barangay-env`
6. Set WSGI file path (created above)
7. Reload app

**Step 5: Serve static files:**

In Web tab, add static files mapping:

```
URL: /static/
Directory: /home/yourusername/barangay-portal/static/
```

---

## Activity 6: Environment Variables on Different Platforms

**Render:**
```
Go to Dashboard → Environment → Add Environment Variable
```

**Vercel:**
```bash
vercel env add SECRET_KEY
# Or in dashboard: Settings → Environment Variables
```

**PythonAnywhere:**
```python
# In WSGI file
os.environ['SECRET_KEY'] = 'your-secret-key'
# Or use .env file with python-dotenv
```

**Example `.env` file (NEVER commit this!):**

```env
FLASK_ENV=production
SECRET_KEY=your-super-secret-key-here
DATABASE_URL=postgresql://user:password@host:5432/dbname
CORS_ORIGINS=https://your-frontend.vercel.app,https://yourdomain.com
```

---

## Activity 7: Production Static File Serving

**Option 1: Flask serves everything**

```python
from flask import Flask, send_from_directory

app = Flask(__name__, static_folder='static')

@app.route('/')
def index():
    return send_from_directory('static', 'index.html')

@app.route('/<path:path>')
def serve_static(path):
    return send_from_directory('static', path)
```

**Option 2: Separate frontend/backend (Recommended)**

Frontend (Vercel): `https://barangay-app.vercel.app`  
Backend (Render): `https://barangay-api.onrender.com`

```javascript
// Frontend config.js
const config = {
    API_URL: 'https://barangay-api.onrender.com'
};
```

```python
# Backend app.py
from flask_cors import CORS

CORS(app, origins=['https://barangay-app.vercel.app'])
```

---

## Activity 8: Database Migration to Production

**Local SQLite → Production PostgreSQL**

**Step 1: Export data from SQLite:**

```python
import sqlite3
import json

conn = sqlite3.connect('barangay.db')
cursor = conn.cursor()

# Export residents
cursor.execute('SELECT * FROM residents')
residents = cursor.fetchall()

with open('residents_export.json', 'w') as f:
    json.dump(residents, f)

conn.close()
```

**Step 2: Create PostgreSQL database on Render:**

Render automatically provides PostgreSQL database URL.

**Step 3: Update Flask to use PostgreSQL:**

```python
import os
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)

# Use PostgreSQL in production, SQLite in development
if os.environ.get('FLASK_ENV') == 'production':
    app.config['SQLALCHEMY_DATABASE_URI'] = os.environ.get('DATABASE_URL')
else:
    app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///barangay.db'

db = SQLAlchemy(app)
```

**Step 4: Import data to PostgreSQL:**

```python
import psycopg2
import json
import os

# Connect to PostgreSQL
conn = psycopg2.connect(os.environ.get('DATABASE_URL'))
cursor = conn.cursor()

# Create table
cursor.execute('''
    CREATE TABLE IF NOT EXISTS residents (
        id SERIAL PRIMARY KEY,
        name VARCHAR(255),
        age INTEGER,
        address TEXT
    )
''')

# Import data
with open('residents_export.json', 'r') as f:
    residents = json.load(f)
    for resident in residents:
        cursor.execute('INSERT INTO residents (name, age, address) VALUES (%s, %s, %s)', resident)

conn.commit()
conn.close()
```

---

## Activity 9: Monitoring and Logging

**Setup logging:**

```python
import logging
from logging.handlers import RotatingFileHandler
import os

# Configure logging
if not app.debug:
    if not os.path.exists('logs'):
        os.mkdir('logs')
    
    file_handler = RotatingFileHandler('logs/barangay.log', maxBytes=10240, backupCount=10)
    file_handler.setFormatter(logging.Formatter(
        '%(asctime)s %(levelname)s: %(message)s [in %(pathname)s:%(lineno)d]'
    ))
    file_handler.setLevel(logging.INFO)
    app.logger.addHandler(file_handler)
    
    app.logger.setLevel(logging.INFO)
    app.logger.info('Barangay Portal startup')

# Log requests
@app.before_request
def log_request():
    app.logger.info(f'{request.method} {request.path}')

# Log errors
@app.errorhandler(500)
def internal_error(error):
    app.logger.error(f'Server Error: {error}')
    return {'error': 'Internal server error'}, 500
```

**Health check endpoint:**

```python
@app.route('/api/health')
def health_check():
    return {
        'status': 'healthy',
        'environment': os.environ.get('FLASK_ENV'),
        'timestamp': datetime.now().isoformat()
    }
```

---

## Activity 10: Complete Deployment Workflow

```bash
# 1. Test locally
python app.py

# 2. Check requirements
pip freeze > requirements.txt

# 3. Test production config
export FLASK_ENV=production
python app.py

# 4. Commit and push
git add .
git commit -m "Ready for deployment"
git push origin main

# 5. Deploy backend to Render
# (Automatic deployment on git push)

# 6. Update frontend config with production API URL
# Edit static/js/config.js

# 7. Deploy frontend to Vercel
vercel --prod

# 8. Test production
curl https://your-api.onrender.com/api/health
```

---

## 📚 Deployment Platforms Comparison

| Platform | Best For | Free Tier | Database | Custom Domain |
|----------|----------|-----------|----------|---------------|
| **Render** | Full-stack Flask | ✅ Yes | PostgreSQL | ✅ Yes |
| **Vercel** | Static frontend | ✅ Yes | No | ✅ Yes |
| **PythonAnywhere** | Simple Flask apps | ✅ Limited | MySQL | 💰 Paid only |
| **Heroku** | Any app | 💰 No longer free | PostgreSQL | ✅ Yes |
| **Railway** | Full-stack | ✅ Limited | PostgreSQL | ✅ Yes |

---

## 🚀 Production Best Practices

1. ✅ **Use environment variables** for all secrets
2. ✅ **Set DEBUG=False** in production
3. ✅ **Use HTTPS** (enabled by default on most platforms)
4. ✅ **Configure CORS** properly
5. ✅ **Use production database** (PostgreSQL, not SQLite)
6. ✅ **Enable logging** for debugging
7. ✅ **Add health check** endpoint
8. ✅ **Use CDN** for static files (if needed)
9. ✅ **Monitor errors** (Sentry, Rollbar)
10. ✅ **Setup CI/CD** for automatic deployments

---

## 🔒 Security Checklist

- [ ] SECRET_KEY in environment variables
- [ ] Database credentials in environment variables
- [ ] CORS configured for specific domains
- [ ] HTTPS enabled
- [ ] Input validation on all endpoints
- [ ] Rate limiting enabled
- [ ] SQL injection prevention (use parameterized queries)
- [ ] XSS prevention (escape user input)
- [ ] CSRF protection enabled

Congratulations! Your app is now live!