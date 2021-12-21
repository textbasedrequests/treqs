# treqs (tee reqs 🦖)

*treqs* stands for text-based requests, where the idea is to use simple config files (TOMLs) to fire off requests from your terminal.

### Usage:

Here's a *example.toml* file:

```toml
url = "https://duckduckgo.com"
method = "GET"
```

In your terminal you can `$ treqs example.toml` and get the following result:

```
<!DOCTYPE html>

...

	<title>DuckDuckGo — Privacy, simplified.</title>

...
```

### Rationale

- Terminal applications > GUIs;
- TOML files are easy to read and write;
- The request config files can serve as API documentation.
