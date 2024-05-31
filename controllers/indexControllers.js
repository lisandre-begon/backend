const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();
const {createUser, loginUser, updatePassword, updatePseudo, deleteUser, getUser} = require('../models/indexModels');
const jwt = require('jsonwebtoken');


exports.createUser = async (req, res) => {
    try {
        const data = req.body;
        const userData = await createUser(data,res);
        res.json(userData);
    }
    catch (error) {
        res.status(500).json({ error: error.message });
    }
}

exports.loginUser = async (req, res) => {
    try {
        const data = req.body;
        const user = await loginUser(data, res);
        res.json({ message: "Login successful", user: user });
    }
    catch (error) {
        console.error(error); 
        if (error.message === "No user found with this email") {
            return res.status(400).json({ message: "Invalid password or email"});
        }else {res.status(500).json({ error: error.message })}
    }
}

exports.logoutUser = async (req, res) => {
    try {
        // Clear the token cookie
        res.clearCookie('token');
        // Send a response to the client
        res.status(200).json({ auth: false, token: null, message: 'You have been logged out.' });
    } catch (error) {
        // Send an error response to the client
        res.status(500).json({ error: `Error during logout: ${error.message}` });
    }
}


exports.updatePassword = async (req, res) => {
    try {
        const user = await updatePassword(req);
        res.json({ message: "Password updated", user: user });
    }
    catch (error) {
        res.status(500).json({ error: error.message });
    }
}

exports.updatePseudo = async (req, res) => {
    try {
        const user = await updatePseudo(req);
        res.json({ message: "User updated", user: user });
    }
    catch (error) {
        res.status(500).json({ error: error.message });
    }
}

exports.deleteUser = async (req, res) => {
    try {
        const email = req.params.email;
        const existingUser = await prisma.user.findUnique({
            where: {
                email: email
            }
        });

        if (!existingUser) {
            return res.status(404).json({ message: "User not found" });
        }

        const user = await prisma.user.delete({
            where: {
                email: email
            }
        });

        res.json({ message: "User deleted", user: user });
    }
    catch (error) {
        res.status(500).json({ error: error.message });
    }
}
exports.checkAdmin = async (req, res) => {
    try {
        if (!req.userId) {
            return res.status(400).json({ error: 'User ID is required' });
        }

        const user = await prisma.user.findUnique({
            where: {
                id: req.userId,
                isadmin: true
            }
        });
        res.json({ isAdmin: user !== null });
    }
    catch (error) {
        console.log(error);
        res.status(500).json({ error: `Error checking auth: ${error.message}` });
    }
}
exports.getUser = async (req, res) => {
    try {
        const data = req.body;
        const user = await getUser(data);
        res.json({ message: "User found", user: user });
    }
    catch (error) {
        res.status(500).json({ error: error.message });
    }
}
