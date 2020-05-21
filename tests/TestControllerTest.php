<?php

namespace App\Tests\Controller;

use Symfony\Bundle\FrameworkBundle\Test\WebTestCase;

class TestControllerTest extends WebTestCase
{
    public function testShowTest()
    {
        $client = static::createClient();
        $client->request('GET', '/test');
        $this->assertEquals(200, $client->getResponse()->getStatusCode());
    }
}
