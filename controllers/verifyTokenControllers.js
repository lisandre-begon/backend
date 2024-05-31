const jwt = require('jsonwebtoken');

// Middleware to verify JWT token
exports.verifyToken = async (req, res, next) => {
    const token = req.cookies.token;
    console.log('Token:', token); // Debugging line to ensure token is being read
    if (!token) {
        return res.status(403).send({ auth: false, message: 'No token provided.' });
    }
    try {
        const decoded = await new Promise((resolve, reject) => {
            jwt.verify(token, 'tiensletoken', (err, decodedToken) => {
                if (err) reject(err);
                resolve(decodedToken);
            });
        });
        req.userId = decoded.id;
        next();
    } catch (err) {
        console.error('Token verification failed:', err); // Debugging line to catch verification errors
        return res.status(500).send({ auth: false, message: 'Failed to authenticate token.' });
    }
};
