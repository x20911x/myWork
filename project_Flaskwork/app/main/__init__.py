# main 目錄: inclued the url and views of main work

from flask import Blueprint
main = Blueprint('main',__name__)
from . import views
# from . import views_tool