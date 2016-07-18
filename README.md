This container is about as stupidly simple a DKIM signer as is possible: for
every message received on port 8891 (using the milter protocol), it signs
the message using the specified private key and selector.  That's it.


# Deployment

Mount a volume somewhere that contains the private key you want to use for
signing, then specify the key file's location and the desired selector using
env vars.


## Required Environment Variables

Instances of this image require the following environment variables to be
set in order for things to work:

* `DKIM_KEY_FILE` -- the fully-qualified filename of the PEM-formatted
  private key to use to sign all e-mail that comes through this instance.
  This will point to wherever you mounted the private key to use.

* `DKIM_SELECTOR` -- the short, unique string to use as the "DKIM selector"
  on all mail signed by this instance.  This needs to line up with the DNS
  records you created.

* `MILTER_SOCKET` -- the value for the `Socket` parameter in
  `opendkim.conf`.  You probably want to read [the `opendkim.conf`
  manpage](http://www.opendkim.org/opendkim.conf.5.html) to find out exactly
  what is legal here.
