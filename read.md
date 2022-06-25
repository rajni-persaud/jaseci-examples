# How to run csr bot chat-ui on localhost

In your current working directory (CSR folder):

## WSL T1 :

`pip3 install jaseci-serv or pip3 install jaseci-serv --upgrade`

`jsserv makemigrations base`

`jsserv migrate`

`jsserv runserver 0.0.0.0:8000`

Go to localhost:8000/docs/

You should be able to see Jaseci API Docs


## WSL T2:
`jsserv createsuperuser`

Enter email

Enter password (twice)

`jsctl`

`login http://localhost:8000`

Enter username and password of superuser created above.
If login successful, a token should be generated, copy the token.


## WSL T3:

`jsctl jac build main.jac`


## WSL T2:

`sentinel register -name main -mode ir main.jir`

`alias list`

copy the sentinel id


## In postman

Create a new request:

Select method POST

Enter "http://localhost:8000/js/walker_run" as request URL.

Click on headers tab

Add Authorization as key

Enter "token [TOKEN]" [ensure there is 1 space between token and the token you copied]

Copy the JSON Example from the docs under js/walker_run

Under body tab in postman, select raw and change type to JSON

paste the code

replace "snt" value with your sentinel id [This can be found in WSL T2]

remove nd parameter

set name value to "init"

Send the request

You should get an error like [unable to find enc_question]

## WSL T2:

`Run actions load module jaseci_kit.use_qa`

Resend request

Run talker,
pass parameter utterance