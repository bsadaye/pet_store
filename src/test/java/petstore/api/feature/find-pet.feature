Feature: Add new pet to the store

  Background:
    * url petStoreBaseUrl: 'http://localhost:8080/api/v3/pet'

  # Acceptance Criteria 8
  Scenario Outline: Find pet by status
    Given path '/findByStatus?status=<status>'
    When method GET
    Then status <statusCode>

    Examples:
      | status    | statusCode |
      | pending   | 200        |
      | available | 200        |
      | sold      | 200        |
      | invalid   | 400        |

  # Acceptance Criteria 9
  Scenario Outline: Find pet by tags
    Given path '/findByTags?tags=<tag>'
    When method GET
    Then status <statusCode>

    Examples:
      | tag     | statusCode |
      | string | 200        |

  # Acceptance Criteria 10
  Scenario Outline: Find pet by Id
    Given path '/<id>'
    When method GET
    Then status <statusCode>

    Examples:
      | id  | statusCode |
      | 1   | 200        |
      | abc | 400        |
      | 898 | 404        |
