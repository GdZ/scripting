
require 'patron'

sess = Patron::Session.new
sess.timeout = 10
sess.base_url = "http://10.74.61.125"
sess.headers['User-Agent'] = 'herry/1.0'
sess.enable_debug "/tmp/patron.debug"

resp = sess.get("/herry/test.html")
if resp.status < 400
puts resp.body
end

