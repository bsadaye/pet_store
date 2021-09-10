Feature: Update an existing pet

  Background:
    * url petStoreBaseUrl: 'http://localhost:8080/api/v3'

  # Acceptance Criteria 1
  Scenario: Update an existing pet in store - 200
    * def requestJson = read('../json/request/add-new-pet-successful-request.json')
    * def expected = read('../json/response/update-existing-200.json')
    Given path '/pet'
    When request requestJson
    And method PUT
    Then status 200
    And match response == expected

  # Acceptance Criteria  2
  Scenario Outline: Update an existing pet in store with invalid id - 400
    * def requestJson = read('../json/request/update-existing-request.json')
    * def expected =
    """
    {
      "code": 400,
      "message": "Input error: unable to convert input to io.swagger.petstore.model.Pet"
    }
    """
    * set requestJson.id = '<invalidId>'
    Given path '/pet'
    When request requestJson
    And method PUT
    Then status 400
    And match response == expected

    Examples:
      | invalidId |
      | abc       |
      | 123abc    |
      | %@12      |

  # Acceptance Criteria 3
  Scenario Outline: Search for pet with id that does not exist - 404
    * def requestJson = read('../json/request/update-existing-request.json')
    * def expected = 'Pet not found'
    * set requestJson.id = '<invalidId>'
    Given path '/pet'
    When request requestJson
    And method PUT
    Then status 404
    And match response == expected

    Examples:
      | invalidId |
      | 1000      |
      | 5050      |
      | -124      |

  # Acceptance Criteria 4
  Scenario: Update an existing pet in store with invalid method - 405
    * def requestJson = read('../json/request/update-existing-request.json')
    * def expected =
    """
    {
      "code": 405,
      "message": "HTTP 405 Method Not Allowed"
    }
    """
    Given path '/pet'
    When request requestJson
    And method GET
    Then status 405
    And match response == expected