# Erlang gen_microservice #

This library solves the problem of implementing microservices with
Erlang.

Your code just needs to add the behaviour `gen_microservice` to your
module, implement a couple of callbacks, and you will have a
**microservice** ready to use in your stealth startup.

We bring you the magic that let WhatsApp scale to millions of users
and dollars, _here_, for free.

## Features ##

- **Full Hot Code Reload**: the library implements some magic to let
    your app be upgraded without downtime behind the scenes.
- **Asynchronous and Synchronous Callbacks**: with this library you
    can have fully asynchronous code like modern
    [io.js](https://nodejs.org) apps, or use sync callbacks like old
    monolithic apps, your choice, we don't limit you.
- **Fault Tolerance**: I know most senior developers don't write bugs,
    but for that particular case where the junior dev is allowed to
    push code to production, we need to be covered. This library
    integrates seamlessly with Erlang's _nine nines_ runtime, so we got
    you covered there as well.

## Distributed Systmemes ##

Distributed Systems are the talk of the day. The more users your
_TODO_ app has, the more scalability and distributed consensus you
will need. This library anticipates this problem by being written in
Erlang, the only language where distributed systems problems have been
really solved.

## Usage ##

Your module needs to implement several callbacks:

- `init/1`: this function will be called by your microservices
  orchestrator system to launch your gen_microservice.
- `monolithic_call/3`: if your code _still_ uses synchronous calls,
  then those functionalities should be implemented using this
  callback.
- `modern_async/2`: if you have a modernized app, your app logic will
  mostly reside inside these callbacks.
- `handle_info/2`: your microservice will receive external messages
  via this callback.
- `code_change/2`: the magic for reloading and upgrading your
  microservice live in production happens here.
- `terminate/2`: called when it's time to scale down and decommission
  your microservice instance.

Check the example on `doc/kitty_gen_microservice.erl`.

## License ##

See LICENSE.md
