# Common ETags
Proof of concept for common etags across multiple servers

## Background

ETags are HTTP headers used to minimize client-server traffic when browser cache headers are enabled and content hasn't changed.

An HTTP server will generate a unique value for an ETag based on various criteria and when a client, which has previously requested a given resource, requests the resource again, the HTTP server will compare the ETag value with the "If-None-Match" header submitted by the client to determine if the resource has changed.

If the resource is the same, a `304 Not Modified` response is returned with an empty body; otherwise, the request is fulfilled as if it were not cached.

## Problem

The criteria used to generate an ETag value is typically server-specific. In the case of Apache web server, three pieces of information are used by default:

* INode (the most server-specific)
* File size
* Last modified time

For more information on this, please visit the [Apache documentation](http://httpd.apache.org/docs/2.4/mod/core.html#fileetag)

Because INode is server-specific, a multi-server environment serving the same content will respond with different ETag values under default settings.

In practice, this isn't a big concern considering that the `Cache-Control` and `Expires` headers are the main source of information used to determine if a resource should be cached client-side, and for how long. If a resource is cached properly, no subsequent request is made to the server, hence no 304 is ever issued from the server as no request was made by the client. The only real benefit is to save the byte over the wire in the event a resource expires in cache or a hard-refresh is issued client-side.

## Goal

The goal of this proof of concept is to demonstrate a lowest common denominator value for ETags that will produce a common value for ETag for the same resource being served by multiple machines.

### Tools

1. Vagrant
2. Bash
3. Apache

### Procedure

1. Ensure VirtualBox and Vagrant are installed
2. Ensure ports 8080 and 8081 are available for use
3. Clone this repo
4. Open a Terminal session and navigate to the clone directory
5. Run command `vagrant up`
6. Compare ETag values between the two virtual boxes with cURL
    * `curl -sI http://localhost:8080 | grep ETag`
    * `curl -sI http://localhost:8081 | grep ETag`
