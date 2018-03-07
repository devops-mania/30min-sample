var http = require('http');
var server = http.createServer (
    function(request,response) {
        //最低限としては以下不要と思われるが、今後運用検証とかする上では必要になってくるかも。。
        //response.writeHead(200,{'Content-Type':'text/plain'});
        response.write('Hello world');
        response.end();
    }
).listen(3000);
