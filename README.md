# treqs 

---

⚠️ Under development ⚠️

---

*treqs* (tee reqs 🦖) stands for text-based requests, where the idea is to use simple config files (TOMLs) to fire off requests from your terminal.

### Usage

Here's a *example.toml* file (using [httpbin](https://httpbin.org)):

```toml
url = "http://httpbin.org/get"
method = "GET"
[params]
key1="value1"
```

```
$ treqs example.toml

{
  "args": {
    "key1": "value1"
  },
  "headers": {
    "Accept": "*/*",
    "Accept-Encoding": "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
    "Host": "httpbin.org",
    "User-Agent": "Faraday v1.8.0",
    "X-Amzn-Trace-Id": "Root=1-61cef5f2-4d3838d5301ed2a930e4da5d"
  },
  "origin": "185.114.123.86",
  "url": "http://httpbin.org/get?key1=value1"
}
```

One of the benefits of using text config files is that you can document/test your APIs easily.

### TODO

- POST/PUT/DELETE requests (body & headers)
- Authentication
- Passing secrets/env vars to the .toml files
- Tests

### FAQs

**Why not Postman/Insomnia/etc?**

(In short: terminal applications > GUIs)

There are a few reasons why I think a project like this one is preferable. First off, I prefer terminal applications to GUIs because I mainly live in the terminal (less switching), it feels nimble (no start up time / loading) and it's easier to compose (you can pipe stdout to, say, [jq](https://github.com/stedolan/jq), like so: `treqs example.toml | jq .`).

**Postman/Insomnia/etc also allow you to share/document APIs, how can treqs help there?**

Your API project can have a directory called `requests` or `treqs` (🤷) with all the TOML config files, like so:

```
src/
  module_1/
  module_2/
  main

README.md

requests/
  get_user.toml
  create_user.toml
  list_all_items.toml
```

You can version your request files and it is closer to where the code is, not in an external service/app. Not only that, TOML is readable, not in a vendor specific binary/config.

**Why not [cURL](https://github.com/curl/curl)?**

This is a great tool and I used it extensively, however I find it hard to deal with complex requests (with auth, body, headers, etc).

**Why TOML?**

It's easy to read & write. That being said, adding JSON support was such a low-hanging fruit that I added it, but I do believe TOML is better.

