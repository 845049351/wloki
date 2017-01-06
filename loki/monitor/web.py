from ..base.handlers import BaseHandler


class RelativesIndexHandler(BaseHandler):
    def get(self):
        self.render('monitor/index.html')


class TemplatesIndexHandler(BaseHandler):
    def get(self):
        self.redirect("http://falcon-portal.DOMAIN.com/templates")


class ExpressionsIndexHandler(BaseHandler):
    def get(self):
        self.redirect("http://falcon-portal.DOMAIN.com/expressions")


class NodatasIndexHandler(BaseHandler):
    def get(self):
        self.redirect("http://falcon-portal.DOMAIN.com/nodatas")


handlers = [
    ('/relatives', RelativesIndexHandler),
    ('/templates', TemplatesIndexHandler),
    ('/expressions', ExpressionsIndexHandler),
    ('/nodatas', NodatasIndexHandler)
]
