## Background Story

It was deployment day—the most exciting and nerve-wracking day of the entire project. Tian and Rhea Joy had spent three months building the complete barangay portal. Every feature worked flawlessly on their laptops: authentication with secure password hashing, full CRUD operations for complaints, localStorage for user preferences, environment variables for secrets, responsive design for mobile, error handling for edge cases. It was polished, tested, and ready.

But it only existed on `http://localhost:5000`—only they could see it.

Captain Cruz visited the computer lab where Tian was giving a final demonstration. He watched as Tian logged in, submitted a complaint, changed the status, filtered by category, switched to dark mode—everything worked beautifully.

"This is impressive," Captain Cruz said. "When can residents start using it?"

Tian's excitement faltered slightly. "Well... right now it only runs on my computer. I need to deploy it to a server so anyone with internet can access it."

"So what's the timeline for that?" Captain Cruz asked.

Tian glanced at Rhea Joy nervously. "We've never deployed a full-stack application before. We've only ever run things locally."

Ms. Reyes, who'd been using the local version for testing, asked, "What needs to happen for deployment? Can't you just... copy the files to the internet somehow?"

Rhea Joy tried to explain: "It's not that simple. Right now, Flask is running on Tian's laptop as a development server. That's not suitable for production—it's slow, insecure, and only handles one user at a time. We need a real web server, a domain name, HTTPS encryption, a production database, proper configuration..."

Captain Cruz looked concerned. "How long will that take? Months?"

Tian immediately called Kuya Miguel. "Kuya, we're ready to deploy, pero we don't know how. We've only ever developed locally. How do we make this accessible to everyone?"

Miguel had been waiting for this call. "Deployment day! This is where your localhost project becomes a real web application. You've built something amazing—now let's share it with the world."

He shared his screen showing a live website: `https://barangay-portal-demo.onrender.com`. "This is a demo portal I deployed. It's live on the internet. Anyone can access it. That's what we're doing with yours today."

Tian was both excited and intimidated. "Where do we even start?"

Miguel broke down the deployment process:

**Development vs Production:**

```
Development (localhost:5000):
- Runs on your laptop
- DEBUG = True (shows detailed errors)
- SQLite database (simple, local)
- HTTP (no encryption)
- Flask development server (single-threaded)
- Only you can access
- Free

Production (barangay-portal.com):
- Runs on a cloud server
- DEBUG = False (secure error handling)
- PostgreSQL database (robust, scalable)
- HTTPS (encrypted)
- Gunicorn/uWSGI server (multi-threaded)
- Anyone can access
- May have costs (but free tiers exist)
```

"We need to transform your development setup into production," Miguel explained. "That means choosing a hosting platform, configuring a production server, setting up a production database, getting a domain name, enabling HTTPS, and deploying the code."

Rhea Joy was taking notes furiously. "What hosting platform should we use? Aren't those expensive?"

"There are excellent free options for small projects," Miguel assured them. "Render, Railway, PythonAnywhere, Vercel (for frontend), Fly.io. These platforms offer free tiers perfect for community projects like yours. I recommend Render—simple deployment, free PostgreSQL database included, HTTPS automatic, great for Flask apps."

He showed them the Render dashboard. "You connect your GitHub repository, configure some settings, click Deploy, and Render automatically builds and hosts your application. Within minutes, you have a live URL."

Tian was skeptical. "It can't be that easy. We've been building this for months."

"The building was the hard part," Miguel said with a smile. "Deployment is surprisingly straightforward IF you've structured your application properly—which you have. Environment variables? ✓ Database migrations? ✓ Requirements file? ✓ Proper configuration? ✓ You're already prepared."

Miguel walked them through pre-deployment checklist:

**Pre-Deployment Checklist:**
☐ Set DEBUG = False for production
☐ Use environment variables for all secrets
☐ Create requirements.txt with all dependencies
☐ Add Gunicorn (production WSGI server)
☐ Configure database for PostgreSQL
☐ Create Procfile or deployment config
☐ Set up .gitignore properly
☐ Test locally one final time
☐ Push code to GitHub
☐ Choose deployment platform
☐ Configure environment variables on platform
☐ Deploy and test
☐ Set up custom domain (optional)
☐ Enable HTTPS (usually automatic)
☐ Monitor for errors
☐ Celebrate! 🎉

Tian opened his code and started the checklist. "First, change DEBUG to False and make it read from environment variable:"

```python
app.config['DEBUG'] = os.getenv('DEBUG', 'False') == 'True'
```

"Generate requirements.txt:"

```bash
pip freeze > requirements.txt
```

"Add Gunicorn:"

```bash
pip install gunicorn
pip freeze > requirements.txt
```

"Create Procfile for Render:"

```
web: gunicorn app:app
```

Rhea Joy handled the database configuration: "We need to support both SQLite for local development and PostgreSQL for production:"

```python
# app.py
if os.getenv('DATABASE_URL'):
    # Production: use PostgreSQL
    app.config['SQLALCHEMY_DATABASE_URI'] = os.getenv('DATABASE_URL')
else:
    # Development: use SQLite
    app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///barangay.db'
```

Miguel guided them through creating a Render account, connecting their GitHub repository, and configuring the deployment:

**Render Configuration:**
- Build Command: `pip install -r requirements.txt`
- Start Command: `gunicorn app:app`
- Environment Variables: (add SECRET_KEY, DATABASE_URL, etc.)
- Auto-deploy: On (deploy automatically on git push)

They clicked "Create Web Service."

A progress bar appeared. Render was pulling their code, installing dependencies, starting the server. Tian and Rhea Joy watched nervously.

"Building... Installing packages... Starting Gunicorn... Health check passed... LIVE!"

A URL appeared: `https://barangay-portal-batangas.onrender.com`

Tian clicked it with trembling hands.

The login page loaded. Clean, professional, secure (HTTPS lock icon in the browser). He created an account, logged in, submitted a complaint, viewed it in the list. Everything worked.

"It's LIVE!" Tian shouted. "Holy shit, it's actually on the internet!"

Rhea Joy pulled out her phone, navigated to the URL. The mobile-responsive design displayed perfectly. She registered her own account, submitted a test complaint. "It works on mobile! Anyone with a phone can use this now!"

They immediately showed Captain Cruz and Ms. Reyes. Captain Cruz typed the URL into his phone: `https://barangay-portal-batangas.onrender.com`. The site loaded. He registered as a resident, submitted a noise complaint. It appeared in the list.

"This is incredible," Captain Cruz said, genuinely impressed. "I'm submitting a complaint from my phone, and Ms. Reyes can see it on her computer in real-time. This is a real system."

Ms. Reyes was already sharing the URL with other barangay staff. Within minutes, five people were testing the live site simultaneously. All complaints appeared in real-time. No crashes, no slowdowns.

Miguel walked them through post-deployment tasks:

**Post-Deployment:**
1. **Monitor logs**: Check for errors in Render dashboard
2. **Test thoroughly**: Register, login, submit complaints, edit, delete
3. **Mobile testing**: Try on different devices
4. **Load testing**: Have multiple users test simultaneously
5. **Custom domain** (optional): Point `barangay-batangas.gov.ph` to Render
6. **Backups**: Configure automated database backups
7. **Monitoring**: Set up uptime monitoring (e.g., UptimeRobot)

Tian set up a custom domain that the barangay IT office had reserved: `portal.barangay-batangas.gov.ph`. After DNS configuration, the portal was accessible via an official-looking URL.

Captain Cruz announced it at the barangay assembly that evening: "Starting today, residents can submit complaints online at portal.barangay-batangas.gov.ph. Available 24/7, works on any device. No more paper forms, no more lost complaints, no more waiting in line."

Within 24 hours, 15 residents had registered and submitted 8 real complaints. Ms. Reyes was managing them all from the web interface. The digital transformation had begun.

Tian monitored the Render dashboard, watching request logs scroll by. Real users. Real complaints. Real impact.

Rhea Joy designed social media graphics announcing the portal. The barangay Facebook page shared it. Community members commented: "Finally! Technology reaching our barangay!" "Wow, our barangay is so modern now!" "Proud to be from Batangas!"

Miguel called that evening. "How does it feel to have your application live on the internet, being used by real people?"

Tian struggled to express the emotion. "Three months ago, I didn't know what HTML was. Now I've built and deployed a full-stack web application that's solving real problems for real people. It feels... incredible."

Rhea Joy added, "And we didn't just copy a tutorial. We understood the requirements, architected the solution, implemented every feature, debugged every error, tested thoroughly, and deployed to production. We went through the entire software development lifecycle."

Miguel's voice was full of pride. "You're not students anymore. You're developers. You've built, shipped, and maintained production software. That's the milestone. Welcome to the real world of web development."

---

## Theory & Lecture Content

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

1. **Render** (Recommended)
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

_Next up: Lesson 47 - Final Project: Online Barangay Service Portal!_
