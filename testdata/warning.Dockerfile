FROM debian:buster

# emits an info and a warning level violation.
RUN apt-get install foo
