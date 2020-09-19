Feature: E2E Test - Product

  Background:
    * url baseUrl

  Scenario: OK cases of Product API

  # POST
    Given path '/products'
    And request
    """
      {
        "name" : "Ear Max 2020",
        "description" : "noise cancellation earphone"
      }
    """
    And header Accept = 'application/json'
    When method POST
    Then status 201
    And match header Content-Type == 'application/json;charset=utf-8'
    And match $.id != null
    * def id = $.id

  # GET by id
    Given path '/products/',id
    When method GET
    Then status 200
    And match header Content-Type == 'application/json;charset=utf-8'
    And match $.id == id
    And match $.name == 'Ear Max 2020'
    And match $.description == 'noise cancellation earphone'

  # PUT
    Given path '/products/',id
    And request
    """
      {
        "name" : "Ear Max 2021",
        "description" : "Noise cancellation earphone"
      }
    """
    And header Accept = 'application/json'
    When method PATCH
    Then status 200
    And match header Content-Type == 'application/json;charset=utf-8'
    And match $.id == id
    And match $.name == 'Ear Max 2021'
    And match $.description == 'Noise cancellation earphone'

  # GET all
    Given path '/products'
    * def filters =
    """
      {
        "id": id
      }
    """
    And param filters = toString()
    When method GET
    Then status 200
    And match header Content-Type == 'application/json;charset=utf-8'
    And match header X-Total-Count == '1'
    And match header X-Result-Count == '1'
    And match $[0].id == id
    And match $[0].name == 'Ear Max 2021'
    And match $[0].description == 'Noise cancellation earphone'

  # PUT
    Given path '/products/',id
    When method DELETE
    Then status 200
    And match header Content-Type == 'application/json;charset=utf-8'