# Lesson 46: Frontend JS + Flask Deployment (Render/Vercel)

## Background Story

The moment had arrived. The barangay portal was complete—authentication, CRUD operations, localStorage preferences, secure environment variables. Everything worked perfectly on Tian's laptop.

But Captain Cruz asked the inevitable question: "How do residents actually use this? Do they need to install something?"

"No," Tian explained nervously. "I need to deploy it to a server. Then anyone with internet can access it through a URL."

Kuya Miguel smiled through the video call. "Welcome to deployment day. This is where your localhost project becomes a real web application. Let's make it live."

## Understanding Deployment

### Development vs Production

**Development (Your Computer):**
- http://localhost:5000
- DEBUG = True
- SQLite database
- Test data
- Only you can access

**Production (Server):**
- https://barangay-portal.com
- DEBUG = False
- PostgreSQL database (usually)
- Real data
- Anyone can access

### Deployment Platforms

**Free Options for Students:**

1. **Render** ⭐ (Recommended)
   - Free tier available
   - Easy setup
   - PostgreSQL included
   - Good for Flask apps

2. **Railway**
   - $5 free credit/month
   - Simple deployment
   - Great DX

3. **PythonAnywhere**
   - Free tier forever
   - Python-focused
   - Good for beginners

4. **Heroku**
   - Used to be free (now paid)
   - Still popular
   - Good documentation

5. **Vercel** (Frontend only)
   - Excellent for static sites
   - Limited Python support
   - Great for React/Next.js

## Deploying to Render (Full Stack)

### Step 1: Prepare Your Code

**Project structure:**
```
barangay-portal/
├── app.py
├── models.py
├── routes.py
├── config.py
├── requirements.txt
├── Procfile
├── runtime.txt (optional)
├── .env
├── .env.example
├── .gitignore
├── static/
│   ├── css/
│   ├── js/
│   └── images/
└── templates/
    └── index.html
```

### Step 2: Create requirements.txt

```bash
pip freeze > requirements.txt
```

**requirements.txt:**
```
Flask==3.0.0
Flask-SQLAlchemy==3.1.1
Flask-CORS==4.0.0
gunicorn==21.2.0
psycopg2-binary==2.9.9
python-dotenv==1.0.0
Werkzeug==3.0.1
```

### Step 3: Create Procfile

```bash
# Procfile (no extension!)
web: gunicorn app:app
```

**Explanation:**
- `web`: Process type (required for web services)
- `gunicorn`: Production WSGI server
- `app:app`: `module:application` (app.py file, app variable)

### Step 4: Update app.py for Production

```python
# app.py
from flask import Flask
from flask_cors import CORS
from dotenv import load_dotenv
import os

load_dotenv()

app = Flask(__name__)

# CORS for frontend
CORS(app, supports_credentials=True, origins=[
    'http://localhost:3000',
    'https://your-frontend.vercel.app'
])

# Configuration
app.config['SECRET_KEY'] = os.getenv('SECRET_KEY')
app.config['SQLALCHEMY_DATABASE_URI'] = os.getenv('DATABASE_URL')
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

# Handle Render's PostgreSQL URL format
database_url = app.config['SQLALCHEMY_DATABASE_URI']
if database_url and database_url.startswith('postgres://'):
    database_url = database_url.replace('postgres://', 'postgresql://', 1)
    app.config['SQLALCHEMY_DATABASE_URI'] = database_url

# Initialize database
from models import db
db.init_app(app)

# Create tables
with app.app_context():
    db.create_all()

# Import routes
from routes import *

if __name__ == '__main__':
    # Use environment variable for port (Render assigns dynamically)
    port = int(os.getenv('PORT', 5000))
    app.run(host='0.0.0.0', port=port)
```

### Step 5: Deploy to Render

**Via Dashboard:**

1. **Sign up** at https://render.com
2. **New → Web Service**
3. **Connect GitHub repository**
4. Configure:
   - **Name:** barangay-portal
   - **Environment:** Python
   - **Build Command:** `pip install -r requirements.txt`
   - **Start Command:** `gunicorn app:app`
   - **Plan:** Free

5. **Add Environment Variables:**
   ```
   SECRET_KEY=<your-secret-key>
   DATABASE_URL=<auto-filled by Render>
   FLASK_ENV=production
   ```

6. **Create PostgreSQL Database:**
   - New → PostgreSQL
   - Link to your web service
   - DATABASE_URL will be auto-configured

7. **Deploy!**
   - Click "Create Web Service"
   - Wait 5-10 minutes for first deploy
   - Your app will be live at `https://barangay-portal.onrender.com`

**Via CLI:**

```bash
# Install Render CLI
npm install -g render-cli

# Login
render login

# Deploy
render deploy
```

### Step 6: Verify Deployment

```bash
# Check if site is live
curl https://barangay-portal.onrender.com

# Check logs
# Go to Render Dashboard → Logs
```

## Deploying Frontend to Vercel

If you have separate frontend (HTML/CSS/JS only):

### Step 1: Prepare Frontend

```
frontend/
├── index.html
├── login.html
├── dashboard.html
├── css/
│   └── styles.css
├── js/
│   ├── auth.js
│   ├── api.js
│   └── main.js
└── vercel.json
```

### Step 2: Create vercel.json

```json
{
  "version": 2,
  "builds": [
    {
      "src": "*.html",
      "use": "@vercel/static"
    }
  ],
  "routes": [
    {
      "src": "/(.*)",
      "dest": "/$1"
    }
  ]
}
```

### Step 3: Update API URLs

```javascript
// js/api.js

// Development
// const API_URL = 'http://localhost:5000';

// Production
const API_URL = 'https://barangay-portal.onrender.com';

async function fetchAPI(endpoint, options = {}) {
    const response = await fetch(`${API_URL}${endpoint}`, {
        ...options,
        credentials: 'include',  // Important: send cookies
        headers: {
            'Content-Type': 'application/json',
            ...options.headers
        }
    });
    return response;
}
```

### Step 4: Deploy to Vercel

```bash
# Install Vercel CLI
npm install -g vercel

# Login
vercel login

# Deploy
cd frontend
vercel

# Production deployment
vercel --prod
```

Your frontend will be live at: `https://barangay-portal.vercel.app`

### Step 5: Update CORS in Backend

```python
# app.py
CORS(app, supports_credentials=True, origins=[
    'http://localhost:3000',
    'https://barangay-portal.vercel.app'  # Add your Vercel domain
])
```

## Custom Domain Setup

### Step 1: Buy Domain

**Philippine Domain Registrars:**
- Dot.PH - .ph domains
- Namecheap - .com, .net
- GoDaddy
- Google Domains

**Cost:** ₱500-2,000/year

### Step 2: Configure DNS

**In Render Dashboard:**
1. Settings → Custom Domains
2. Add domain: `barangay-portal.ph`
3. Copy DNS records

**In Domain Registrar:**
1. DNS Settings
2. Add A record:
   ```
   Type: A
   Name: @
   Value: <Render IP>
   ```
3. Add CNAME:
   ```
   Type: CNAME
   Name: www
   Value: barangay-portal.onrender.com
   ```

### Step 3: Enable HTTPS

Render automatically provides free SSL certificates via Let's Encrypt.

Wait 10-30 minutes for DNS propagation.

## Environment-Specific Configuration

```python
# config.py
import os

class Config:
    SECRET_KEY = os.getenv('SECRET_KEY')
    SQLALCHEMY_TRACK_MODIFICATIONS = False

class DevelopmentConfig(Config):
    DEBUG = True
    SQLALCHEMY_DATABASE_URI = 'sqlite:///dev.db'

class ProductionConfig(Config):
    DEBUG = False
    SQLALCHEMY_DATABASE_URI = os.getenv('DATABASE_URL')
    
    # Production security
    SESSION_COOKIE_SECURE = True
    SESSION_COOKIE_HTTPONLY = True
    SESSION_COOKIE_SAMESITE = 'Lax'

config = {
    'development': DevelopmentConfig,
    'production': ProductionConfig
}
```

## Database Migration

```python
# migrate.py
from app import app, db

with app.app_context():
    db.create_all()
    print("Database tables created!")
```

**Run on Render:**
```bash
# In Render Shell (Dashboard → Shell)
python migrate.py
```

## Monitoring and Maintenance

### Check Logs

**Render Dashboard:**
- Logs tab → Real-time logs
- Filter by date/severity

**Python logging:**
```python
import logging

logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s'
)

app.logger.info('User logged in')
app.logger.error('Database connection failed')
```

### Health Check Endpoint

```python
@app.route('/health')
def health():
    """Health check for monitoring"""
    try:
        # Check database connection
        db.session.execute('SELECT 1')
        return jsonify({'status': 'healthy'}), 200
    except Exception as e:
        return jsonify({'status': 'unhealthy', 'error': str(e)}), 500
```

### Database Backups

**Render:**
- Automatic daily backups (paid plan)
- Manual backup: `pg_dump` from shell

```bash
# Export database
pg_dump $DATABASE_URL > backup.sql

# Import database
psql $DATABASE_URL < backup.sql
```

## Troubleshooting Deployment

### Issue 1: App Crashes on Start

**Check logs:**
```
Error: No module named 'flask'
```

**Solution:** Missing dependencies
```bash
pip freeze > requirements.txt
git add requirements.txt
git commit -m "Update requirements"
git push
```

### Issue 2: Database Connection Failed

**Check logs:**
```
Connection refused
```

**Solution:** DATABASE_URL not set
```bash
# In Render: Environment → Add Variable
DATABASE_URL=<your-db-url>
```

### Issue 3: Static Files Not Loading

**Solution:** Correct paths
```html
<!-- Use absolute paths -->
<link rel="stylesheet" href="/static/css/styles.css">
<script src="/static/js/main.js"></script>
```

### Issue 4: CORS Errors

```
Access to fetch at 'https://api...' from origin 'https://frontend...' has been blocked by CORS policy
```

**Solution:**
```python
from flask_cors import CORS

CORS(app, supports_credentials=True, origins=[
    'https://your-frontend-domain.vercel.app'
])
```

## Performance Optimization

### 1. Minify Assets

```html
<!-- Use minified versions -->
<link rel="stylesheet" href="/static/css/styles.min.css">
<script src="/static/js/bundle.min.js"></script>
```

### 2. Enable Caching

```python
from flask import make_response

@app.route('/static/<path:path>')
def serve_static(path):
    response = make_response(send_from_directory('static', path))
    response.headers['Cache-Control'] = 'public, max-age=31536000'
    return response
```

### 3. Use CDN for Libraries

```html
<!-- Use CDN instead of local files -->
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
```

### 4. Database Connection Pooling

```python
app.config['SQLALCHEMY_ENGINE_OPTIONS'] = {
    'pool_size': 10,
    'pool_recycle': 3600,
    'pool_pre_ping': True
}
```

## Cost Estimation (Philippine Context)

**Free Tier (Students):**
- Render: Free (with limitations)
- Vercel: Free for personal projects
- Total: ₱0/month

**Basic Production:**
- Render Starter: $7/month (~₱390)
- Domain (.ph): ₱500/year
- Total: ~₱430/month

**Medium Scale:**
- Render Pro: $25/month (~₱1,400)
- Database: $7/month (~₱390)
- Domain: ₱500/year
- Total: ~₱1,830/month

## Security Checklist

Before going live:

- [ ] HTTPS enabled
- [ ] Environment variables set
- [ ] DEBUG = False
- [ ] Strong SECRET_KEY
- [ ] Database credentials secure
- [ ] CORS configured properly
- [ ] Input validation enabled
- [ ] SQL injection protection (ORM)
- [ ] XSS protection
- [ ] Rate limiting
- [ ] Error handling (no stack traces to users)
- [ ] Backups configured

## Summary

**Deployment Steps:**
1. Prepare code (requirements.txt, Procfile)
2. Choose platform (Render recommended)
3. Create account and link GitHub
4. Configure environment variables
5. Deploy and monitor

**Production Best Practices:**
- Use PostgreSQL (not SQLite)
- Enable HTTPS
- Set DEBUG=False
- Configure CORS properly
- Monitor logs
- Set up backups
- Use environment variables

**Platforms:**
- **Render:** Best for full-stack Flask apps
- **Vercel:** Best for frontend (HTML/JS)
- **Railway:** Good alternative
- **PythonAnywhere:** Best for beginners

Your app is now live! Anyone with the URL can access it.

---

## Closing Story

Tian clicked the "Deploy" button on Render. The logs scrolled rapidly—installing dependencies, starting server, running migrations. Five minutes felt like an eternity.

Then: **"Live at https://barangay-portal.onrender.com"**

Tian's hands trembled while typing the URL into the browser. It loaded. The barangay portal. Live. On the internet. Accessible to anyone.

Captain Cruz was the first tester. He opened the link on his phone. Registered an account. Submitted a test complaint. Everything worked.

"Tian, this is incredible!" Cruz exclaimed. "We can finally manage complaints digitally!"

Kuya Miguel sent a congratulatory message: "From localhost to production. You did it. This is real software engineering now."

That evening, Tian shared the link in the barangay group chat. Within hours, residents were registering, exploring, submitting real complaints. The system was handling real traffic. Real users. Real data.

One resident reported a broken streetlight at 8 PM. By 10 PM, the maintenance team had seen it, assigned it, and scheduled repair for tomorrow. The old system? Paper forms that took days.

Tian watched the server logs in real-time. Users logging in. Complaints being submitted. The database growing. This wasn't a school project anymore. This was infrastructure. This was public service.

But the work wasn't done. Tomorrow: the final project. The ultimate test. Building the complete Online Barangay Service Portal—everything learned, everything mastered, deployed for real.

_Next up: Lesson 47—Final Project: Online Barangay Service Portal!_ 🏛️
