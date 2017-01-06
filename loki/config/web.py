from ..base.handlers import BaseHandler


class ConfigIndexHandler(BaseHandler):
    def get(self):
        self.render('config/index.html')


handlers = [
    ('/?', ConfigIndexHandler),
]
