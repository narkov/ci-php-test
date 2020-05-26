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


Or publishing realese

```
on:
 release:
   types: [published]

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

  build_and_pub:
    needs: [run_tests]
    runs-on: [ubuntu-latest]
    env:
      LOGIN: ${{ secrets.DOCKER_LOGIN }}
      NAME: ${{ secrets.DOCKER_NAME }}
    steps:
      - name: Login to docker.io
        run:  echo ${{ secrets.DOCKER_PWD }} | docker login -u ${{ secrets.DOCKER_LOGIN }} --password-stdin
      - uses: actions/checkout@master
      - name: Build image
        run: docker build -t $LOGIN/$NAME:${GITHUB_REF:11} -f Dockerfile .
      - name: Push image to docker.io
        run: docker push $LOGIN/$NAME:${GITHUB_REF:11}

  deploy:
    needs: [build_and_pub]
    runs-on: [ubuntu-latest]
    steps:
      - name: Set tag to env
        run: echo ::set-env name=RELEASE_VERSION::$(echo ${GITHUB_REF:11})
```

Hopefully it will be useful for someone who cares.

Cheers
