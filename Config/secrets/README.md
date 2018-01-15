<p align="center">
    <a href="#what-is-that-folder">What is that folder?</a> &bull;
    <a href="#why-it-is-empty">Why it is empty?</a>
</p>

---

What is that folder?
===================
Inside this folder you need to create an *app.json* file.<br>
In this JSON file you have to write your secret key to be set in the Telegram Webhook URL.<br>
This is the file format for **Telegram**:

```json

{
  "telegram" :
  {
    "secret": "XXXXXXXXXXXXXX"
  }
}
```

And this is the one for **Messenger**:

```json
{
  "messenger" :
  {
    "secret": "XXXXXXXXXXXXXX",
    "token": "XXXXXXXXXXXXXX"
  }
}
```

Or combine them together:
```json
{
  "telegram" :
  {
    "secret": "XXXXXXXXXXXXXX"
  },

  "messenger" : 
  {
    "secret": "XXXXXXXXXXXXXX",
    "token": "XXXXXXXXXXXXXX"
  }
}
```

Why it is empty?
================
For security reason I can't commit my *app.json* file.<br>
So for now you have to create it by your self.<br>

**P.S.:** If you want you can use an environment variable and use it with something like `$SECRET`. I prefer to use a JSON file instead.
