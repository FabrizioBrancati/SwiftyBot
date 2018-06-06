-- example HTTP POST script which demonstrates setting the
-- HTTP method, body, and adding a header

wrk.method = "POST"
wrk.body   = "{\"message\":{\"chat\":{\"id\":0},\"text\":\"\\/start this is a test\",\"from\":{\"first_name\":\"Fabrizio\"}}}"
wrk.headers["Content-Type"] = "application/json"
