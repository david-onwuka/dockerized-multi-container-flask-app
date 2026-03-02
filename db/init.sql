-- Create a simple table for your app
CREATE TABLE IF NOT EXISTS tasks (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    completed BOOLEAN DEFAULT FALSE
);

-- Insert a sample task
INSERT INTO tasks (title, completed) VALUES ('Welcome to your multi-container app!', FALSE);