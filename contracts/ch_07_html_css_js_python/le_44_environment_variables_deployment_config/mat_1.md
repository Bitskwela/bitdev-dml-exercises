## Background Story

Tian was proud of the secure barangay portal they'd built—authentication, authorization, password hashing, session management. Everything was working perfectly. He wanted to show Kuya Miguel the complete codebase, so he did what every modern developer does: pushed the code to GitHub.

He created a new public repository called `barangay-portal` and pushed all the files:

```bash
git init
git add .
git commit -m "Complete barangay portal with authentication"
git remote add origin https://github.com/tian-rodriguez/barangay-portal.git
git push -u origin main
```

"Done!" he texted Miguel with the GitHub link. "Check out the complete code!"

Within three minutes, his phone rang. Miguel's voice was urgent, almost panicked. "Tian, delete that repository RIGHT NOW. Immediately!"

"What? Why? What's wrong?"

"You just exposed every secret in your application to the ENTIRE WORLD. Your database password, your Flask secret key, your email API credentials—everything. Anyone with that GitHub link can see all your secrets. Delete it NOW!"

Tian's heart raced. He opened the GitHub repository and started reading through the files. His face went pale as he saw:

**app.py, line 8:**
```python
app.config['SECRET_KEY'] = 'my-super-secret-key-12345'
```

**app.py, line 15:**
```python
app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://admin:Password123@localhost/barangay_db'
```

**email_service.py, line 5:**
```python
SENDGRID_API_KEY = 'SG.abc123def456ghi789jkl012mno345.pqrstuvwxyz'
```

All hardcoded. All visible. All PUBLIC.

"Oh no," Tian whispered, immediately deleting the repository. But the damage was potentially done—it had been public for almost 10 minutes.

Miguel guided him through emergency measures: "Change your database password immediately. Regenerate your Flask secret key. Revoke and regenerate your SendGrid API key. Any secret that was in that code needs to be rotated NOW. Assume someone saw it."

Tian frantically changed all credentials, his hands shaking. "I didn't think... I just wanted to share the code. I didn't realize I was exposing secrets."

Rhea Joy, hearing about the incident, checked her own projects. "Oh no, I did the same thing. My Twitter bot project has the API keys right in the code. I pushed it to GitHub last week!"

Miguel, once the immediate crisis was handled, took a teaching tone. "This is one of the most common security mistakes developers make, especially beginners. You hardcode secrets in your code for development, then forget they're there when you share or deploy. You just learned a critical lesson: NEVER hardcode secrets. Ever."

"But how do we use them if we don't write them in the code?" Tian asked, genuinely confused.

"Environment variables," Miguel explained. "You store secrets OUTSIDE your code—in the system environment or in a `.env` file that's never committed to Git. Your code READS those variables at runtime, pero the actual values never appear in your codebase."

He shared his screen showing proper configuration:

**.env file (NOT committed to Git):**
```
SECRET_KEY=my-super-secret-key-12345
DATABASE_URL=postgresql://admin:Password123@localhost/barangay_db
SENDGRID_API_KEY=SG.abc123def456ghi789jkl012mno345.pqrstuvwxyz
```

**app.py (safe to commit):**
```python
import os
from dotenv import load_dotenv

load_dotenv()

app.config['SECRET_KEY'] = os.getenv('SECRET_KEY')
app.config['SQLALCHEMY_DATABASE_URI'] = os.getenv('DATABASE_URL')
```

**.gitignore:**
```
.env
*.pyc
__pycache__/
```

"See the difference?" Miguel explained. "The secrets live in `.env`, which is listed in `.gitignore` so it NEVER gets committed to Git. Your code uses `os.getenv()` to read them at runtime. Someone reading your GitHub repository sees `os.getenv('SECRET_KEY')` pero not the actual key."

Tian understood immediately. "So the secrets exist on my local machine and on the production server, pero never in the Git repository. The code is portable and shareable, but the secrets stay private."

"Exactly," Miguel confirmed. "And this has another huge benefit: different environments can have different secrets. Your development database password can be different from production. Your testing API keys can be different from live keys. Same code, different environment variables."

Rhea Joy was already creating a `.env` file and moving all her secrets there. "So the workflow is:

1. Create `.env` file locally
2. Add all secrets to `.env`
3. Add `.env` to `.gitignore`
4. Use `os.getenv()` in code to read secrets
5. Share code on GitHub—safe because secrets aren't in code
6. On production server, create separate `.env` with production secrets

Code is public, secrets stay private!"

"Perfect," Miguel said. "And there are tools to make this even easier—`python-dotenv` for loading `.env` files automatically, cloud provider secret management systems, environment variable management in deployment platforms. But the principle is always the same: secrets NEVER in code."

Tian thought about the implications. "So every public GitHub repository I look at—React apps, Flask APIs, Django sites—they all use environment variables for secrets?"

"Every professional one, yes," Miguel confirmed. "If you see actual API keys or passwords in public repos, that's a mistake. And security researchers scan GitHub constantly looking for exposed secrets. They find thousands every day—AWS keys, database passwords, API tokens. Those get exploited immediately—crypto mining, data theft, spam bots."

Rhea Joy looked concerned. "What if someone DID see Tian's secrets in those 10 minutes?"

"That's why we rotated everything immediately," Miguel said. "Assume breach, respond fast. The old secrets are now useless. Pero this is exactly why you prevent exposure in the first place. Rotating database credentials is annoying. Rotating production secrets can cause downtime. Prevention is always better."

Tian created a comprehensive `.env` file for the barangay portal:

```
# Flask Configuration
FLASK_APP=app.py
FLASK_ENV=development
SECRET_KEY=generate-a-random-key-here

# Database
DATABASE_URL=sqlite:///barangay.db

# Email Service
SENDGRID_API_KEY=your-sendgrid-key-here
MAIL_FROM=noreply@barangay-portal.ph

# Admin Credentials
ADMIN_USERNAME=admin
ADMIN_PASSWORD=change-on-first-login
```

"Much better," Miguel said. "Now your code can reference these with `os.getenv('SECRET_KEY')` and the actual values stay out of version control."

Miguel showed them advanced patterns:

**Development vs Production:**
```python
# app.py
if os.getenv('FLASK_ENV') == 'production':
    app.config['DEBUG'] = False
    app.config['DATABASE_URL'] = os.getenv('DATABASE_URL')
else:
    app.config['DEBUG'] = True
    app.config['DATABASE_URL'] = 'sqlite:///dev.db'
```

**Required vs Optional:**
```python
# Crash if required secret is missing
SECRET_KEY = os.getenv('SECRET_KEY')
if not SECRET_KEY:
    raise ValueError("SECRET_KEY environment variable must be set")

# Optional with default
MAX_UPLOAD_SIZE = int(os.getenv('MAX_UPLOAD_SIZE', '10485760'))  # 10MB default
```

Tian updated his entire codebase, moving every hardcoded secret to environment variables. He tested locally—everything worked. He committed and pushed to GitHub—no secrets visible.

"Now I can share the code safely," he said with relief.

Miguel gave them a final checklist:

**Environment Variables Checklist:**
☑ Create `.env` file
☑ Add `.env` to `.gitignore`
☑ Move all secrets to `.env`
☑ Use `os.getenv()` in code
☑ Install `python-dotenv` for easy loading
☑ Document required environment variables in README
☑ Create `.env.example` with dummy values as a template
☑ Never commit `.env` to Git
☑ Rotate any previously exposed secrets
☑ Use different values for dev and production

"Follow this checklist for every project," Miguel advised. "Make it a habit from day one. The first time you create a Flask app, create `.env` immediately. Configure `python-dotenv` immediately. Add `.env` to `.gitignore` immediately. Make it automatic."

Rhea Joy had already updated all her projects. "I feel so much better now. My GitHub repos are clean, no secrets exposed. And I can share code without worrying."

Captain Cruz, who'd been informed of the security incident, asked, "Is the barangay portal secure now?"

"More secure than before," Tian confirmed. "All secrets are in environment variables. The code is clean. We rotated all credentials. We learned proper configuration management. And we'll never make this mistake again."

Miguel smiled through the video call. "Every developer makes this mistake once. The key is learning from it. You now understand why environment variables exist, why secrets management matters, and how to handle configuration properly. That's professional-level knowledge. You're thinking about security holistically now—not just authentication and authorization, but also secrets management, configuration security, and operational security."

Tian created a new public GitHub repository with the cleaned code, complete with a `.env.example` file showing required variables with dummy values. Anyone could clone the repo, copy `.env.example` to `.env`, fill in their own secrets, and run the application safely.

"This is how professional projects are structured," he said with satisfaction. "Open source code, private secrets. Shareable, secure, professional."

---

## Theory & Lecture Content

## What are Environment Variables?

**Environment variables** are values stored outside your code, in the system environment. They're used for:

- **Secrets**: Passwords, API keys, tokens
- **Configuration**: Database URLs, port numbers
- **Environment-specific settings**: Development vs Production

### Why Use Environment Variables?

**WRONG (Hardcoded):**
```python
# app.py - DON'T DO THIS!
app.config['SECRET_KEY'] = 'my-secret-key-123'
app.config['DATABASE_URL'] = 'postgresql://user:password@localhost/mydb'
app.config['SENDGRID_API_KEY'] = 'SG.abc123def456...'
```

**Problems:**
- Secrets visible in code
- Can't use different values for dev/prod
- If pushed to GitHub, secrets are exposed
- Hard to change without editing code

**CORRECT (Environment Variables):**
```python
# app.py
import os

app.config['SECRET_KEY'] = os.getenv('SECRET_KEY')
app.config['DATABASE_URL'] = os.getenv('DATABASE_URL')
app.config['SENDGRID_API_KEY'] = os.getenv('SENDGRID_API_KEY')
```

**Benefits:**
- Secrets not in code
- Different values per environment
- Safe to push to GitHub
- Easy to update without code changes

<details>
<summary><strong>Click here to view local setup guide (Optional)</strong></summary>

## Setting Up Environment Variables Locally

### Step 1: Create `.env` File

```bash
# .env (in project root)
SECRET_KEY=your-super-secret-key-here-change-this
DATABASE_URL=sqlite:///barangay.db
FLASK_ENV=development
FLASK_DEBUG=True

# Email settings
MAIL_SERVER=smtp.gmail.com
MAIL_PORT=587
MAIL_USERNAME=your-email@gmail.com
MAIL_PASSWORD=your-app-password

# API Keys
SENDGRID_API_KEY=SG.your-api-key-here
GOOGLE_MAPS_API_KEY=AIza...
```

### Step 2: Install python-dotenv

```bash
pip install python-dotenv
```

**Note:** This course uses in-browser coding environments with pre-configured environment variables, so local installation is optional for learning purposes.

### Step 3: Load Environment Variables

```python
# app.py
from flask import Flask
from dotenv import load_dotenv
import os

# Load .env file
load_dotenv()

app = Flask(__name__)

# Access environment variables
app.config['SECRET_KEY'] = os.getenv('SECRET_KEY')
app.config['DATABASE_URL'] = os.getenv('DATABASE_URL')
app.config['FLASK_ENV'] = os.getenv('FLASK_ENV', 'production')  # Default to production

# Check if critical env vars exist
if not app.config['SECRET_KEY']:
    raise ValueError("SECRET_KEY environment variable is not set!")

print(f"Running in {app.config['FLASK_ENV']} mode")
```

### Step 4: Add `.env` to `.gitignore`

```bash
# .gitignore
.env
*.pyc
__pycache__/
instance/
.pytest_cache/
*.db
venv/
```

**CRITICAL:** Never commit `.env` to Git!

### Step 5: Create `.env.example`

```bash
# .env.example (commit this to Git)
SECRET_KEY=your-secret-key-here
DATABASE_URL=sqlite:///barangay.db
FLASK_ENV=development
FLASK_DEBUG=True
MAIL_SERVER=smtp.gmail.com
MAIL_PORT=587
MAIL_USERNAME=your-email@example.com
MAIL_PASSWORD=your-password-here
```

This shows other developers what variables they need to set.

## Configuration Classes

### Organized Config Structure

```python
# config.py
import os
from datetime import timedelta

class Config:
    """Base configuration"""
    SECRET_KEY = os.getenv('SECRET_KEY')
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    
    # Session config
    SESSION_COOKIE_SECURE = True  # HTTPS only
    SESSION_COOKIE_HTTPONLY = True
    SESSION_COOKIE_SAMESITE = 'Lax'
    PERMANENT_SESSION_LIFETIME = timedelta(days=7)
    
    # File upload
    MAX_CONTENT_LENGTH = 16 * 1024 * 1024  # 16MB max upload
    UPLOAD_FOLDER = 'uploads'
    ALLOWED_EXTENSIONS = {'png', 'jpg', 'jpeg', 'gif', 'pdf'}

class DevelopmentConfig(Config):
    """Development environment configuration"""
    DEBUG = True
    TESTING = False
    SQLALCHEMY_DATABASE_URI = os.getenv('DEV_DATABASE_URL', 'sqlite:///dev.db')
    SQLALCHEMY_ECHO = True  # Log SQL queries

class ProductionConfig(Config):
    """Production environment configuration"""
    DEBUG = False
    TESTING = False
    SQLALCHEMY_DATABASE_URI = os.getenv('DATABASE_URL')
    
    # Production security
    SESSION_COOKIE_SECURE = True
    SESSION_COOKIE_HTTPONLY = True

class TestingConfig(Config):
    """Testing environment configuration"""
    TESTING = True
    SQLALCHEMY_DATABASE_URI = 'sqlite:///test.db'
    WTF_CSRF_ENABLED = False  # Disable CSRF for testing

# Config dictionary
config = {
    'development': DevelopmentConfig,
    'production': ProductionConfig,
    'testing': TestingConfig,
    'default': DevelopmentConfig
}
```

### Using Config Classes

```python
# app.py
from flask import Flask
from config import config
import os

def create_app(config_name=None):
    """Application factory pattern"""
    app = Flask(__name__)
    
    # Determine config
    if config_name is None:
        config_name = os.getenv('FLASK_ENV', 'default')
    
    # Load configuration
    app.config.from_object(config[config_name])
    
    # Validate required config
    if not app.config['SECRET_KEY']:
        raise ValueError("SECRET_KEY must be set")
    
    # Initialize extensions
    from models import db
    db.init_app(app)
    
    # Register blueprints
    from routes import main_bp, auth_bp
    app.register_blueprint(main_bp)
    app.register_blueprint(auth_bp, url_prefix='/auth')
    
    return app

if __name__ == '__main__':
    app = create_app()
    app.run()
```

## Generating Secure Secret Keys

```python
# generate_secret_key.py
import secrets

# Generate a secure random secret key
secret_key = secrets.token_urlsafe(32)
print(f"SECRET_KEY={secret_key}")

# Output: SECRET_KEY=xB3kP9mNqW7rT5yH8cV2aF4dG6jL0sZ1...
```

Run this and copy to your `.env` file.

## Database Configuration

### SQLite (Development)

```python
# .env
DATABASE_URL=sqlite:///barangay.db
```

### PostgreSQL (Production)

```python
# .env
DATABASE_URL=postgresql://username:password@localhost:5432/barangay_db
```

### Handling Database URLs

```python
# models.py
from flask_sqlalchemy import SQLAlchemy
import os

db = SQLAlchemy()

def init_db(app):
    """Initialize database"""
    database_url = os.getenv('DATABASE_URL')
    
    # Fix for Heroku postgres URLs (they use postgres:// instead of postgresql://)
    if database_url and database_url.startswith('postgres://'):
        database_url = database_url.replace('postgres://', 'postgresql://', 1)
    
    app.config['SQLALCHEMY_DATABASE_URI'] = database_url
    db.init_app(app)
    
    with app.app_context():
        db.create_all()
```

## Email Configuration

```python
# email.py
from flask_mail import Mail, Message
import os

mail = Mail()

def send_email(subject, recipient, body):
    """Send email using environment variables"""
    msg = Message(
        subject=subject,
        sender=os.getenv('MAIL_USERNAME'),
        recipients=[recipient]
    )
    msg.body = body
    
    try:
        mail.send(msg)
        return True
    except Exception as e:
        print(f"Email error: {e}")
        return False

# Initialize in app
def init_mail(app):
    app.config['MAIL_SERVER'] = os.getenv('MAIL_SERVER')
    app.config['MAIL_PORT'] = int(os.getenv('MAIL_PORT', 587))
    app.config['MAIL_USE_TLS'] = True
    app.config['MAIL_USERNAME'] = os.getenv('MAIL_USERNAME')
    app.config['MAIL_PASSWORD'] = os.getenv('MAIL_PASSWORD')
    mail.init_app(app)
```

## Deployment Preparation

### Requirements File

```bash
# requirements.txt
Flask==2.3.0
Flask-SQLAlchemy==3.0.5
Flask-Mail==0.9.1
python-dotenv==1.0.0
psycopg2-binary==2.9.6
gunicorn==20.1.0
```

Generate automatically:
```bash
pip freeze > requirements.txt
```

### Procfile (for Heroku/Render)

```bash
# Procfile
web: gunicorn app:app
```

### Runtime File

```bash
# runtime.txt
python-3.11.0
```

## Platform-Specific Deployment

### Heroku

```bash
# Install Heroku CLI
heroku login

# Create app
heroku create barangay-portal

# Set environment variables
heroku config:set SECRET_KEY=your-secret-key
heroku config:set DATABASE_URL=postgresql://...
heroku config:set FLASK_ENV=production

# Deploy
git push heroku main

# Run migrations
heroku run python migrate.py
```

### Render

1. Create account at render.com
2. New Web Service
3. Connect GitHub repo
4. Set environment variables in dashboard:
   - `SECRET_KEY`
   - `DATABASE_URL`
   - `FLASK_ENV=production`
5. Deploy

### Vercel (Frontend only)

```json
// vercel.json
{
  "builds": [
    {
      "src": "app.py",
      "use": "@vercel/python"
    }
  ],
  "routes": [
    {
      "src": "/(.*)",
      "dest": "app.py"
    }
  ],
  "env": {
    "FLASK_ENV": "production"
  }
}
```

## Security Checklist

### Before Deployment

- [ ] All secrets in environment variables
- [ ] `.env` in `.gitignore`
- [ ] `.env.example` created and committed
- [ ] `SECRET_KEY` is strong and random
- [ ] `DEBUG` set to `False` in production
- [ ] Database credentials secure
- [ ] HTTPS enabled (`SESSION_COOKIE_SECURE = True`)
- [ ] CSRF protection enabled
- [ ] Rate limiting implemented
- [ ] Input validation on all forms
- [ ] SQL injection protection (use ORM)
- [ ] XSS protection (sanitize inputs)

### Environment Variable Security

```python
# app.py - Validate critical env vars
required_vars = ['SECRET_KEY', 'DATABASE_URL']

for var in required_vars:
    if not os.getenv(var):
        raise ValueError(f"Required environment variable {var} is not set!")

# Don't log sensitive values
print(f"Database: {os.getenv('DATABASE_URL')[:20]}...")  # Only show first 20 chars
```

## Local vs Production Settings

### Development (Local)

```bash
# .env.development
FLASK_ENV=development
DEBUG=True
DATABASE_URL=sqlite:///dev.db
SECRET_KEY=dev-secret-key-not-secure
MAIL_SUPPRESS_SEND=True  # Don't actually send emails in dev
```

### Production (Server)

```bash
# Set on server (Heroku/Render dashboard)
FLASK_ENV=production
DEBUG=False
DATABASE_URL=postgresql://...
SECRET_KEY=<strong-random-key>
SESSION_COOKIE_SECURE=True
```

## Monitoring and Logging

```python
# logging_config.py
import logging
import os

def setup_logging(app):
    """Configure logging based on environment"""
    if app.config['FLASK_ENV'] == 'production':
        # Production: Log to file
        logging.basicConfig(
            filename='app.log',
            level=logging.WARNING,
            format='%(asctime)s - %(levelname)s - %(message)s'
        )
    else:
        # Development: Log to console
        logging.basicConfig(
            level=logging.DEBUG,
            format='%(levelname)s - %(message)s'
        )
    
    app.logger.info(f"App started in {app.config['FLASK_ENV']} mode")
```

## Best Practices

### 1. Never Commit Secrets

```bash
# Check before committing
git diff

# If you accidentally committed secrets:
git filter-branch --force --index-filter \
  "git rm --cached --ignore-unmatch .env" \
  --prune-empty --tag-name-filter cat -- --all

# Then change all exposed secrets immediately!
```

### 2. Rotate Secrets Regularly

```python
# Update SECRET_KEY every 90 days
# Update API keys when team members leave
# Use different keys for different environments
```

### 3. Least Privilege Principle

```bash
# Database user should only have necessary permissions
# Don't use root/admin accounts in production
```

### 4. Use Secret Management Services

For enterprise:
- **AWS Secrets Manager**
- **Azure Key Vault**
- **Google Cloud Secret Manager**
- **HashiCorp Vault**

## Real-World Philippine Context

### Compliance Requirements

**Data Privacy Act (RA 10173):**
- Store sensitive data securely
- Use encryption for passwords
- Log access to personal information
- Implement data breach response plan

### Cost-Effective Deployment

**Free Tier Options for Filipino Students:**
1. **Render** - Free web services
2. **Railway** - Free starter plan
3. **PythonAnywhere** - Free basic plan
4. **Vercel** - Free for personal projects
5. **Heroku** - Eco dyno ($5/month)

### Philippine Hosting Providers

- **ServerFreak.com** (Singapore/PH)
- **Web.com.ph** (Philippine-based)
- **CloudStaff** (PH data centers)

## Testing Environment Variables

```python
# test_config.py
import unittest
import os

class ConfigTest(unittest.TestCase):
    def test_required_env_vars(self):
        """Test that required env vars are set"""
        required = ['SECRET_KEY', 'DATABASE_URL']
        
        for var in required:
            value = os.getenv(var)
            self.assertIsNotNone(value, f"{var} is not set")
            self.assertNotEqual(value, '', f"{var} is empty")
    
    def test_secret_key_strength(self):
        """Test that SECRET_KEY is strong enough"""
        secret_key = os.getenv('SECRET_KEY')
        self.assertGreater(len(secret_key), 20, "SECRET_KEY too short")
```

## Common Mistakes

### Mistake 1: Committing `.env`
```bash
# Check if .env is tracked
git ls-files | grep .env

# If found, remove it
git rm --cached .env
echo ".env" >> .gitignore
git commit -m "Remove .env from tracking"
```

### Mistake 2: Using Same Keys for Dev and Prod
```bash
# Use different keys!
# .env.development
SECRET_KEY=dev-key-12345

# Production (server)
SECRET_KEY=prod-strong-random-key-abc123xyz789
```

### Mistake 3: Not Validating Env Vars
```python
# ALWAYS validate critical vars on startup
if not os.getenv('SECRET_KEY'):
    raise ValueError("SECRET_KEY must be set!")
```

## Summary

**Environment Variables:**
- Store secrets and configuration outside code
- Different values for dev/staging/production
- Never commit `.env` to Git
- Use `.env.example` to show required variables

**Deployment Config:**
- Organize settings with config classes
- Validate required variables on startup
- Use strong, random secret keys
- Enable security features in production

**Security:**
- Never hardcode secrets
- Rotate keys regularly
- Use HTTPS in production
- Monitor and log appropriately

Next lesson: Local Storage and Sessions for client-side data persistence!

---

## Closing Story

Tian followed Kuya Miguel's instructions carefully. Created `.env` file. Moved all secrets. Added to `.gitignore`. Generated a new strong secret key. Created `.env.example` for documentation.

Then pushed the cleaned code to GitHub. This time, no passwords. No API keys. Just clean, professional code.

"Better," Miguel approved. "Now even if someone clones your repo, they can't access your database or impersonate your app. That's production-ready code."

Captain Cruz asked during their next meeting, "Tian, how do I run this if I download it?"

Tian smiled. "Just copy `.env.example` to `.env`, fill in your own values, and run. That's the beauty of environment variables—everyone can use different credentials."

That night, Tian realized something important: Professional development wasn't just about writing code that worked. It was about writing code that was *secure*, *maintainable*, and *deployable*. 

The barangay portal was getting closer to real-world readiness. But there was still more to learn: client-side storage, session management, and finally—deployment to a real server where residents could actually use it.

_Next up: Lesson 45 - Using Local Storage and Sessions!_
