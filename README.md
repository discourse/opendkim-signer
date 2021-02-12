This container is about as stupidly simple a DKIM signer as is possible: for
every message received on whatever socket you specify with the
`MILTER_SOCKET` environment variable (using the milter protocol), it signs
the message using the specified private key, with the domain (`d=`) and
selector (`s=`) parameters given in the relevant environment variables. 
That's it.


# Deployment

Mount a volume somewhere that contains the private key you want to use for
signing, then specify the key file's location, along with the desired domain
and selector, using env vars.  Also, specify a milter socket location so
that your MTA can get the messages to the DKIM server.


## Required Environment Variables

Instances of this image require the below environment variables to be
set in order for things to work.

The following two variables should be repeated for each domain signed by the
container, with the word "domain" replaced by the domain itself with periods
converted to underscores. For example: `DKIM_KEY_discourse_org` and
`DKIM_SELECTOR_discourse_org`.

* `DKIM_KEY_domain` -- the PEM-formatted private key data used to sign all
  email that comes through this instance from "domain"

* `DKIM_SELECTOR_domain` -- the short, unique string to use as the
  "DKIM selector" on all mail signed for "domain". This needs to line up with
  domainkey DNS records for "domain".

The following two variables must always be set:

* `DKIM_DEFAULT_DOMAIN` -- the default domain to use on all other mail.

* `MILTER_SOCKET` -- the value for the `Socket` parameter in
  `opendkim.conf`.  You probably want to read [the `opendkim.conf`
  manpage](http://www.opendkim.org/opendkim.conf.5.html) to find out exactly
  what is legal here.

# Publishing

Running `make` will build and push.
