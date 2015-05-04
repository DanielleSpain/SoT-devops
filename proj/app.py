from bottle import route, run, template, response

@route("/")
def idx():
    return "Hello!"


run(host='0.0.0.0', port=8080)
