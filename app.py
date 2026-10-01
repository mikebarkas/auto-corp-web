from bottle import default_app, route, get, run, static_file, view, template, post, request
from os import getenv as os_getenv
import sys
import requests

api_url = os_getenv('API_URL')
if not api_url:
    sys.exit('API_URL environment variable is not set')

@get('/favicon.ico')
def serve_favicon():
    return static_file('favicon.png', root='images/')


@get('/images/<filename>.png')
def serve_image(filename):
    return static_file('{}.png'.format(filename), root='images/')


@get('/css/<filename>.css')
def serve_css(filename):
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
        'results': d['results'],
        'error': d['error'],
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
        'results': d['results'],
        'error': d['error'],
        'method': request.method,
        'price': price
    }


def make_request(param, value):
    x = {
        'results': 0,
        'data': [],
        'error': False
    }
    try:
        r = requests.get(api_url, params={param: value}, timeout=5)
        r.raise_for_status()
        j = r.json()
    except (requests.RequestException, ValueError):
        x['error'] = True
        return x

    if j.get('Status') == 'OK':
        x['results'] = j['Results']
        x['data'] = j['Data']
    return x


app = default_app()

if __name__ == '__main__':
    run(host='0.0.0.0', port=8081)
