vcl 4.0;

import std;

backend default {
    .host = "flask";
    .port = "80";
}

sub vcl_recv {
    # Utiliser l'en-tête X-Real-IP pour l'adresse IP du client
    if (req.http.X-Real-IP) {
        set req.http.X-Forwarded-For = req.http.X-Real-IP;
    }

    if (req.url ~ "^@") {
        return (synth(403, "Forbidden"));
    }

    if (req.http.Transfer-Encoding) {
        set req.http.suspicious_request = "1";
    }

    if (req.http.Content-Length) {
        set req.http.suspicious_request = req.http.suspicious_request + "1";
    }

    if (req.http.suspicious_request == "11") {
        return (synth(200, "Possible HTTP Request Smuggling detected!"));
    }

    return (hash);
}

sub vcl_pipe {
    set bereq.http.X-Real-IP = req.http.X-Real-IP;
}


sub vcl_backend_response {
    if (beresp.status == 200) {
        set beresp.ttl = 60m;
    }
}

sub vcl_deliver {
    if (obj.hits > 0) {
        set resp.http.X-Cache-Status = "HIT";
    } else {
        set resp.http.X-Cache-Status = "MISS";
    }

    if (resp.status == 200 && resp.reason == "Possible HTTP Request Smuggling detected!") {
        set resp.http.Content-Type = "text/plain";
    }
}
