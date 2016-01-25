class A
  privateVar = 1
  constructor: () ->

    console.log 'class a ' + privateVar


class B  extends A

  constructor: () ->
    super
    console.log 'class b'

new B
