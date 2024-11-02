// Import required modules
const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const http = require('http');
const multer = require('multer');
const connection = require('./mydb'); // Import database connection
const authRoutes = require('./routes/auth'); // Import auth routes
const searchRoutes = require('./routes/searchRoutes');
const profileRoutes = require('./routes/profile'); // Import profile routes
const recommendationRoutes = require('./controllers/recommendationController');
const resumeController = require('./controllers/resumeController');
const jobsController = require('./controllers/jobsController');
const session = require('express-session');
const MySQLStore = require('express-mysql-session')(session);
const sessionStore = new MySQLStore({}, connection);

// Create Express app
const app = express();
const server = http.createServer(app);

// Serve static files
app.use('/socket.io', express.static(__dirname + '/node_modules/socket.io/client-dist/'));

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Middleware setup
app.use(cors({
    origin: 'http://localhost:63342', // Frontend URL allowed as origin
    credentials: true // Allow frontend to send cookies
}));

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(express.static('public'));
app.use(session({
    key: 'user_sid',
    secret: 'coir',
    resave: false,
    saveUninitialized: false,
    store: sessionStore, // Use MySQL session store
    cookie: {
        expires: 86400000, // Set to one day
        httpOnly: true,
        secure: false // Should be false for local development
    }
}));

app.use('/api', authRoutes); // Mount auth routes
app.use('/api', searchRoutes);
app.use('/api', profileRoutes); // Ensure profile routes are mounted
app.use('/api', recommendationRoutes);
app.use('/api/jobs', jobsController);
app.use('/api/resume', resumeController);

app.use((req, res, next) => {
    console.log('Received request:', req.method, req.url);
    next();
});

// Multer storage configuration
const storageConfig = multer.diskStorage({
    destination: (req, file, cb) => {
        cb(null, 'uploads/resumes'); // Ensure this path exists with write permissions
    },
    filename: (req, file, cb) => {
        cb(null, `${Date.now()}-${file.originalname}`);
    }
});
const upload = multer({ storage: storageConfig });

// Route for posting a job
app.post('/api/post-job', (req, res) => {
    const { company_name, location, industry, job_type, experience_level, responsibilities, benefits, salary, job_requirements, employer_id } = req.body;

    if (!company_name || !location || !industry || !job_type || !experience_level || !employer_id) {
        return res.status(400).json({ success: false, message: 'Missing required fields' });
    }

    const query = `INSERT INTO jobs (company_name, location, industry, job_type, experience_level, responsibilities, benefits, salary, requirements, posted_date, employer_id)
                   VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, NOW(), ?)`;

    connection.query(query, [company_name, location, industry, job_type, experience_level, responsibilities, benefits, salary, job_requirements, employer_id], (err, result) => {
        if (err) {
            console.error('Error inserting job:', err);
            return res.status(500).json({ success: false, message: 'Failed to post job' });
        }

        console.log('Job posted successfully!');
        res.status(200).json({ success: true, message: 'Job posted successfully' });
    });
});

// Chat route
app.post('/api/chat/message', (req, res) => {
    console.log('Received message request:', req.body);
    const { sender_id, receiver_id, username, message } = req.body;

    // Ensure sender_id and receiver_id are numbers and message is a non-empty string
    if (!sender_id || !receiver_id || !username || typeof message !== 'string' || message.trim() === '') {
        return res.status(400).json({ success: false, message: 'Missing required fields or incorrect field type' });
    }

    const query = 'INSERT INTO chat_messages (sender_id, receiver_id, username, message, timestamp) VALUES (?, ?, ?, ?, NOW())';
    connection.query(query, [sender_id, receiver_id, username, message], (err, result) => {
        if (err) {
            console.error('Error saving chat message:', err);
            return res.status(500).json({ success: false, message: 'Error saving chat message' });
        }
        res.status(200).json({ success: true, message: 'Message sent successfully' });
    });
});

app.get('/api/chat/messages/:userId/:partnerId', (req, res) => {
    const { userId, partnerId } = req.params;

    const query = `
        SELECT * FROM chat_messages
        WHERE (sender_id = ? AND receiver_id = ?)
           OR (sender_id = ? AND receiver_id = ?)
        ORDER BY timestamp ASC
    `;
    connection.query(query, [userId, partnerId, partnerId, userId], (err, results) => {
        if (err) {
            console.error('Error reading chat history:', err);
            return res.status(500).json({ success: false, message: 'Failed to retrieve messages' });
        }

        const relationQueries = results.map(message => {
            return new Promise((resolve, reject) => {
                // 首先从 employers 表中查询 relation
                const employerQuery = `SELECT relation FROM employers WHERE id = ?`;
                connection.query(employerQuery, [message.sender_id], (err, employerResults) => {
                    if (err) return reject(err);
                    if (employerResults.length > 0) {
                        message.role = 'employer';
                        return resolve(message);
                    }
                    // 如果不是雇主，从 jobseekers 表中查询 relation
                    const jobseekerQuery = `SELECT relation FROM jobseekers WHERE id = ?`;
                    connection.query(jobseekerQuery, [message.sender_id], (err, jobseekerResults) => {
                        if (err) return reject(err);
                        if (jobseekerResults.length > 0) {
                            message.role = 'jobseeker';
                        } else {
                            message.role = 'unknown';
                        }
                        resolve(message);
                    });
                });
            });
        });

        // 等待所有 relation 查询完成
        Promise.all(relationQueries)
            .then(messagesWithRelations => {
                res.status(200).json({ success: true, messages: messagesWithRelations });
            })
            .catch(error => {
                console.error('Error retrieving relation information:', error);
                res.status(500).json({ success: false, message: 'Failed to retrieve messages with relation information' });
            });
    });
});



// API to delete chat messages
app.delete('/api/chat/message/:id', (req, res) => {
    const messageId = req.params.id;

    const query = 'DELETE FROM chat_messages WHERE id = ?';
    connection.query(query, [messageId], (err, result) => {
        if (err) {
            console.error('Error deleting chat record:', err);
            return res.status(500).json({ success: false, message: 'Failed to delete message' });
        }

        if (result.affectedRows > 0) {
            res.status(200).json({ success: true, message: 'Message deleted successfully' });
        } else {
            res.status(404).json({ success: false, message: 'Message not found' });
        }
    });
});

app.get('/api/chat/messages', (req, res) => {
    connection.query('SELECT * FROM chat_messages ORDER BY timestamp ASC', (err, results) => {
        if (err) {
            console.error('Error reading chat history:', err);
            return res.status(500).json({ success: false, message: 'Failed to retrieve messages' });
        }
        res.status(200).json({ success: true, messages: results });
    });
});

// Start server
const PORT = 3000;
server.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});
