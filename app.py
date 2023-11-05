from bottle import route, get, run, static_file, view, template, post, request
import json
import requests


@get('/favicon.ico')
def serve_favicon():
    return static_file('favicon.png', root='images/')


@get('/images/<filename>.png')
def server_static(filename):
    return static_file('{}.png'.format(filename), root='images/')


@get('/css/<filename>.css')
def server_static(filename):
    return static_file('{}.css'.format(filename), root='css/')


@route('/')
@view('index')
def index():
    return template('index')


@route('/search')
@view('search')
def search():
    return template('search')


@route('/search/make')
@view('search_make')
def search_make():
    return dict(method=request.method)


@post('/search/make')
@view('search_make')
def search_make_results():
    make = request.forms.get('make')
    d = make_request('make', make)
    return {
        'data': d['data'],
        # Fix this tuple value? to an int
        'results': d['results'][0],
        'method': request.method,
        'make': make
    }


@route('/search/price')
@view('search_price')
def search_price():
    return dict(method=request.method)


@post('/search/price')
@view('search_price')
def search_price_results():
    price = request.forms.get('price')
    d = make_request('price', price)
    return {
        'data': d['data'],
        # Fix this tuple value? to an int
        'results': d['results'][0],
        'method': request.method,
        'price': price
    }


api_url = 'http://web.mikebarkas.com/search'


def make_request(param, value):
    r = requests.get(api_url, params={param: value})
    j = json.loads(r.text)

    x = {
        'results': 0,
        'data': []
    }
    if j['Status'] == 'OK':
        x['results'] = j['Results'],
        x['data'] = j['Data']
    return x


run(host='0.0.0.0', port=8081)
