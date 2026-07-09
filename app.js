const http = require('http');
const port = process.env.PORT || 3000;

const requestHandler = (req, res) => {
    res.writeHead(200, {'Content-Type': 'text/plain'});
    res.end('Hello Jenkins! This is my first CI/CD project.
');
};

const server = http.createServer(requestHandler);
server.listen(port, () => {
    console.log(`Server running on port ${port}`);
});
