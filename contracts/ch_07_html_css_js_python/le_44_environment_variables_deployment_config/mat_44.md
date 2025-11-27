# Lesson 44: Environment Variables + Deployment Config

## Background Story

Tian pushed the barangay portal code to GitHub to share with Kuya Miguel. Within minutes, Miguel called urgently.

"Tian, delete that repository NOW!"

"Why? What's wrong?"

"Look at your code. Line 15. Your database password. Line 23. Your secret key. Line 67. Your email API key. Everything is PUBLIC. Anyone can see it."

Tian's heart sank. The repository had been public for 10 minutes. How many people saw it?

"This is why we use environment variables," Miguel explained calmly. "Never hardcode secrets. Let me show you the proper way."

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

## Setting Up Environment Variables

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

_Next up: Lesson 45—Using Local Storage and Sessions!_ 💾
