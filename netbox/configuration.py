import os
from pathlib import Path

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = os.getenv("SECRET_KEY", "unsafe-default-key")

# Debug mode
DEBUG = os.getenv("DEBUG", "false").lower() == "true"
MAX_DB_WAIT_TIME = os.getenv("MAX_DB_WAIT_TIME", "30")
DEVELOPER = True

# Allowed hosts
ALLOWED_HOSTS = os.getenv("ALLOWED_HOSTS", "*").split(",")

# Database configuration
DATABASE = {
    'NAME': os.getenv("DB_NAME", "netbox"),
    'USER': os.getenv("DB_USER", "netbox"),
    'PASSWORD': os.getenv("DB_PASSWORD", "netbox"),
    'HOST': os.getenv("DB_HOST", "localhost"),
    'PORT': os.getenv("DB_PORT", "5432"),
    'CONN_MAX_AGE': int(os.getenv("DB_CONN_MAX_AGE", "300")),
}

# Redis caching
REDIS = {
    'tasks': {
        'HOST': os.getenv("REDIS_HOST", "localhost"),
        'PORT': int(os.getenv("REDIS_PORT", "6379")),
        'PASSWORD': os.getenv("REDIS_PASSWORD", ""),
        'DATABASE': int(os.getenv("REDIS_DB_TASKS", "0")),
        'SSL': os.getenv("REDIS_SSL", "false").lower() == "true",
    },
    'caching': {
        'HOST': os.getenv("REDIS_HOST", "localhost"),
        'PORT': int(os.getenv("REDIS_PORT", "6379")),
        'PASSWORD': os.getenv("REDIS_PASSWORD", ""),
        'DATABASE': int(os.getenv("REDIS_DB_CACHING", "1")),
        'SSL': os.getenv("REDIS_SSL", "false").lower() == "true",
    }
}

# Plugins
PLUGINS = [
    'my_plugin'
]

# Plugin config
PLUGINS_CONFIG = {
    'my_plugin': {
    
    }
}

# Timezone
TIME_ZONE = os.getenv("TZ")
USE_TZ = True
