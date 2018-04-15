var request = require('request'),
    assert = require('assert');

describe('html', function(){
    it('returns Hello World', function(){
        var headers = {
            'Content-Type': 'application/json'
        }
        var options = {
            url: 'http://localhost:3000/',
            method: 'GET',
            headers: headers
        }
        request(options, function (err, response, body){
            if (err) {
                assert.fail();
            }
            assert.equal(200, response.statusCode);
            assert.equal(body, 'Hello world');
        });
    });
});