-- Flyway Migration: Add user roles
-- Version: 2
-- Description: Add roles table and user_roles junction table

CREATE TABLE IF NOT EXISTS roles (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS user_roles (
    user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    role_id INTEGER NOT NULL REFERENCES roles(id) ON DELETE CASCADE,
    assigned_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, role_id)
);

-- Insert default roles
INSERT INTO roles (name, description) VALUES
    ('admin', 'Administrator with full access'),
    ('user', 'Regular user with limited access'),
    ('guest', 'Guest user with read-only access');
