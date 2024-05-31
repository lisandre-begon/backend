async function verifyToken(req, res, next) {
    const token = req.cookies.token;
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
        // if everything good, save to request for use in other routes
        req.userId = decoded.id;
        next();
    } catch (err) {
        return res.status(500).send({ auth: false, message: 'Failed to authenticate token.' });
    }
}

module.exports = verifyToken;