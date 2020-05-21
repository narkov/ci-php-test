# ci-php-test
Github actions CI Symfony/PHP proof concept

The goal of the project is to setup working Symfony 5.* project CI using Github actions.
The actual project contains only single TestController which returns success and functional test which is testing this API call.

Everytime the new code commit is pushed to git - github pulls latest code, run composer and perform test validation.
 
```
on:
 push:
   tags:
     - '!refs/tags/*'
   branches:
     - '*'
   paths-ignore:
     - 'README.md'
jobs:
 run_tests:
   runs-on: [ubuntu-latest]
   steps:
     - name: Setup PHP Action
       uses: shivammathur/setup-php@2.2.1
       with:
         php-version: '7.4'
     - name: Checkout
       uses: actions/checkout@v1
     - name: Install requirements
       run: composer install
     - name: Run tests
       run: php bin/phpunit
```
