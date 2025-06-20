import tornado.web
import tornado.httpserver
import subprocess
import os

def restart_kiosk():
    subprocess.run(["killall", "chromium"],
                   stdout=subprocess.PIPE,
                   stderr=subprocess.PIPE,
                   text=True
                   )
    subprocess.run(["sudo", "systemctl", "restart", "kiosk.service"],
                   stdout=subprocess.PIPE,
                   stderr=subprocess.PIPE,
                   text=True
                   )


class KioskRestartHandler(tornado.web.RequestHandler):
    def post(self):
        restart_kiosk()


class KioskErrorHandler(tornado.web.RequestHandler):
    def get(self):
        self.set_header("Content-Type", "text/html")
        self.render("kioskError.html")

def main():
    app = tornado.web.Application([
        tornado.web.url(r"/", KioskErrorHandler),
        tornado.web.url(r"/restart", KioskRestartHandler),
        tornado.web.url(r"/static/(.*)", tornado.web.StaticFileHandler, {"path": os.path.join(os.path.dirname(__file__), "static")}),
    ])


    http_server = tornado.httpserver.HTTPServer(app)
    http_server.listen(8080, address='localhost')
    tornado.ioloop.IOLoop.instance().start()

    # main application web app
if __name__ == "__main__":
    main()
