Feature: Add new pet to the store

  Background:
    * url petStoreBaseUrl: 'http://localhost:8080/api/v3'

  # Acceptance Criteria 5
  Scenario: Add new pet successful operation - 200
    * def requestJson = read('../json/request/update-existing-request.json')
    * def expected = read('../json/response/add-new-pet-200.json')
    Given path '/pet'
    When request requestJson
    And method POST
    Then status 200
    And match response == expected

  # Acceptance Criteria 6
  Scenario Outline: Add multiple new pets successful operation - 200
    * def requestJson = read('../json/request/update-existing-request.json')
    * def expected = read('../json/response/add-new-pet-200.json')
    * set requestJson.id = <requestId>
    * set requestJson.name = '<requestName>'
    * set expected.id = <responseId>
    * set expected.name = '<responseName>'
    Given path '/pet'
    When request requestJson
    And method POST
    Then status 200
    And match response == expected

    Examples:
      | requestId | requestName | responseId | responseName |
      | 2         | Buddy       | 2          | Buddy        |
      | 3         | Ruby        | 3          | Ruby         |
      | 4         | Oscar       | 4          | Oscar        |

  # Acceptance Criteria 7
  Scenario Outline: Add new pet using invalid methods - 405
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
    And method <method>
    Then status 405
    And match response == expected

    Examples:
      | method |
      | PATCH  |
      | DELETE |
      | GET    |