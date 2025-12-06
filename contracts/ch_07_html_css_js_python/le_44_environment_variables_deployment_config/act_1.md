# Activity 1: Environment Variables and Deployment Configuration

In this activity, you'll learn how to properly manage configuration settings, API keys, and sensitive data using environment variables. This is crucial for deploying applications securely.

---

## Activity 1: Understanding Environment Variables

**Environment Variables** are external configuration values that:
- ✅ Keep sensitive data out of code
- ✅ Allow different settings per environment (dev, staging, production)
- ✅ Can be changed without modifying code
- ✅ Are not committed to version control

**Examples of data to store:**
- Database credentials
- API keys
- Secret keys
- Server URLs
- Debug mode settings

---

## Activity 2: Using Python-dotenv for Flask

**Install python-dotenv:**
```bash
pip install python-dotenv
```

**Create `.env` file** (in project root):
```env
# Flask Configuration
FLASK_APP=app.py
FLASK_ENV=development
FLASK_DEBUG=True

# Secret Keys
SECRET_KEY=your-super-secret-key-change-in-production
JWT_SECRET_KEY=your-jwt-secret-key

# Database
DATABASE_URL=postgresql://user:password@localhost/dbname

# API Keys
SENDGRID_API_KEY=your-sendgrid-api-key
GOOGLE_MAPS_API_KEY=your-google-maps-key

# Server Configuration
HOST=0.0.0.0
PORT=5000

# CORS
CORS_ORIGINS=http://localhost:3000,https://yourdomain.com
```

**Create `.env.example`** (committed to git):
```env
# Flask Configuration
FLASK_APP=app.py
FLASK_ENV=development
FLASK_DEBUG=True

# Secret Keys
SECRET_KEY=your-secret-key-here
JWT_SECRET_KEY=your-jwt-secret-key-here

# Database
DATABASE_URL=your-database-url-here

# API Keys
SENDGRID_API_KEY=your-api-key-here
GOOGLE_MAPS_API_KEY=your-api-key-here

# Server Configuration
HOST=0.0.0.0
PORT=5000

# CORS
CORS_ORIGINS=http://localhost:3000
```

**Update `.gitignore`:**
```gitignore
# Environment variables
.env
.env.local
.env.*.local

# Python
__pycache__/
*.pyc
*.pyo
*.pyd
.Python
venv/
env/

# Data files
*.json
*.db
*.sqlite

# IDE
.vscode/
.idea/
```

---

## Activity 3: Using Environment Variables in Flask

**Updated `app.py` with environment variables:**

```python
from flask import Flask, request, jsonify
from flask_cors import CORS
from dotenv import load_dotenv
import os

# Load environment variables
load_dotenv()

app = Flask(__name__)

# Configuration from environment variables
app.config['SECRET_KEY'] = os.getenv('SECRET_KEY', 'default-secret-key')
app.config['DEBUG'] = os.getenv('FLASK_DEBUG', 'False') == 'True'
app.config['DATABASE_URL'] = os.getenv('DATABASE_URL')

# CORS configuration
allowed_origins = os.getenv('CORS_ORIGINS', 'http://localhost:3000').split(',')
CORS(app, origins=allowed_origins, supports_credentials=True)

# Get configuration values
def get_config(key, default=None):
    """Get configuration value from environment"""
    return os.getenv(key, default)

# Example: Using API keys
@app.route('/api/send-email', methods=['POST'])
def send_email():
    api_key = get_config('SENDGRID_API_KEY')
    
    if not api_key:
        return jsonify({
            'success': False,
            'error': 'Email service not configured'
        }), 500
    
    # Use api_key to send email...
    return jsonify({'success': True})

if __name__ == '__main__':
    host = get_config('HOST', '127.0.0.1')
    port = int(get_config('PORT', 5000))
    debug = get_config('FLASK_DEBUG', 'False') == 'True'
    
    app.run(host=host, port=port, debug=debug)
```

---

## Activity 4: Configuration for Different Environments

**Create `config.py`:**

```python
import os
from dotenv import load_dotenv

load_dotenv()

class Config:
    """Base configuration"""
    SECRET_KEY = os.getenv('SECRET_KEY', 'dev-secret-key')
    JWT_SECRET_KEY = os.getenv('JWT_SECRET_KEY', 'jwt-secret-key')
    DATABASE_URL = os.getenv('DATABASE_URL')
    
    # Email settings
    MAIL_SERVER = os.getenv('MAIL_SERVER', 'smtp.gmail.com')
    MAIL_PORT = int(os.getenv('MAIL_PORT', 587))
    MAIL_USE_TLS = os.getenv('MAIL_USE_TLS', 'True') == 'True'
    MAIL_USERNAME = os.getenv('MAIL_USERNAME')
    MAIL_PASSWORD = os.getenv('MAIL_PASSWORD')
    
    # File upload
    UPLOAD_FOLDER = os.getenv('UPLOAD_FOLDER', 'uploads')
    MAX_CONTENT_LENGTH = int(os.getenv('MAX_CONTENT_LENGTH', 16 * 1024 * 1024))  # 16MB

class DevelopmentConfig(Config):
    """Development configuration"""
    DEBUG = True
    TESTING = False
    DATABASE_URL = os.getenv('DEV_DATABASE_URL', 'sqlite:///dev.db')

class ProductionConfig(Config):
    """Production configuration"""
    DEBUG = False
    TESTING = False
    
    # More strict settings for production
    SESSION_COOKIE_SECURE = True
    SESSION_COOKIE_HTTPONLY = True
    SESSION_COOKIE_SAMESITE = 'Lax'

class TestingConfig(Config):
    """Testing configuration"""
    DEBUG = False
    TESTING = True
    DATABASE_URL = 'sqlite:///test.db'

# Configuration dictionary
config = {
    'development': DevelopmentConfig,
    'production': ProductionConfig,
    'testing': TestingConfig,
    'default': DevelopmentConfig
}

def get_config():
    """Get configuration based on FLASK_ENV"""
    env = os.getenv('FLASK_ENV', 'development')
    return config.get(env, config['default'])
```

**Use configuration in `app.py`:**

```python
from flask import Flask
from config import get_config

app = Flask(__name__)
app.config.from_object(get_config())

# Now you can access config values:
# app.config['SECRET_KEY']
# app.config['DEBUG']
# etc.
```

---

## Activity 5: Frontend Environment Variables

**For plain JavaScript (create `config.js`):**

```javascript
// config.js
const config = {
    development: {
        API_URL: 'http://localhost:5000/api',
        WS_URL: 'ws://localhost:5000',
        DEBUG: true
    },
    production: {
        API_URL: 'https://api.yourdomain.com/api',
        WS_URL: 'wss://api.yourdomain.com',
        DEBUG: false
    }
};

// Detect environment
const ENV = window.location.hostname === 'localhost' ? 'development' : 'production';

// Export configuration
const CONFIG = config[ENV];

// Usage in other files:
// const API_URL = CONFIG.API_URL;
```

**Usage in HTML:**
```html
<script src="config.js"></script>
<script>
    // Use CONFIG object
    console.log('API URL:', CONFIG.API_URL);
    console.log('Debug mode:', CONFIG.DEBUG);
    
    fetch(`${CONFIG.API_URL}/residents`)
        .then(response => response.json())
        .then(data => console.log(data));
</script>
```

---

## Activity 6: Deployment Checklist

**Pre-Deployment Checklist:**

```markdown
## Security
- [ ] Change SECRET_KEY to strong random value
- [ ] Set DEBUG = False in production
- [ ] Use HTTPS (SSL certificate)
- [ ] Set secure cookie flags
- [ ] Validate all user input
- [ ] Use CORS restrictions

## Environment
- [ ] Create production .env file
- [ ] Set all required environment variables
- [ ] Test with production values locally
- [ ] Add .env to .gitignore

## Database
- [ ] Use production database
- [ ] Set up database backups
- [ ] Run migrations
- [ ] Secure database credentials

## Files
- [ ] Set proper file permissions
- [ ] Configure upload limits
- [ ] Set up file backups

## Monitoring
- [ ] Set up error logging
- [ ] Configure monitoring
- [ ] Set up alerts
- [ ] Add health check endpoint

## Performance
- [ ] Enable caching
- [ ] Optimize database queries
- [ ] Compress responses
- [ ] Use CDN for static files
```

**Create `requirements.txt`:**
```bash
pip freeze > requirements.txt
```

**Example `requirements.txt`:**
```txt
Flask==2.3.0
flask-cors==4.0.0
python-dotenv==1.0.0
bcrypt==4.0.1
PyJWT==2.8.0
gunicorn==21.2.0
```

---

## Activity 7: Deployment Configuration Files

**Create `Procfile` (for Heroku):**
```
web: gunicorn app:app
```

**Create `runtime.txt` (Python version):**
```
python-3.11.0
```

**Create `app.yaml` (for Google App Engine):**
```yaml
runtime: python311
entrypoint: gunicorn -b :$PORT app:app

env_variables:
  FLASK_ENV: 'production'
  SECRET_KEY: 'your-production-secret-key'

automatic_scaling:
  min_instances: 1
  max_instances: 10
```

**Create `vercel.json` (for Vercel):**
```json
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
  ]
}
```

---

## Activity 8: Health Check Endpoint

**Add health check to Flask:**

```python
@app.route('/health', methods=['GET'])
def health_check():
    """Health check endpoint for monitoring"""
    try:
        # Check database connection
        # db.session.execute('SELECT 1')
        
        return jsonify({
            'status': 'healthy',
            'timestamp': datetime.now().isoformat(),
            'version': '1.0.0',
            'environment': os.getenv('FLASK_ENV', 'unknown')
        }), 200
    except Exception as e:
        return jsonify({
            'status': 'unhealthy',
            'error': str(e)
        }), 500

@app.route('/api/status', methods=['GET'])
def api_status():
    """API status information"""
    return jsonify({
        'api': 'Barangay Management System',
        'version': '1.0.0',
        'status': 'running',
        'endpoints': {
            'residents': '/api/residents',
            'complaints': '/api/complaints',
            'auth': '/api/auth'
        }
    }), 200
```

---

## Activity 9: Error Handling and Logging

**Add logging configuration:**

```python
import logging
from logging.handlers import RotatingFileHandler
import os

def setup_logging(app):
    """Configure application logging"""
    if not app.debug:
        # Create logs directory if it doesn't exist
        if not os.path.exists('logs'):
            os.mkdir('logs')
        
        # File handler
        file_handler = RotatingFileHandler(
            'logs/app.log',
            maxBytes=10240000,  # 10MB
            backupCount=10
        )
        
        file_handler.setFormatter(logging.Formatter(
            '%(asctime)s %(levelname)s: %(message)s [in %(pathname)s:%(lineno)d]'
        ))
        
        file_handler.setLevel(logging.INFO)
        app.logger.addHandler(file_handler)
        
        app.logger.setLevel(logging.INFO)
        app.logger.info('Application startup')

# Error handlers
@app.errorhandler(404)
def not_found_error(error):
    return jsonify({
        'success': False,
        'error': 'Not found'
    }), 404

@app.errorhandler(500)
def internal_error(error):
    app.logger.error(f'Server Error: {error}')
    return jsonify({
        'success': False,
        'error': 'Internal server error'
    }), 500

# Initialize logging
setup_logging(app)
```

---

## Activity 10: Deployment Script

**Create `deploy.sh`:**

```bash
#!/bin/bash

# Deployment script for Barangay Management System

echo "🚀 Starting deployment..."

# 1. Check environment
if [ -z "$FLASK_ENV" ]; then
    echo "❌ FLASK_ENV not set"
    exit 1
fi

echo "📦 Environment: $FLASK_ENV"

# 2. Install dependencies
echo "📥 Installing dependencies..."
pip install -r requirements.txt

# 3. Run tests
echo "🧪 Running tests..."
python -m pytest tests/

# 4. Database migrations
echo "💾 Running database migrations..."
# flask db upgrade

# 5. Collect static files
echo "📁 Collecting static files..."
# python manage.py collectstatic --noinput

# 6. Restart server
echo "🔄 Restarting server..."
# systemctl restart flask-app

echo "✅ Deployment complete!"
```

Make it executable:
```bash
chmod +x deploy.sh
```

---

## 📚 Key Takeaways

1. **Never commit .env files** to version control
2. Use **different configurations** for dev/staging/production
3. **Validate environment variables** on startup
4. Use **strong secret keys** in production
5. **Disable debug mode** in production
6. Set up **logging and monitoring**
7. Create **health check endpoints**
8. Use **deployment checklists**

---

## 🚀 Best Practices

1. Use environment-specific `.env` files:
   - `.env.development`
   - `.env.staging`
   - `.env.production`

2. Validate required environment variables:
```python
required_vars = ['SECRET_KEY', 'DATABASE_URL']
missing = [var for var in required_vars if not os.getenv(var)]
if missing:
    raise ValueError(f'Missing required env vars: {missing}')
```

3. Use strong secret key generator:
```python
import secrets
secret_key = secrets.token_hex(32)
```

4. Document all environment variables in README

Great job on deployment configuration!